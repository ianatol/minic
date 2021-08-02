use std::collections::{HashMap,HashSet};

use super::super::lexer::Token;
use super::super::ast::*;
use super::super::instruction::*;
use super::UniqueNameFactory;
use super::cfg_builder::{CFG,CFBlockTerminator,CFFunction};
use super::arm_generator::get_arm_global_header;
use super::super::Optimization;
use super::super::dataflow::*;

// use super::cfg_builder::CFBlock;

pub enum Arch {
    I32,
    I64,
}


#[derive(PartialEq)]
pub enum SSAMode {
    Stack,
    Register,
}

#[derive(PartialEq)]
pub enum CompileTarget {
    ARM,
    LLVM,
}

#[derive(Debug,Clone)]
pub struct PhiOperand {
    pub block_id:String,
    pub reg_id:Option<String> // Some(register id from that block) or None (meaning not found or we asked an unprocessed block)
}

#[derive(Debug,Clone)]
pub struct Phi {
    pub source_id:String,
    pub datatype:Datatype,
    pub operands:Vec<PhiOperand>
}

enum LaticeValue {
    Top,
    Number(i32),
    Bottom
}

impl Phi {
    pub fn new(source_id:String, datatype:Datatype) -> Self {
        Phi {
            source_id,
            datatype,
            operands:Vec::new(),
        }
    }

    // assigned_reg is the register this Phi is assigned to so that we know to remove it from the set
    pub fn check_trivial(&self, assigned_reg:&str) -> Option<String> {
        let mut reg_set:HashSet<String> = HashSet::new();
        for oper in &self.operands {
            match &oper.reg_id {
                Some(reg_id) => { reg_set.insert(reg_id.clone()); },
                None => panic!("We shouldn't have Nones in the Phi operands by this point"),
            }
        }
        // Remove the register we're assigning to
        reg_set.remove(assigned_reg);
        // At this point, if there's 1 or 0 left, then it's trivial
        // println!("The phi has these registers {:?}", reg_set);
        match reg_set.len() {
            0 => panic!("We can't have phis with no operands"),
            1 => {
                Some(reg_set.iter().cloned().collect::<Vec<String>>()[0].clone())
            }
            _ => return None,
        }
    }

    pub fn replace_register(&mut self, old_id:&str, new_id:&str) {
        println!("  Checking {:?} for replacement of {} with {}",self,old_id,new_id);
        let mut new_operands:Vec<PhiOperand> = Vec::new();
        for oper in &self.operands {
            let mut new_oper = oper.clone();
            match &oper.reg_id {
                Some(reg_id) => {
                    if reg_id == old_id {
                        // println!("Replacing {} with {} in a phi", old_id, new_id);
                        new_oper.reg_id = Some(new_id.to_string());
                    }
                },
                None => {}
            }
            new_operands.push(new_oper);
        }
        self.operands = new_operands;
    }

    pub fn get_reg_id_for_block_id(&self, block_id:&str) -> String {
        for oper in &self.operands {
            if oper.block_id == block_id {
                return oper.reg_id.clone().unwrap();
            }
        }
        panic!("Couldn't find block_id {} in {:?}", block_id, self);
    }

    pub fn get_gen_set(&self) -> HashSet<String> {
        let mut gen:HashSet<String> = HashSet::new();
        for oper in &self.operands {
            gen.insert(oper.reg_id.clone().unwrap());
        }
        gen
    }

    pub fn is_critical(&self, critical_regs:&HashSet<String>, assigned_reg:&str) -> Option<HashSet<String>> {
        let mut new_crit_regs:HashSet<String> = HashSet::new();
        if critical_regs.contains(assigned_reg) {
            for oper in &self.operands {
                new_crit_regs.insert(oper.reg_id.clone().unwrap());
            }
            Some(new_crit_regs)
        } else {
            None
        }
    }

    pub fn resolve(&self, all_virtual_regs:&HashSet<String>, known_virt_reg_values:&HashMap<String,LLVMOperand>) -> Option<LLVMOperand> {
        let mut current_value = LaticeValue::Top;
        for oper in &self.operands {
            let llvm_operand = super::super::instruction::resolve_local_register(string_to_llvm_operand(&oper.reg_id.clone().unwrap(), all_virtual_regs), known_virt_reg_values);
            match (llvm_operand, &current_value) {
                (LLVMOperand::Number(new_num), LaticeValue::Number(cur_num)) => {
                    if new_num != *cur_num {
                        println!("We got conflicting values for the phi");
                        current_value = LaticeValue::Bottom;
                    }
                },
                (LLVMOperand::Number(new_num), LaticeValue::Top) => {
                    // We haven't seen any values for this, before
                    current_value = LaticeValue::Number(new_num);
                },
                (_,_) => {
                    // If the phi has anything else (globals, locals with unknown values), then it's bottom.
                    current_value = LaticeValue::Bottom;
                }
            }
        }
        // At this point, current_value should either be Top (we never found anything about any register in the phi)
        // or Number (all phi operands were discovered to be the same number), or Bottom (meaning that we discovered
        // some phi operands which were known to have different values)
        match current_value {
            LaticeValue::Top => None,
            LaticeValue::Bottom => None,
            LaticeValue::Number(num) => Some(LLVMOperand::Number(num))
        }
    }
}

pub type ValueSpec = Decl;

pub struct GlobalContext {
    pub structs: HashMap<String, Vec<ValueSpec>>,
    pub globals: HashMap<String, ValueSpec>,
    // function signatures is the datatypes of the params and the return datatype
    pub function_signatures: HashMap<String, (Vec<Datatype>,Datatype)>,
    pub arch:Arch,
    pub ssa_mode:SSAMode,
    pub optimizations:HashSet<Optimization>,
}

impl GlobalContext {
    // Return a comma-separated list of the types
    pub fn get_llvm_type_of_struct(&self, struct_id:&str) -> String {
        let fields = self.structs.get(struct_id).unwrap();
        fields.iter().map(|val_spec| val_spec.get_llvm_type(&self.arch)).collect::<Vec<String>>().join(", ")
    }

    fn get_index_of_struct_field(&self, struct_id:&str, field_id:&str) -> usize {
        // println!("Getting index of field {} from struct {}",field_id, struct_id);
        let fields = self.structs.get(struct_id).unwrap();
        fields.iter().position(|decl| decl.id.eq(field_id)).unwrap()
    }

    fn get_datatype_of_struct_field(&self, struct_id:&str, field_id:&str) -> Datatype {
        let fields = self.structs.get(struct_id).unwrap();
        fields.iter().find(|decl| decl.id.eq(field_id)).and_then(|decl| Some(decl.datatype.clone())).unwrap()
    }

    fn get_size_of_struct(&self, struct_id:&str) -> u32 {
        let fields = self.structs.get(struct_id).unwrap(); // fields is a Vec<ValueSpec>
        let mut total = 0;
        for field in fields {
            total = total + field.datatype.get_size_in_bytes(&self.arch);
        }
        total
    }
    
    // // Print out the datatypes of all globals
    // fn check_vars(&self) {
    //     for var_id in self.globals.keys() {
    //         self.check_var(var_id);
    //     }
    // }

    // fn check_var(&self, var_id:&str) {
    //     let var_spec = self.globals.get(var_id).unwrap();
    //     match var_spec.datatype {
    //         _ => println!("GLOBAL CHECK : {} = {:?}", var_spec.id, var_spec.datatype),
    //     }
    // }
}

pub struct LLVMFunctionContext {
    pub function_symbol_tables: HashMap<String, VariableTable>, //Maps block id to that block's symbol table
    // blocks: HashMap<String, super::cfg_builder::CFBlock>,
    pub localtypes: HashMap<String, Datatype>,
    pub initialvals: HashMap<String, usize>, // For variables from parms, which parameter, positionally, are we drawing from?
    //parms: ParmList,
    pub return_value_id: String, // What name are we using the in the symbol tables for the return value?
    // return_value_datatype: Datatype, 
    // return_spec: ValueSpec,
    pub var_name_factory: UniqueNameFactory,
    // instructions:HashMap<String,Vec<String>>, // block_id -> Vec of strings 
    pub phis:HashMap<String,HashMap<String, Phi>>, // block_id -> (register_id_referenced_by_a_source_symbol_in_this_block -> Phi(with type and operands))
}

impl LLVMFunctionContext {
    pub fn print_all_symbol_tables(&self) {
        println!("======= ALL TABLES =======");
        for (block_id, var_table) in &self.function_symbol_tables {
            println!("==== Symbol table for {} ====", block_id);
            var_table.print_table();
        }
    }

    pub fn datatype_of(&self, var_id:&str) -> Datatype {
        // println!("Getting datatype of {}",var_id);
        self.localtypes.get(var_id).unwrap().clone()
    }

    pub fn get_phis_for_block(&mut self, block_id:&str) -> &mut HashMap<String, Phi> {
        if ! self.phis.contains_key(block_id) {
            // println!("Block {} didn't have a phi table. Creating one", block_id);
            self.phis.insert(block_id.to_string(), HashMap::new());
        }
        self.phis.get_mut(block_id).unwrap()
    }

    pub fn add_phi_to_block(&mut self, block_id:&str, reg_id:&str, phi:Phi) {
        // println!("Adding PHI for {} to block {}", reg_id, block_id);
        let phis = self.get_phis_for_block(block_id);
        phis.insert(reg_id.to_string(), phi);
        self.check_for_empty_phis();
    }

    pub fn print_all_phis(&self) {
        for (block_id,phis) in &self.phis {
            println!(" == Phis for {} == ", block_id);
            for (phi_reg, phi_operands) in phis {
                println!("    {:?}", phi_reg);
            }
        }
    }

    pub fn count_unresolved_phis(&self) -> u32 {
        let mut count = 0;

        for (block_id,block_phi_map) in &self.phis {
            for (reg_id,phi) in block_phi_map {
                for oper in &phi.operands {
                    match oper.reg_id {
                        None => {
                            count += 1;
                            break;
                        },
                        Some(_) => {}
                    }
                }
            }
        }
        count
    }

    pub fn check_for_empty_phis(&self) {
        for (block_id,block_phi_map) in &self.phis {
            for (reg_id,phi) in block_phi_map {
                if phi.operands.len() == 0 {
                    panic!("Phi for {} - {} had no operands", block_id, reg_id);
                }
            }
        }
    }

    pub fn write_variable(&mut self, cf_func:&CFFunction, block_id:&str, source_id:&str, reg_id:&str) {
        if ! self.localtypes.contains_key(source_id) {
            panic!("Tried to store a variable {} which wasn't found in localtypes", source_id);
        }
        // println!("Writing {} to block:{} and id:{}", reg_id, block_id, source_id);
        // If the block doesn't have a symbol table, give it an empty one
        if ! self.function_symbol_tables.contains_key(block_id) {
            // println!("Block {} was missing its symbol table", block_id);
            self.function_symbol_tables.insert(block_id.to_string(), VariableTable::new());
        }
        let table = self.function_symbol_tables.get_mut(block_id).unwrap();
        var_table_insert(table, source_id, reg_id);
        //self.function_symbol_tables.get_mut(block_id).unwrap().insert(var_id, val);
    }

    pub fn read_variable(&mut self, cf_func:&CFFunction, ssa_mode:&SSAMode, block_id:&str, var_id:&str) -> Option<String> {
        // println!("read_variable: block_id:{}   var_id:{}", block_id, var_id);
        match ssa_mode {
            SSAMode::Stack => {
                // Get the symbol table from the start block. Everything should be there
                let table = self.function_symbol_tables.get(&cf_func.start_block).unwrap();
                var_table_get(table, var_id)
            },
            SSAMode::Register => {
                //match self.function_symbol_tables[block_id].get(var_id)
                if ! self.function_symbol_tables.contains_key(block_id) {
                    // println!("Block {} was missing its symbol table", block_id);
                    self.function_symbol_tables.insert(block_id.to_string(), VariableTable::new());
                }
                let table = self.function_symbol_tables.get(block_id).unwrap();
                match var_table_get(table, var_id) {
                    Some(reg_id) => {
                        // println!("found it! It's {}", reg_id); 
                        Some(reg_id.clone()) 
                    },
                    None => { 
                        // println!("Didn't find it. Recursing from {}", block_id);
                        let val = self.read_variable_recursive(cf_func, ssa_mode, block_id, var_id);
                        // println!("Recurse from {} finished with {:?}",block_id,val); 
                        val 
                    },
                }
            },
        }
    }

    fn read_variable_recursive(&mut self, cf_func:&CFFunction, ssa_mode:&SSAMode, block_id:&str, var_id:&str) -> Option<String>{
        // println!("read_variable_recursive: block_id: {}   var_id: {}", block_id, var_id);
        //we can ignore sealed block clause because our blocks should be automatically sealed
        // println!("We're trying to find block {}", block_id);
        match cf_func.blocks[block_id].preds.len() {
            // No preds. There's nobody else to ask for this symbol. It's not a local var
            0 => None,
                // One pred. No phi needed.
            1 => {
                // println!("1 pred");
                for pred in cf_func.blocks[block_id].preds.clone() {
                    return self.read_variable(cf_func, ssa_mode, &pred, var_id)
                }
                // This will never be reached, but rustc doesn't realize that, so we put this here
                panic!("This will never be reached");
            },
            // Multiple preds. So, we ask all preds for what register they use for var_id
            _ => {
                // println!("Multiple preds");
                // Step one: decide on a register which is going to hold the phi for var_id
                let new_reg_id = self.var_name_factory.next();
                self.write_variable(cf_func, block_id, var_id, &new_reg_id);

                let datatype = self.datatype_of(var_id);
                let mut phi = Phi::new(var_id.to_string(), datatype);
                for pred_id in cf_func.blocks[block_id].preds.clone() {
                    phi.operands.push(
                        PhiOperand {
                            block_id:pred_id.clone(),
                            reg_id:None
                        }
                    );
                }
                self.add_phi_to_block(block_id, &new_reg_id, phi);
                Some(new_reg_id)
            }
        }
    }
}


//Symbol Table for a single block
pub struct VariableTable {
    pub variables: HashMap<String, String>,
}

impl VariableTable {
    pub fn new() -> Self {
        VariableTable {
            variables: HashMap::new(),
        }
    }

    pub fn print_table(&self) {
        for (source_id, reg_id) in &self.variables {
            println!("{} is {}", source_id, reg_id);
        }
    }
}

// fn var_table_get_mut(table:&mut VariableTable, id:String) -> Option<&mut ValueSpec> {
//     table.variables.get_mut(&id)
// }

fn var_table_get(table:&VariableTable, id:&str) -> Option<String>{
    table.variables.get(id).cloned()
}

fn var_table_insert(table:&mut VariableTable, id:&str, reg_id:&str) {
    table.variables.insert(id.to_string(), reg_id.to_string());
}

#[derive(Clone)]
struct ParmList(Vec<Decl>);

// impl ParmList {
//     fn new() -> ParmList {
//         ParmList(Vec::new())
//     }

//     fn contains_id(&self, id:&str) -> bool {
//         self.get_decl_with_id(id).is_some()
//     }

//     fn get_llvm_type_of(&self, id:&str, arch:&Arch) -> Option<String> {
//         self.get_decl_with_id(id).and_then(|decl:&Decl| Some(decl.get_llvm_type(arch)))
//     }

//     fn get_decl_with_id(&self, id:&str) -> Option<&Decl> {
//         self.0.iter().find(|decl| decl.id.eq(&id))
//     }
// }

fn get_llvm_global_header(cfg:&CFG, global_context:&mut GlobalContext) -> Vec<String> {
    let mut text_instructions:Vec<String> = Vec::new();
    let int_size = Datatype::Int.get_llvm_type(&global_context.arch);
    text_instructions.push("; External helper functions".to_string());
    text_instructions.push(format!("declare void @printInt({} nocapture, i1 nocapture) nounwind", int_size));
    text_instructions.push(format!("declare {0} @parmTest({0} nocapture, {0} nocapture, {0} nocapture, {0} nocapture, {0} nocapture, {0} nocapture, {0} nocapture, {0} nocapture, {0} nocapture) nounwind", int_size));
    text_instructions.push(format!("declare {} @readInt() nounwind", int_size));
    text_instructions.push("declare void @free(i8*) nounwind".to_string());
    text_instructions.push(format!("declare i8* @malloc({}) nounwind", int_size));
    text_instructions.push("".to_string());

    text_instructions.push("; Structs/typedefs".to_string());
    for type_ in &cfg.types {
        // Make a comma-separated list of llvm types in this struct
        let typelist = global_context.get_llvm_type_of_struct(&type_.id);

        //Begin struct declaration
        text_instructions.push(format!("%struct.{} = type {{",type_.id));
        text_instructions.push(format!("{}",typelist));
        text_instructions.push("}".to_string());
    }
    text_instructions.push("".to_string());

    // Next, generate the global vars
    text_instructions.push("; Global variables".to_string());
    for decl in &cfg.declarations {
        let id = format!("@{}",decl.id);
        let mut datatype = decl.datatype.clone();

        // If it's a struct, declare it as a pointer. Otherwise, allocate it directly
        match &datatype {
            Datatype::Structure{id:_} => datatype = Datatype::Ref(Box::new(datatype)),
            _ => {},
        };            
        
        text_instructions.push(format!("{} = common global {} {}",id.clone(),datatype.clone().get_llvm_type(&global_context.arch),datatype.get_llvm_default_value()));

        //Generate LLVM decls
        let valspec = ValueSpec {
            id:id.clone(),
            datatype:Datatype::Ref(Box::new(datatype.clone())),
        };

        //Save global vars in their symbol table
        global_context.globals.insert(decl.id.clone(), valspec);
    }

    text_instructions
}

impl CFG {
    // Returns new current block
    pub fn compile(&mut self, instructions:&mut Vec<String>, arch:Arch, ssa_mode:SSAMode, compile_target:CompileTarget, optimizations:&HashSet<Optimization>) {
        if compile_target == CompileTarget::ARM && ssa_mode == SSAMode::Stack {
            panic!("Don't use stack mode with assembly output");            
        }

        // First, generate the type definitions (structs)
        // TODO create structs table

        let mut global_context = GlobalContext {
            structs: HashMap::new(),
            globals: HashMap::new(),
            function_signatures: HashMap::new(),
            arch,
            ssa_mode,
            optimizations:optimizations.clone(),
        };
        // Manually provide for an external function
        global_context.function_signatures.insert(
            "parmTest".to_string(),
            (vec![Datatype::Int, Datatype::Int, Datatype::Int, Datatype::Int, Datatype::Int, Datatype::Int, Datatype::Int, Datatype::Int, Datatype::Int], Datatype::Int)
        );

        // Build the structs and put them in the global context
        for type_ in &self.types {
            // Build a vec of the ValueSpecs
            let mut fields = Vec::<ValueSpec>::new();
            for decl in &type_.decls {
                fields.push(
                    ValueSpec{
                        id:decl.id.clone(),
                        // If it's a struct, we store it as a reference
                        datatype:
                            match decl.datatype.clone() {
                                Datatype::Structure{id} => Datatype::Ref(Box::new(decl.datatype.clone())),
                                _ => decl.datatype.clone(),
                            }
                    }
                );
            }
            global_context.structs.insert(type_.id.clone(), fields);
        }

        let header_instructions = match compile_target {
            CompileTarget::LLVM => get_llvm_global_header(&self,&mut global_context),
            CompileTarget::ARM => get_arm_global_header(&self,&mut global_context),
        };
        instructions.extend(header_instructions);

        // Note the return types of all functions so that call knows what type to allocate
        for (id, func) in &self.functions {
            global_context.function_signatures.insert(
                id.to_string(),
                (
                    func.parms.iter().map(|decl| decl.datatype.clone()).collect(),
                    func.ret_type.clone()
                )
            );
        }
        instructions.push("".to_string());

        // Now, do all of the functions
        for id in self.functions.clone().keys() {
            println!("== Processing function {}", id);
            let func = self.functions.get_mut(id).unwrap();
            let function_instructions:Vec<String> = match compile_target {
                CompileTarget::LLVM => func.gen_llvm_code(&id, &mut global_context),
                CompileTarget::ARM => func.gen_arm_code(&id, &mut global_context),
            };
            instructions.extend(function_instructions);
        }
    }
}

pub fn remove_trivial_phis(block_instructions:&mut HashMap<String,Vec<Instruction>>, phis:&mut HashMap<String,HashMap<String,Phi>>) {
    //
    // Remove trivial phis
    //
    let remove_trivial_phis = true;
    if remove_trivial_phis {
        let mut changed = true;
        while changed {
            changed = false;
            let mut replacements:Vec<(String,String)> = Vec::new();
            for block_id in phis.clone().keys() {
                let block_phis = phis.get_mut(block_id).unwrap();
                // Generate a vector of pairs of phi registers and what we can replace them with, if any
                replacements.extend(block_phis.iter().map(|(k,v)| (k.clone(), v.check_trivial(&k))).filter(|(k,v)| v.is_some()).map(|(k,v)| (k,v.unwrap())).collect::<Vec<(String,String)>>());
                for (old_reg,new_reg) in &replacements {
                    changed = true;
                    println!("We can replace {} with {}", old_reg, new_reg);
                    block_phis.remove(old_reg);
                }
                // If this block had trivial phis, break out so that we can do replacements in other blocks.
                // We want to avoid removing phis from multiple blocks or we might end up with chained variable replacements
                if replacements.len() > 0 {
                    break;
                }
            }

            println!("Replacing registers in other phis...");
            for block_phis in phis.values_mut() {
                for phi in block_phis.values_mut() {
                    for (old_reg,new_reg) in &replacements {
                        println!("==> Replacing {} with {} in {:?}",old_reg,new_reg,phi);
                        phi.replace_register(&old_reg, &new_reg); 
                    }
                }
            }

            println!("Replacing registers in other instructions...");
            for cur_block_id in block_instructions.clone().keys() {
                let mut new_instructions:Vec<Instruction> = Vec::new();
                // Build new_instructions from the block's instructions, after replacing registers
                for instruction in &block_instructions[cur_block_id] {
                    let mut new_instruction = instruction.clone();
                    for (old_reg,new_reg) in &replacements {
                        new_instruction = new_instruction.replace(old_reg,new_reg);
                    }
                    new_instructions.push(new_instruction);
                }
                block_instructions.insert(cur_block_id.to_string(), new_instructions);
            }
        }    
    }
}

pub fn instructions_to_llvm(block_instructions:&mut HashMap<String,Vec<Instruction>>, phis:&mut HashMap<String,HashMap<String,Phi>>, block_order:&Vec<String>, arch:&Arch, ssa_mode:&SSAMode, optimizations:&HashSet<Optimization>) -> Vec<String> {
    let mut instructions:Vec<String> = Vec::new();

    // Now, put the phis and block code in the function instructions
    for cur_block_id in block_order {
        instructions.push(format!(""));

        // We don't put the start block's label here. We put it at the top of the function (to avoid needing a branch after the locals/parms setup)
        if *cur_block_id != block_order[0] {
            instructions.push(format!("{}:",cur_block_id));
        }
        // self.instructions.push("    ; CFBlock start".to_string());

        // Add the phis for this block
        if phis.contains_key(cur_block_id) {
            for (reg_id,phi) in &phis[cur_block_id] {
                // println!("Processing phi: {} {:?}", reg_id, phi);
                let llvm_phi_operands:String = phi.operands.iter().map(|operand| format!("[{}, %{}]", operand.reg_id.clone().unwrap(), operand.block_id)).collect::<Vec<String>>().join(", ");
                instructions.push(format!("    {} = phi {} {}", reg_id, phi.datatype.get_llvm_type(arch), llvm_phi_operands));
            }    
        }

        // Now add the block's instructions
        // println!("== Putting block instructions after phis ==");
        for instruction in &block_instructions[cur_block_id] {
            instructions.extend(instruction.as_llvm(arch, ssa_mode, &optimizations));
        }
        // instructions.extend(block_instructions.get(cur_block_id).unwrap());
        instructions.push(format!(""));
    }

    instructions.push("}".to_string());
    instructions
}

impl super::cfg_builder::CFFunction {
    //CFFunction:
    //
    // Returns new current block
    pub fn gen_llvm_code(&mut self, func_id:&str, global_context:&mut GlobalContext) -> Vec<String> {
        let mut text_instructions:Vec<String> = Vec::new();

        let var_name_factory = UniqueNameFactory::new(format!("%v"));

        let mut function_context = LLVMFunctionContext {
            function_symbol_tables:HashMap::new(),
            localtypes: HashMap::new(),
            initialvals: HashMap::new(),
            phis: HashMap::new(),
            return_value_id: String::from("%_retval"),
            // return_value_datatype: self.ret_type.clone(),
            var_name_factory,
        };
        // function_context.print_all_symbol_tables();
        self.build_parms_and_locals(func_id, &mut text_instructions, global_context, &mut function_context);
        let mut block_instructions = self.build_instructions(func_id, global_context, &mut function_context);
        self.resolve_phis(func_id, global_context, &mut function_context);

        if global_context.optimizations.contains(&Optimization::ConstantPropagation) {
            super::cfg_visitor::propagate_constants(&mut function_context, &mut block_instructions);            
        }

        let mut data_flow = get_data_flow(&self, &function_context, &block_instructions);
        build_live_in_out(&self, &mut data_flow);

        if global_context.optimizations.contains(&Optimization::DeadCodeRemoval) {
            let mut need_data_flow = remove_non_critical_instructions(&mut function_context, &mut block_instructions, &data_flow);
            while need_data_flow {
                println!("Re-doing data flow analysis");
                data_flow = get_data_flow(&self, &function_context, &block_instructions);
                build_live_in_out(&self, &mut data_flow);
                need_data_flow = remove_non_critical_instructions(&mut function_context, &mut block_instructions, &data_flow);    
            }    
        }

        if global_context.optimizations.contains(&Optimization::RemoveTrivialPhis) {
            remove_trivial_phis(&mut block_instructions, &mut function_context.phis);
            let mut need_data_flow = true;
            while need_data_flow {
                println!("Re-doing data flow analysis");
                data_flow = get_data_flow(&self, &function_context, &block_instructions);
                build_live_in_out(&self, &mut data_flow);
                need_data_flow = remove_non_critical_instructions(&mut function_context, &mut block_instructions, &data_flow);    
            }    
        }
        let instruction_text = instructions_to_llvm(&mut block_instructions, &mut function_context.phis, &self.block_order, &global_context.arch, &global_context.ssa_mode, &global_context.optimizations);
        text_instructions.extend(instruction_text);
        // self.remove_trivial_phis(func_id, &mut instructions, global_context, &mut function_context);
        // self.instructions_to_llvm(func_id, &mut instructions, global_context, &mut function_context);

        text_instructions
    }

    pub fn build_parms_and_locals(&mut self, func_id:&str, instructions:&mut Vec<String>, global_context:&mut GlobalContext, function_context:&mut LLVMFunctionContext) {
        //Generate code for function header, allocate space for retval
        let parmlist = self.parms.clone().iter().map(|decl| decl.get_llvm_type(&global_context.arch) + " %" + &decl.id).collect::<Vec<String>>().join(", ");
        println!("Parm list is : {:?}", parmlist);
        // Start outputting the function
        instructions.push(format!("define {} @{}({}) {{",&self.ret_type.get_llvm_type(&global_context.arch), func_id, parmlist));
        instructions.push(format!("{}:",self.start_block));
        
        // Set the datatype of the return value
        function_context.localtypes.insert(function_context.return_value_id.clone(), self.ret_type.clone());
        // Don't allocate void return types
        if !function_context.datatype_of(&function_context.return_value_id).eq(&Datatype::Void) {
            // And don't allocate for register mode
            match global_context.ssa_mode {
                SSAMode::Register => {},
                SSAMode::Stack => {
                    instructions.push(format!("    {} = alloca {} ; _retval", function_context.return_value_id, function_context.datatype_of(&function_context.return_value_id).get_llvm_type(&global_context.arch)));
                }
            }
        }

        //allocate all params
        // Put substitute local variables for them in the local symbol table and load them with what was passed to us
        // Remember, this maps source-code variable names to their llvm names/types
        instructions.push("; Allocating parameters".to_string());

        //function_context.parms = ParmList(self.parms.clone());

        //
        // PARAMS
        //
        for (pos,decl) in self.parms.clone().iter().enumerate() {
            // Whether we track them in registers or the stack, Structures are by reference
            let allocated_type = match &decl.datatype {
                Datatype::Structure{ref id} => {
                    Datatype::Ref(Box::new(decl.datatype.clone()))
                },
                _ => decl.datatype.clone()
            };

            let table_entry:Decl = match global_context.ssa_mode {
                SSAMode::Stack => {
                    // We select a variable to hold the address of the place on the stack to hold the parameter
                    let reg_id = function_context.var_name_factory.next();

                    // With stack-based, registers are pointers to the place on the stack
                    let reg_var_type = Datatype::Ref(Box::new(allocated_type.clone()));

                    // Generate the llvm code for them
                    match &reg_var_type {
                        Datatype::Ref(ref inner) => {
                            // Allocate the space for it on the stack
                            instructions.push(format!("    {} = alloca {}, align 4 ; {}", &reg_id, allocated_type.get_llvm_type(&global_context.arch), decl.id));
                            instructions.push(format!("    store {0} %{1}, {0}* {2}, align 4", allocated_type.get_llvm_type(&global_context.arch), decl.id, reg_id));
                        },
                        _ => panic! ("All local variables must be references"),
                    }
                    function_context.initialvals.insert(reg_id.clone(), pos);
                    // Return an id/datatype pair which represents the register we just stored the parameter in
                    Decl {
                        id: reg_id,
                        datatype: reg_var_type
                    }
                },
                SSAMode::Register => {
                    // Register-based, we don't put it on the stack, so we just use it, directly
                    Decl {
                        id: format!("%{}", decl.id),
                        datatype: allocated_type
                    }
                }
            };

            // Lastly, add it to the start block's symbol table
            //function_context.function_symbol_tables.get_mut(&self.start_block).unwrap().insert(&decl.id, val_spec);
            // function_context.localtypes.insert(decl.id.clone(), reg_var_type);
            // function_context.write_variable(self, &self.start_block, &decl.id.clone(), &reg_id);
            function_context.localtypes.insert(decl.id.clone(), table_entry.datatype.clone());
            function_context.write_variable(self, &self.start_block, &decl.id.clone(), &table_entry.id.clone());

        }

        //
        // LOCALS
        //
        // Put all local variables in the local symbol table
        // Remember, this maps source-code variable names to their llvm register id's
        instructions.push("; Allocating locals".to_string());
        for decl in self.decls.clone() {
            // Whether we track them in registers or the stack, Structures are by reference
            let allocated_type = match &decl.datatype {
                    Datatype::Structure{ref id} => {
                        Datatype::Ref(Box::new(decl.datatype.clone()))
                    },
                    _ => decl.datatype.clone()
                };


            let table_entry:Decl = match global_context.ssa_mode {
                SSAMode::Stack => {
                    // We select a variable to hold the address of the place on the stack to hold the parameter
                    let reg_id = function_context.var_name_factory.next();

                    // With stack-based, registers are pointers to the place on the stack
                    let reg_var_type = Datatype::Ref(Box::new(allocated_type.clone()));

                    // Generate the llvm code for them
                    match &reg_var_type {
                        Datatype::Ref(ref inner) => {
                            // Allocate the space for it on the stack
                            instructions.push(format!("    {} = alloca {}, align 4 ; {}", &reg_id, allocated_type.get_llvm_type(&global_context.arch), decl.id));
                            // instructions.push(format!("    store {0} %{1}, {0}* {2}, align 4", allocated_type.get_llvm_type(&global_context.arch), decl.id, reg_id));
                        },
                        _ => panic! ("All local variables must be references"),
                    }
                    // Return an id/datatype pair which represents the register we just stored the parameter in
                    Decl {
                        id: reg_id,
                        datatype: reg_var_type
                    }
                },
                SSAMode::Register => {
                    // Register-based, we don't put it on the stack, so we just use it, directly
                    Decl {
                        id: format!("%{}", decl.id),
                        datatype: allocated_type
                    }
                }
            };

            // Lastly, add it to the start block's symbol table
            //function_context.function_symbol_tables.get_mut(&self.start_block).unwrap().insert(&decl.id, val_spec);
            // function_context.localtypes.insert(decl.id.clone(), reg_var_type);
            // function_context.write_variable(self, &self.start_block, &decl.id.clone(), &reg_id);
            function_context.localtypes.insert(decl.id.clone(), table_entry.datatype.clone());
            function_context.write_variable(self, &self.start_block, &decl.id.clone(), &table_entry.id.clone());
        }

        // We don't need this anymore, because the start block's label is the first thing in the function
        // instructions.push(format!("    br label %{}_start",id));
    }

    pub fn build_instructions(&mut self, func_id:&str, global_context:&mut GlobalContext, function_context:&mut LLVMFunctionContext) -> HashMap<String,Vec<Instruction>> {
        //
        // Here, CFBlocks produce their own instruction vectors and phis
        //
        let mut block_instructions:HashMap<String,Vec<Instruction>> = HashMap::new();
        for cur_block_id in &self.block_order {
            // println!("Processing block {}",cur_block_id);
            let block = self.blocks.get(cur_block_id).unwrap();

            block_instructions.insert(
                cur_block_id.to_string(),
                block.gen_instructions(&cur_block_id, self, global_context, function_context)
            );
        }
        block_instructions
    }


    // Resolve phis
    pub fn resolve_phis(&mut self, func_id:&str, global_context:&mut GlobalContext, function_context:&mut LLVMFunctionContext) {
        // At this point, all block symbol tables are complete
        while function_context.count_unresolved_phis() > 0 {
            function_context.check_for_empty_phis();
            // We have to make a copy of all of phis to get around Rust's borrow checker hanging up on duplicate uses of function_context        
            let mut phis_to_do:Vec<(String, String, Phi)> = Vec::new();
            for cur_block_id in &self.block_order {
                for (reg_id,phi) in function_context.get_phis_for_block(cur_block_id) {
                    // println!("phis_to_do: pushing {} {}", cur_block_id, reg_id);
                    phis_to_do.push((cur_block_id.clone(), reg_id.clone(), phi.clone()));
                }
            }

            for (block_id, reg_id, phi) in phis_to_do {
                let mut new_phi = Phi::new(phi.source_id.clone(), phi.datatype.clone());
                for oper in &phi.operands {
                    match oper.reg_id {
                        // If this operand was already resolved, then just copy it to the new phi
                        Some(_) => new_phi.operands.push(oper.clone()),
                        // If it's not resolved, resolve it now and place the new operand in the new phi
                        None => {
                            // We need to ask block oper.block_id for the register it uses for phi.source_id
                            // println!("Block {} needs to ask block {} about what it has for {}", block_id, oper.block_id, phi.source_id);
                            match function_context.read_variable(self, &global_context.ssa_mode, &oper.block_id, &phi.source_id) {
                                None => panic!("We shouldn't be unable to resolve a phi, at this point"),
                                Some(new_val) => {
                                    let new_oper = PhiOperand {
                                        block_id:oper.block_id.clone(),
                                        reg_id:Some(new_val)
                                    };
                                    new_phi.operands.push(new_oper);
                                }
                            }
                        }
                    }
                }
                // Replace the old, empty phi with the populated one
                // println!("New phi for {} - {} is {:?}", block_id, reg_id, new_phi);  
                function_context.add_phi_to_block(&block_id, &reg_id, new_phi);
            }
        }
    }

    // pub fn remove_trivial_phis(&mut self, func_id:&str, instructions:&mut Vec<String>, global_context:&mut GlobalContext, function_context:&mut LLVMFunctionContext) {
    //     //
    //     // Remove trivial phis
    //     //
    //     let remove_trivial_phis = true;
    //     if remove_trivial_phis {
    //         let mut changed = true;
    //         while changed {
    //             changed = false;
    //             let mut replacements:Vec<(String,String)> = Vec::new();
    //             for block_id in function_context.phis.clone().keys() {
    //                 let block_phis = function_context.phis.get_mut(block_id).unwrap();
    //                 // Generate a vector of pairs of phi registers and what we can replace them with, if any
    //                 replacements.extend(block_phis.iter().map(|(k,v)| (k.clone(), v.check_trivial(&k))).filter(|(k,v)| v.is_some()).map(|(k,v)| (k,v.unwrap())).collect::<Vec<(String,String)>>());
    //                 for (old_reg,new_reg) in &replacements {
    //                     changed = true;
    //                     println!("We can replace {} with {}", old_reg, new_reg);
    //                     block_phis.remove(old_reg);
    //                 }
    //                 // If this block had trivial phis, break out so that we can do replacements in other blocks.
    //                 // We want to avoid removing phis from multiple blocks or we might end up with chained variable replacements
    //                 if replacements.len() > 0 {
    //                     break;
    //                 }
    //             }

    //             println!("Replacing registers in other phis...");
    //             for block_phis in function_context.phis.values_mut() {
    //                 for phi in block_phis.values_mut() {
    //                     for (old_reg,new_reg) in &replacements {
    //                         println!("==> Replacing {} with {} in {:?}",old_reg,new_reg,phi);
    //                         phi.replace_register(&old_reg, &new_reg); 
    //                     }
    //                 }
    //             }

    //             println!("Replacing registers in other instructions...");
    //             for block in self.blocks.values_mut() {
    //                 let mut new_instructions:Vec<Instruction> = Vec::new();
    //                 // Build new_instructions from the block's instructions, after replacing registers
    //                 for instruction in &block.instructions {
    //                     let mut new_instruction = instruction.clone();
    //                     for (old_reg,new_reg) in &replacements {
    //                         new_instruction = new_instruction.replace(old_reg,new_reg);
    //                     }
    //                     new_instructions.push(new_instruction);
    //                 }
    //                 block.instructions = new_instructions;
    //             }
    //         }    
    //     }
    // }

    // pub fn instructions_to_llvm(&mut self, func_id:&str, instructions:&mut Vec<String>, global_context:&mut GlobalContext, function_context:&mut LLVMFunctionContext) {
    //     // Now, put the phis and block code in the function instructions
    //     for cur_block_id in &self.block_order {
    //         let block = self.blocks.get(cur_block_id).unwrap();
    //         instructions.push(format!(""));

    //         // We don't put the start block's label here. We put it at the top of the function (to avoid needing a branch after the locals/parms setup)
    //         if *cur_block_id != self.start_block {
    //             instructions.push(format!("{}: ; preds {:?}",cur_block_id, block.preds));
    //         }
    //         // self.instructions.push("    ; CFBlock start".to_string());

    //         // Add the phis for this block
    //         for (reg_id,phi) in function_context.get_phis_for_block(cur_block_id) {
    //             // println!("Processing phi: {} {:?}", reg_id, phi);
    //             let llvm_phi_operands:String = phi.operands.iter().map(|operand| format!("[{}, %{}]", operand.reg_id.clone().unwrap(), operand.block_id)).collect::<Vec<String>>().join(", ");
    //             instructions.push(format!("    {} = phi {} {}", reg_id, phi.datatype.get_llvm_type(&global_context.arch), llvm_phi_operands));
    //         }

    //         // Now add the block's instructions
    //         // println!("== Putting block instructions after phis ==");
    //         for instruction in &block.instructions {
    //             instructions.push(instruction.as_llvm(&global_context.arch));
    //         }
    //         // instructions.extend(block_instructions.get(cur_block_id).unwrap());
    //         instructions.push(format!(""));
    //     }

    //     instructions.push("}".to_string());
    // }
}

impl super::cfg_builder::CFBlock {
    // Returns new current block
    pub fn gen_instructions(&self, id:&str, cf_func:&CFFunction, global_context:&mut GlobalContext, function_context:&mut LLVMFunctionContext) -> Vec<Instruction> {
        let mut instructions:Vec<Instruction> = Vec::new();


        for stmt in &self.stmts {
            // println!("=== Processing statement {:?}", stmt);
            //instructions.push(format!("    ; {:?}", stmt));
            instructions.push(Instruction::Comment(stmt.to_string()));
            stmt.gen_instructions(&mut instructions, cf_func, global_context, function_context, id);
            // global_context.check_vars();
        }

        match &self.term {
            CFBlockTerminator::Return => {
                let return_var = function_context.var_name_factory.next();
                // If we don't have a void return type, return it
                if !function_context.datatype_of(&function_context.return_value_id).eq(&Datatype::Void) {
                    match global_context.ssa_mode {
                        SSAMode::Stack => {
                            // Load _retval_ into a variable and return it
                            //instructions.push(format!("    {0} = load {1}, {1}* {2}, align 4",return_var,function_context.datatype_of(&function_context.return_value_id).get_llvm_type(&global_context.arch), function_context.return_value_id));
                            instructions.push(Instruction::Load(return_var.clone(), function_context.datatype_of(&function_context.return_value_id), function_context.return_value_id.clone()));
                            //instructions.push(format!("    ret {} {}",function_context.datatype_of(&function_context.return_value_id).get_llvm_type(&global_context.arch),return_var));
                            instructions.push(Instruction::Return(Some((function_context.datatype_of(&function_context.return_value_id),return_var.clone()))));
                        },
                        SSAMode::Register => {
                            // In register-based, the register/type of retval's current value is in function_context.return_spec
                            let return_reg = function_context.read_variable(cf_func, &global_context.ssa_mode, &self.id, &function_context.return_value_id.clone()).unwrap();
                            //instructions.push(format!("    ret {} {}",function_context.datatype_of(&function_context.return_value_id).get_llvm_type(&global_context.arch), return_reg));
                            instructions.push(Instruction::Return(Some((function_context.datatype_of(&function_context.return_value_id), return_reg))));
                        }
                    }
                } else {
                    //instructions.push("    ret void".to_string());
                    instructions.push(Instruction::Return(None));
                }
                //instructions.push("    ;block returns".to_string());
                instructions.push(Instruction::Comment("block returns".to_string()));
            },
            CFBlockTerminator::Jump{label} => {
                //instructions.push(format!("    br label %{}",label));
                instructions.push(Instruction::BranchUncond(label.to_string()));
            },
            CFBlockTerminator::CondJump{expr,true_label,false_label} => {
                let val_spec = expr.gen_instructions(&mut instructions, cf_func, global_context, function_context, id).unwrap();
                // println!("Expression is {}",expr);
                assert_eq!(val_spec.datatype,Datatype::Bool);
                //instructions.push(format!("    br i1 {}, label %{}, label %{}",val_spec.id,true_label,false_label));
                instructions.push(Instruction::BranchCond(val_spec.id,true_label.to_string(),false_label.to_string()));
            },
            CFBlockTerminator::Undef => {
                //instructions.push(";WARNING: Found an Undef block terminator".to_string());
                instructions.push(Instruction::Comment("WARNING: Found an Undef block terminator".to_string()));
            },
        }
        instructions
    }
}

// Take a value, pointed to by ref_spec, and load it into its own register
fn dereference(ref_spec:&ValueSpec, instructions:&mut Vec<Instruction>, var_name_factory:&mut UniqueNameFactory, arch:&Arch) -> ValueSpec {
    // println!("Asked to dereference {:?}", ref_spec);
    //instructions.push(format!("; Entering dereference {:?}", ref_spec));
    instructions.push(Instruction::Comment(format!("Entering dereference {:?}", ref_spec)));

    // We had better be a reference
    match ref_spec.datatype {
        Datatype::Ref(ref inner) => {
            let val_id = var_name_factory.next();
            //instructions.push(format!("; deref {:?}",ref_spec));
            instructions.push(Instruction::Comment(format!("deref {:?}", ref_spec)));
            //instructions.push(format!("    {0} = load {1}, {1}* {2}", val_id, (*inner).get_llvm_type(arch), ref_spec.id));
            instructions.push(Instruction::Load(val_id.clone(), (**inner).clone(), ref_spec.id.clone()));
            let new_spec = ValueSpec {
                id:val_id,
                datatype:(**inner).clone(),
            };
            // println!("The dereferenced spec is {:?}", new_spec);
            new_spec
        },
        _ => panic!("Tried to dereference a {:?}",ref_spec),
    }
}

// Use getelementptr to calculate the address of a field in the structure
// NOTE we don't deref anything, here. So, we receive a register with a pointer and produce a register with a pointer
fn get_addr_of_field_in_llvm_reg(val_spec:&ValueSpec, field_id:&str, instructions:&mut Vec<Instruction>, global_context:&GlobalContext, function_context:&mut LLVMFunctionContext) -> ValueSpec {
    // println!("get_addr_of_field_in_llvm_reg asked to get field {} in {:?}", field_id, val_spec);
    //instructions.push(format!("; Entering get_addr_of_field_in_llvm_reg {:?} . {}", val_spec, field_id));
    instructions.push(Instruction::Comment(format!("Entering get_addr_of_field_in_llvm_reg {:?} . {}", val_spec, field_id)));

    // First, we need to be a pointer
    match val_spec.datatype.clone() {
        Datatype::Ref(inner_type) => {
            // Next, we need to point to a structure type
            match &*inner_type {
                Datatype::Structure{id:struct_id} => {
                    // Generate code to load the pointed-to-pointer into a variable
                    // let inner_spec = dereference(val_spec, instructions, &mut function_context.var_name_factory);
                    //let struct_llvm_type = inner_type.get_llvm_type(&global_context.arch);
                    // Now get info about the field we're looking up
                    let field_type = global_context.get_datatype_of_struct_field(&struct_id, field_id);
                    let field_idx = global_context.get_index_of_struct_field(&struct_id, field_id);
                    // println!("Field '{}' is at index {} and is of type {}", field_id, field_idx, field_type);

                    let temp_var = function_context.var_name_factory.next();
                    // instructions.push(
                    //     format!("    {} = getelementptr {1},{1}* {2}, i1 0, i32 {3}; Getting address of dotted lvalue for assignment",
                    //         temp_var,
                    //         struct_llvm_type,
                    //         val_spec.id,
                    //         field_idx
                    //     )
                    // );
                    instructions.push(Instruction::GetElementPtr(temp_var.clone(), *inner_type, val_spec.id.clone(), field_idx));
                    // And return our new register, which is _also_ a pointer... it's just pointing to
                    // something inside the struct that val_spec was pointing to.
                    // If it's pointing to another struct, then there's another pointer
                    let new_spec = ValueSpec {
                        id:temp_var,
                        datatype: Datatype::Ref(Box::new(
                            match &field_type {
                                Datatype::Structure{id} => Datatype::Ref(Box::new(field_type.clone())),
                                _ => field_type.clone(),
                            }
                        ))
                    };
                    // println!("New spec is {:?}", new_spec);
                    new_spec
                },
                Datatype::Ref(inner) => {
                    // println!("{:?}",val_spec);
                    // get_addr_of_field_in_llvm_reg(&inner_spec, field_id, instructions, global_context, function_context)
                    panic!("TODO: Figure out why we're getting a double pointer");
                    // (*inner).get_addr_of_field_in_llvm_reg(field_id, instructions, global_context, function_context)
                }
                _ => panic!("We were expecting a pointer to a structure type in get_add_of_field_in_llvm_reg and got {}",val_spec.datatype.clone())
            }
        },
        _ => panic!("We were expecting a pointer to a structure type in get_add_of_field_in_llvm_reg and got {}",val_spec.datatype.clone())
    }
}

fn lookup_local_var(function_context:&mut LLVMFunctionContext, cf_func:&CFFunction, ssa_mode:&SSAMode, block_id:&str, var_id:&str) -> Option<ValueSpec> {
    // If it's not a local, return a None
    if ! function_context.localtypes.contains_key(var_id) {
        return None;
    }
    match function_context.read_variable(cf_func, ssa_mode, block_id, var_id) {
        Some(reg_id) => Some(
            ValueSpec {
                id:reg_id,
                datatype:function_context.datatype_of(var_id)
            }
        ),
        None => None
    }
}

impl Lvalue {
    fn get_addr_in_llvm_reg(&self, instructions:&mut Vec<Instruction>, cf_func:&CFFunction, global_context:&GlobalContext, function_context:&mut LLVMFunctionContext, block_id: &str) -> ValueSpec {
        // println!("getting address of {} into a register", self);
        //instructions.push(format!("; Entering get_addr_in_llvm_reg : {:?}", self));
        instructions.push(Instruction::Comment(format!("Entering get_addr_in_llvm_reg : {:?}", self)));
        match self {
            Lvalue::Base{id} => {
                
                // if global_context.ssa_mode == SSAMode::Register {
                //     panic!("This should be unreachable in register mode");                    
                // }
                let lval_spec = lookup_local_var(function_context, cf_func, &global_context.ssa_mode, block_id, id).unwrap_or_else(
                    || (global_context.globals.get(id).expect(&format!("Didn't find {} in either the local or global contexts",id)).clone())
                );
                // println!("getting address of base {}",id);
                if ! lval_spec.datatype.is_ref() {
                    panic!("get_addr_in_llvm_reg didn't get a reference when looking up '{}'", id);
                }
                assert!(lval_spec.datatype.is_ref());
                lval_spec.clone()
            },
            Lvalue::Dotted{lvalue, id} => {
                let ref_spec = match **lvalue {
                    Lvalue::Base{ref id} => {
                        if function_context.localtypes.contains_key(id) {
                            let ptr_spec = lookup_local_var(function_context, cf_func, &global_context.ssa_mode, block_id, id).unwrap();
                            match global_context.ssa_mode {
                                SSAMode::Stack => {
                                    // Stack mode, everything gets dereferenced
                                    dereference(&ptr_spec, instructions, &mut function_context.var_name_factory, &global_context.arch)
                                },
                                SSAMode::Register => {
                                    // Register mode, everything is used as-is
                                    ptr_spec
                                }
                            }
                        } else {
                            // It must be a global
                            let ptr_spec = global_context.globals.get(id).expect(&format!("Didn't find {} in either the local or global contexts",id)).clone();
                            dereference(&ptr_spec, instructions, &mut function_context.var_name_factory, &global_context.arch)
                        }                      
                    },
                    Lvalue::Dotted{lvalue:_, id:_} => {
                        let self_spec = lvalue.get_addr_in_llvm_reg(instructions, cf_func, global_context, function_context, block_id);
                        // At this point, self_spec should be a pointer to a pointer to a struct
                        // println!("###{} resolved to {:?} and now we're looking up {}", lvalue, self_spec, id);
                        dereference(&self_spec, instructions, &mut function_context.var_name_factory, &global_context.arch)
                        // ref_spec should now contain the pointer to a struct
                    }
                };

                let field_spec = get_addr_of_field_in_llvm_reg(&ref_spec, id, instructions, global_context, function_context);
                // field_spec should contain the pointer to a field within the struct
                field_spec
            }
        }
    }

    fn assign_by_store(&self, rval_spec:ValueSpec, instructions:&mut Vec<Instruction>, cf_func:&CFFunction, global_context:&mut GlobalContext, function_context:&mut LLVMFunctionContext, block_id: &str) {
        // First, do all of the work to get the address of the (possibly nested) field into a register
        let lval_spec = self.get_addr_in_llvm_reg(instructions, cf_func, global_context, function_context, block_id);
        // Now, make sure that we the variable holds a reference
        // NOTE: HERE IS WHERE WE IMPLEMENT SSA. Instead of 'store', we actually place rval_spec in the symbol table for the block
        match &lval_spec.datatype {
            Datatype::Ref(inner) => {
                // Make sure these types are compatible
                assert_eq!(**inner, rval_spec.datatype);
                //instructions.push(format!("    store {0} {1},{0}* {2}", &(**inner).get_llvm_type(&global_context.arch), rval_spec.id, lval_spec.id));
                instructions.push(Instruction::Store((**inner).clone(), rval_spec.id, lval_spec.id));
            },
            _ => panic!("Don't know how to assign to anything other than to a reference and we got {:?}", lval_spec),
        };
    }

    // fn assign_by_symbol_table(&self, rval_spec:ValueSpec, instructions:&mut Vec<String>, cf_func:&CFFunction, global_context:&mut GlobalContext, function_context:&mut LLVMFunctionContext, block_id: &str) {
    //     function_context.write_variable(cf_func, block_id, &id, &rval_spec.id)
    // }


    fn assign(&self, rval_spec:ValueSpec, instructions:&mut Vec<Instruction>, cf_func:&CFFunction, global_context:&mut GlobalContext, function_context:&mut LLVMFunctionContext, block_id: &str) {
        // println!("Assign {:?} <- {:?}", self, rval_spec);
        //instructions.push(format!("; Entering assign {:?} <- {:?}", self, rval_spec));
        instructions.push(Instruction::Comment(format!("Entering assign {:?} <- {:?}", self, rval_spec)));
        match self {
            Lvalue::Base{id} => {
                if function_context.localtypes.contains_key(id) {
                    // It's local. If we're stack-based, then we assign by store. Update symbol table, otherwise
                    match &global_context.ssa_mode {
                        SSAMode::Stack => self.assign_by_store(rval_spec, instructions, cf_func, global_context, function_context, block_id),
                        SSAMode::Register => function_context.write_variable(cf_func, block_id, &id, &rval_spec.id),
                        _ => panic!("Encountered an unknown ssa_mode"),
                    };                   
                } else {
                    // It's a global var. All globals are assigned by store
                    self.assign_by_store(rval_spec, instructions, cf_func, global_context, function_context, block_id);
                }
            },
            Lvalue::Dotted{lvalue:_, id:_} => {
                // All dotted stuff is assigned by store
                self.assign_by_store(rval_spec, instructions, cf_func, global_context, function_context, block_id);
            }
        }
    }
}

impl Statement {
    pub fn gen_instructions(&self, instructions:&mut Vec<Instruction>, cf_func:&CFFunction, global_context:&mut GlobalContext, function_context:&mut LLVMFunctionContext, block_id: &str) {
        // function_context.print_all_symbol_tables();
        match self {
            Statement::Assignment{lvalue,expr} => {
                //instructions.push(format!("; {} = {}",lvalue,expr));
                instructions.push(Instruction::Comment(format!("{} = {}",lvalue,expr)));
                let rval_spec = expr.gen_instructions(instructions, cf_func, global_context, function_context, block_id).ok().unwrap();
                // println!("Make sure that the type of rval_spec and lvalue match");
                // Examine the type of the lvalue. If it's a straight variable, then we can assign right to it
                lvalue.assign(rval_spec, instructions, cf_func, global_context, function_context, block_id);
            },
            Statement::Print{expr, endl} => {
                //instructions.push("    I'm the writer for Statement::Print".to_string());
                match expr.gen_instructions(instructions, cf_func, global_context, function_context, block_id) {
                    Ok(val_spec) => {
                        let mut endl_code = 0;
                        if *endl {
                            endl_code = 1;
                        }
                        //instructions.push(format!("    call void @printInt({} {}, i1 {})", val_spec.get_llvm_type(&global_context.arch), val_spec.id, endl_code));
                        //instructions.push(Instruction::Call(Datatype::Void, "printInt".to_string(), format!("{} {}, i1 {}", val_spec.get_llvm_type(&global_context.arch), val_spec.id, endl_code)));
                        instructions.push(Instruction::Call(Datatype::Void, "printInt".to_string(), vec![(val_spec.datatype, val_spec.id),(Datatype::Bool, endl_code.to_string())]));
                    },
                    Err(msg) => panic!("Error generating instruction for print expression : {}", msg)
                }
            },
            Statement::Delete{expr} => {
                // instructions.push("    ; delete <expr>".to_string());
                //eval expr
                match expr.gen_instructions(instructions, cf_func, global_context, function_context, block_id) {
                    Ok(val_spec) => {
                        //call free
                        let struct_ptr_var = function_context.var_name_factory.next();
                        //let struct_ptr_llvm_type = val_spec.datatype.get_llvm_type(&global_context.arch);
                        // instructions.push(format!("    {0} = load {1},{1}* {2}", struct_ptr_var, struct_ptr_llvm_type, val_spec.id));
                        let i8_var = function_context.var_name_factory.next();
                        //instructions.push(format!("    {} = bitcast {} {} to i8*", i8_var, struct_ptr_llvm_type, val_spec.id));
                        instructions.push(Instruction::BitCast(i8_var.clone(), val_spec.datatype, val_spec.id, Datatype::Ref(Box::new(Datatype::SmallInt))));
                        //instructions.push(format!("    call void @free(i8* {})", i8_var));
                        instructions.push(Instruction::Call(Datatype::Void, "free".to_string(), vec![(Datatype::Ref(Box::new(Datatype::SmallInt)), i8_var.clone())]));                                                                   
                    },
                    Err(msg) => panic!("Error generating LLVM code for delete expression : {}", msg)
                }
            },
            
            Statement::Call{id, args} => {
                // instructions.push(format!("    ; call {}",id));

                //lookup id to get type

                let fn_ret_type = global_context.function_signatures.get(id).unwrap().1.clone();

                //for each arg, eval and print instructions, save arg type and reg
                let mut llvm_args = Vec::new();

                for arg in args {
                    match arg.gen_instructions(instructions, cf_func, global_context, function_context, block_id) {
                        Ok(val_spec) => {
                            llvm_args.push((val_spec.datatype, val_spec.id));
                            //llvm_args.push(format!("{} {}", val_spec.datatype.get_llvm_type(&global_context.arch), val_spec.id));
                        },
                        Err(msg) => panic!("Error encountered when evaluating args for function call of {} : {}", id, msg)
                    }
                }
                //instructions.push(format!("    call {} @{}({})", fn_ret_type.get_llvm_type(&global_context.arch), id, llvm_args.join(", ")));
                instructions.push(Instruction::Call(fn_ret_type, id.to_string(), llvm_args));
            },
            Statement::Return{expr} => {
                // evaluate expr and put it in our exit value register
                // jump to function exit
                // instructions.push("    ; return [expr]".to_string());
                match expr {
                    // If our return type is void, then don't do anything
                    Expression::VoidExp => {},
                    // Otherwise, evaluate the expression and generate the return val
                    _ => {
                        match expr.gen_instructions(instructions, cf_func, global_context, function_context, block_id) {
                            Ok(val_spec) => {
                                match global_context.ssa_mode {
                                    SSAMode::Stack => {
                                        // If we're stack-based, then function_context.return_value_id contains a pointer to a place on
                                        // the stack where we save retval
                                        //instructions.push(format!("    store {0} {1}, {0}* {2}", function_context.datatype_of(&function_context.return_value_id).get_llvm_type(&global_context.arch), val_spec.id, function_context.return_value_id));
                                        instructions.push(Instruction::Store(function_context.datatype_of(&function_context.return_value_id), val_spec.id, function_context.return_value_id.clone()));
                                    },
                                    SSAMode::Register => {
                                        // If we're register-based, then store this spec's register to function_context.return_value_id
                                        // println!("We should probably make sure val_spec.datatype matches function_context.datatype_of(&function_context.return_value_id)");
                                        assert_eq!(val_spec.datatype, function_context.datatype_of(&function_context.return_value_id));
                                        //instructions.push(format!("    ; {} saved to {} in block {}", val_spec.id, function_context.return_value_id, block_id));
                                        instructions.push(Instruction::Comment(format!("{} saved to {} in block {}", val_spec.id, function_context.return_value_id, block_id)));
                                        // println!("BEFORE setting {} - {} to {}", block_id, function_context.return_value_id, val_spec.id);
                                        // function_context.print_all_symbol_tables();
                                        function_context.write_variable(cf_func, block_id, &function_context.return_value_id.clone(), &val_spec.id);
                                        // println!("AFTER");
                                        // function_context.print_all_symbol_tables();
                                    }
                                }
                            },
                            Err(msg) => panic!("Error generating instruction for return expression : {}", msg)
                        }
                    }
                }
            },
            // Block, If, and While should end up here
            _ => panic!("We shouldn't have If and While statements in our CFG")
        }
    }
}

impl Expression {
    // Returns a tuple of
    //    A vector of llvm commands which perform our instructions
    //    A string containing the virtual register id which will contain the result
    //    The type of the expression
    //Note: Literals will have a literal instead of the register. LLVM can use literals like 1, 'true' in instructions
    pub fn gen_instructions(&self, instructions:&mut Vec<Instruction>, cf_func:&CFFunction, global_context:&mut GlobalContext, function_context:&mut LLVMFunctionContext, block_id: &str) -> Result<ValueSpec,String> {
        match self {
            Expression::True => {
                //instructions.push("I'm the writer for Expression::True".to_string());
                //no instructions needed, just return literal 'true'
                Ok(ValueSpec{
                    id:"true".to_string(),
                    datatype:Datatype::Bool,
                })
            },
            Expression::False  => {
                //instructions.push("I'm the writer for Expression::False".to_string());
                //no instructions needed, just return literal 'false'
                Ok(ValueSpec{
                    id:"false".to_string(),
                    datatype:Datatype::Bool,
                })
            },
            Expression::VoidExp => {
                //instructions.push("I'm the writer for Expression::VoidExp".to_string());
                //no instructions needed, just return literal 'void'
                Ok(ValueSpec{
                    id:"void".to_string(),
                    datatype:Datatype::Void,
                })
            },
            Expression::Null => {
                //instructions.push("I'm the writer for Expression::Null".to_string());
                //no instructions needed, just return literal 'null'
                //note: this is a null pointer. Since null can only inhabit struct types, and our structs are actually pointers, this is ok
                Ok(ValueSpec{
                    id:"null".to_string(),
                    datatype:Datatype::Null,
                })
            },
            Expression::Int (val) => {
                //instructions.push("I'm the writer for Expression::Int".to_string());
                //no instructions needed, just return the int itself
                Ok(ValueSpec{
                    id:val.to_string(),
                    datatype:Datatype::Int,
                })
            },
            Expression::Var {id} => {
                // Vars (locals, at least), are all pointers to a location on the stack. If the variable
                // is the type of a structure, then the location on the stack is, in turn, a pointer to the actual
                // structure contents. 

                if function_context.localtypes.contains_key(id) {
                    // instructions.push(Instruction::Comment(format!("Checking var {}",id)));
                    let ptr_spec = lookup_local_var(function_context, cf_func, &global_context.ssa_mode, block_id, id).unwrap();
                    match global_context.ssa_mode {
                        SSAMode::Stack => {
                            // Stack mode, everything gets dereferenced
                            Ok(dereference(&ptr_spec, instructions, &mut function_context.var_name_factory, &global_context.arch))
                        },
                        SSAMode::Register => {
                            // Register mode, everything is used as-is
                            Ok(ptr_spec)
                        }
                    }
                } else {
                    // It must be a global
                    let ptr_spec = global_context.globals.get(id).expect(&format!("Didn't find {} in either the local or global contexts",id)).clone();
                    // With globals, structures don't get dereferenced. Everything else does
                    match &ptr_spec.datatype {
                        Datatype::Structure{id} => Ok(ptr_spec),
                        _ => Ok(dereference(&ptr_spec, instructions, &mut function_context.var_name_factory, &global_context.arch)),
                    } 
                }
            },
            Expression::Unary {oper,expr} => {
                //instructions.push(format!("    ; unary_op:{}",oper));
                instructions.push(Instruction::Comment(format!("unary_op:{}",oper)));
                match expr.gen_instructions(instructions, cf_func, global_context, function_context, block_id) {
                    Ok(arg_spec) => {
                        let new_reg = function_context.var_name_factory.next();
                        let mut datatype = Datatype::Void;
                        match oper {
                            Token::BANG => {
                                //instructions.push(format!("    {} = icmp eq {} 0, {}", new_reg, arg_spec.datatype.get_llvm_type(&global_context.arch), arg_spec.id));
                                instructions.push(Instruction::Compare(new_reg.clone(), "eq".to_string(), arg_spec.datatype, "0".to_string(), arg_spec.id));
                                datatype = Datatype::Bool;
                            },
                            Token::MINUS => {
                                //instructions.push(format!("    {} = mul {} -1, {}", new_reg, arg_spec.datatype.get_llvm_type(&global_context.arch), arg_spec.id));
                                instructions.push(Instruction::Arithmetic(new_reg.clone(), "mul".to_string(), arg_spec.datatype, "-1".to_string(), arg_spec.id));
                                datatype = Datatype::Int;
                            },
                            _ => return Err(format!("This should be unreachable. But a unary epression had an invalid operator"))
                        };
                        Ok(ValueSpec{
                            id:new_reg,
                            datatype:datatype,
                        })
                    },
                    Err(msg) => return Err(format!("Error generating LLVM code for unary expression : {}", msg))
                }

            },
            Expression::Binary {oper, left,right} => {
                //instructions.push(format!("    ; binary_op:{}",oper));
                instructions.push(Instruction::Comment(format!("binary_op:{}",oper)));
                let lval_spec = left.gen_instructions(instructions, cf_func, global_context, function_context, block_id).unwrap();
                let rval_spec = right.gen_instructions(instructions, cf_func, global_context, function_context, block_id).unwrap();
                let new_reg = function_context.var_name_factory.next();
                let mut datatype = Datatype::Void;
                match oper {
                    Token::GT => {
                        //instructions.push(format!("    {} = icmp sgt {} {}, {}", new_reg, lval_spec.datatype.get_llvm_type(&global_context.arch), lval_spec.id, rval_spec.id));
                        instructions.push(Instruction::Compare(new_reg.clone(), "sgt".to_string(), lval_spec.datatype, lval_spec.id, rval_spec.id));
                        datatype = Datatype::Bool;
                    }
                    Token::LT => {
                        //instructions.push(format!("    {} = icmp slt {} {}, {}", new_reg, lval_spec.datatype.get_llvm_type(&global_context.arch), lval_spec.id, rval_spec.id));
                        instructions.push(Instruction::Compare(new_reg.clone(), "slt".to_string(), lval_spec.datatype, lval_spec.id, rval_spec.id));
                        datatype = Datatype::Bool;
                    }
                    Token::LE => {
                        //instructions.push(format!("    {} = icmp sle {} {}, {}", new_reg, lval_spec.datatype.get_llvm_type(&global_context.arch), lval_spec.id, rval_spec.id));
                        instructions.push(Instruction::Compare(new_reg.clone(), "sle".to_string(), lval_spec.datatype, lval_spec.id, rval_spec.id));
                        datatype = Datatype::Bool;
                    }
                    Token::GE => {
                        //instructions.push(format!("    {} = icmp sge {} {}, {}", new_reg, lval_spec.datatype.get_llvm_type(&global_context.arch), lval_spec.id, rval_spec.id));
                        instructions.push(Instruction::Compare(new_reg.clone(), "sge".to_string(), lval_spec.datatype, lval_spec.id, rval_spec.id));
                        datatype = Datatype::Bool;
                    }
                    Token::EQ => {
                        //instructions.push(format!("    {} = icmp eq {} {}, {}", new_reg, lval_spec.datatype.get_llvm_type(&global_context.arch), lval_spec.id, rval_spec.id));
                        instructions.push(Instruction::Compare(new_reg.clone(), "eq".to_string(), lval_spec.datatype, lval_spec.id, rval_spec.id));
                        datatype = Datatype::Bool;
                    }
                    Token::NE => {
                        //instructions.push(format!("    {} = icmp ne {} {}, {}", new_reg, lval_spec.datatype.get_llvm_type(&global_context.arch), lval_spec.id, rval_spec.id));
                        instructions.push(Instruction::Compare(new_reg.clone(), "ne".to_string(), lval_spec.datatype, lval_spec.id, rval_spec.id));
                        datatype = Datatype::Bool;
                    }
                    Token::AND => {
                        //instructions.push(format!("    {} = and i1 {}, {};", new_reg, lval_spec.id, rval_spec.id));
                        instructions.push(Instruction::Logical(new_reg.clone(), "and".to_string(), lval_spec.id, rval_spec.id));
                        datatype = Datatype::Bool;
                    }
                    Token::OR => {
                        //instructions.push(format!("     {} = or i1 {}, {}", new_reg, lval_spec.id, rval_spec.id));
                        instructions.push(Instruction::Logical(new_reg.clone(), "or".to_string(), lval_spec.id, rval_spec.id));
                        datatype = Datatype::Bool;
                    }
                    Token::PLUS => {
                        //instructions.push(format!("    {} = add {} {}, {}", new_reg, lval_spec.datatype.get_llvm_type(&global_context.arch), lval_spec.id, rval_spec.id));
                        instructions.push(Instruction::Arithmetic(new_reg.clone(), "add".to_string(), lval_spec.datatype, lval_spec.id, rval_spec.id));
                        datatype = Datatype::Int;
                    }
                    Token::MINUS => {
                        //instructions.push(format!("    {} = sub {} {}, {}; bin sub", new_reg, lval_spec.datatype.get_llvm_type(&global_context.arch), lval_spec.id, rval_spec.id));
                        instructions.push(Instruction::Arithmetic(new_reg.clone(), "sub".to_string(), lval_spec.datatype, lval_spec.id, rval_spec.id));
                        datatype = Datatype::Int;
                    }
                    Token::STAR => {
                        //instructions.push(format!("    {} = mul {} {}, {}", new_reg, lval_spec.datatype.get_llvm_type(&global_context.arch), lval_spec.id, rval_spec.id));
                        instructions.push(Instruction::Arithmetic(new_reg.clone(), "mul".to_string(), lval_spec.datatype, lval_spec.id, rval_spec.id));
                        datatype = Datatype::Int;
                    }
                    Token::SLASH => {
                        //instructions.push(format!("    {} = sdiv {} {}, {}", new_reg, lval_spec.datatype.get_llvm_type(&global_context.arch), lval_spec.id, rval_spec.id));
                        instructions.push(Instruction::Arithmetic(new_reg.clone(), "sdiv".to_string(), lval_spec.datatype, lval_spec.id, rval_spec.id));
                        datatype = Datatype::Int;
                    }
                    _ => return Err(format!("This should be unreachable. But a binary epression had an invalid operator"))
                }
                Ok(ValueSpec{
                    id:new_reg,
                    datatype:datatype,
                })
            },
            Expression::New {id} => {
                //instructions.push(format!("    ; new {}",id));
                instructions.push(Instruction::Comment(format!("new {}",id)));
                let uncast_reg = function_context.var_name_factory.next();
                let cast_reg = function_context.var_name_factory.next();
                let struct_type = Datatype::Ref(Box::new(Datatype::Structure{id:id.clone()}));
                let struct_size = global_context.get_size_of_struct(id);
                let int_llvm_type = Datatype::Int.get_llvm_type(&global_context.arch);
                //instructions.push(format!("    {} = call i8* @malloc ({} {})", uncast_reg, int_llvm_type, struct_size));
                instructions.push(Instruction::CallAndAssign(uncast_reg.clone(), Datatype::Ref(Box::new(Datatype::SmallInt)), "malloc".to_string(), vec![(Datatype::Int, struct_size.to_string())]));
                //instructions.push(format!("    {} = bitcast i8* {} to {}", cast_reg, uncast_reg, struct_type.get_llvm_type(&global_context.arch)));
                instructions.push(Instruction::BitCast(cast_reg.clone(), Datatype::Ref(Box::new(Datatype::SmallInt)), uncast_reg.clone(), struct_type.clone()));
                Ok(ValueSpec{
                    id:cast_reg,
                    datatype:struct_type,
                })
            },
            Expression::Dot {expr,id} => {
                //instructions.push(format!("    ; resolve_dot:<lvalue>.{}",id));
                instructions.push(Instruction::Comment(format!("resolve_dot:{:?}.{}",expr,id)));
                // First, generate all code to get the left side loaded. This should give us a pointer to a
                // structure
                let lval_spec = expr.gen_instructions(instructions, cf_func, global_context, function_context, block_id).unwrap();
                instructions.push(Instruction::Comment(format!("gen_instructions returned {:?}",lval_spec)));
                // We're expecting that it's a pointer to a struct, figure out the address of the field we need
                let field_ptr_spec = get_addr_of_field_in_llvm_reg(&lval_spec, id, instructions, global_context, function_context);
                // Fetch it and return it
                let field_spec = dereference(&field_ptr_spec, instructions, &mut function_context.var_name_factory, &global_context.arch);
                Ok(field_spec)
            },
            Expression::Inv {id,args} => {
                //instructions.push(format!("    ; invoke:{}",id));
                instructions.push(Instruction::Comment(format!("invoke:{}", id)));
                // The register name we're going to put the result into
                let ret_reg = function_context.var_name_factory.next();

                // We have to use the parameter types in the function declaration (not of the arguments, themselves) because
                // we might be passing a null

                // get the param and return types of the function
                let fn_signature = global_context.function_signatures.get(id).expect(&format!("Error looking for {} in function table",id));
                let fn_parm_types = fn_signature.0.clone();
                let fn_ret_type = fn_signature.1.clone();

                // Make a vector of just the argument register id's (which we do by evaluating each argument so that its
                // result gets stored in a register)
                let mut arg_regs:Vec<String> = Vec::new();
                for arg in args {
                    match arg.gen_instructions(instructions, cf_func, global_context, function_context, block_id) {
                        Ok(arg_spec) => {
                            arg_regs.push(arg_spec.id);
                        },
                        Err(msg) => return Err(format!("Error encountered when evaluating args for function call of {} : {}", id, msg))
                    }
                }

                // Now, zip the arg id's and the parm types together
                let zipped = arg_regs.iter().zip(fn_parm_types);

                //for each arg, eval and print instructions, save arg type and reg
                //let mut llvm_args:Vec<String> = zipped.map(|pair| format!("{} {}", pair.1.get_llvm_type(&global_context.arch), pair.0)).collect();
                let args:Vec<(Datatype, String)> =  zipped.map(|pair| (pair.1, pair.0.clone())).collect();
                //instructions.push(format!("    {} = call {} @{}({})", ret_reg, fn_ret_type.get_llvm_type(&global_context.arch), id, llvm_args.join(", ")));
                instructions.push(Instruction::CallAndAssign(ret_reg.clone(), fn_ret_type.clone(), id.to_string(), args));
                Ok(ValueSpec{
                    id:ret_reg,
                    datatype:fn_ret_type,
                })
            },
            Expression::Read => {
                //instructions.push("I'm the writer for Expression::Read".to_string());
                let read_reg = function_context.var_name_factory.next();
                //let int_llvm_type = Datatype::Int.get_llvm_type(&global_context.arch);
                //instructions.push(format!("    {} = call {} @readInt()", read_reg, int_llvm_type));
                instructions.push(Instruction::CallAndAssign(read_reg.clone(), Datatype::Int, "readInt".to_string(), vec![]));
                //readInt
                Ok(ValueSpec{
                    id:read_reg.to_string(),
                    datatype:Datatype::Int,
                })
            },
         }
    }
}

impl Decl {
    fn get_llvm_type(&self, arch:&Arch) -> String {
        self.datatype.get_llvm_type(arch)
    }

    // fn get_llvm_default_value(&self) -> String {
    //     self.datatype.get_llvm_default_value()
    // }

}

impl Datatype {
    pub fn get_llvm_type(&self, arch:&Arch) -> String {
        match self {
            Datatype::Void => String::from("void"),
            Datatype::Null => String::from("null"),
            Datatype::Bool => String::from("i1"),
            Datatype::Int =>
                match arch {
                    Arch::I32 => String::from("i32"),
                    Arch::I64 => String::from("i32"),
                },
            Datatype::SmallInt => String::from("i8"),
            Datatype::Structure{id} => format!("%struct.{}", id),
            Datatype::Ref(inner) => format!("{}*", inner.get_llvm_type(arch)),
            // Datatype::Phi => panic!("get_llvm_type got called on an unresolved Phi type"),
        }
    }

    pub fn get_llvm_default_value(&self) -> String {
        match self {
            Datatype::Void => panic!("get_llvm_default_val was asked for the default val of Void"),
            Datatype::Null => String::from("null"),
            Datatype::Bool => String::from("0"),
            Datatype::Int => String::from("0"),
            Datatype::SmallInt => String::from("0"),
            Datatype::Structure{id} => String::from("zeroinitializer"),
            Datatype::Ref(_inner) => String::from("null"),
            // Datatype::Phi => panic!("get_llvm_default_val was asked for the default val of a Phi")
        }
    }

    pub fn get_size_in_bytes(&self, arch:&Arch) -> u32 {
        match self {
            Datatype::Void => panic!("get_size_in_bytes was asked for the size of Void"),
            Datatype::Null => panic!("get_size_in_bytes was asked for the size of Null"),
            Datatype::Bool => 1,
            Datatype::Int =>
                match arch {
                    Arch::I32 => 4,
                    Arch::I64 => 4,
                },
            Datatype::SmallInt => 2,
            Datatype::Ref(_inner) =>
                match arch {
                    Arch::I32 => 4,
                    Arch::I64 => 8,
                },
            // Datatype can't know the size of a struct, because that's defined in the global context
            // This function is only intended to be called from GlobalContext.get_size_of_struct(id)
            // and, as such, matching Structure{id} here would mean there was a struct within a struct
            // (not a _reference_ to a struct with a struct, but an entire structure stored within another)
            // That's not allowed in this version of our language, but, if you did want to support that,
            // then you'd need to have this method take a global context as a parameter and then
            // use that to call back to global_context.get_structure_size(id) in the pattern below.
            Datatype::Structure{id:_} => panic!("get_size_in_bytes was asked for the size of Struct"),
            // Datatype::Phi => panic!("get_size_in_bytes was asked for the default val of a Phi"),
        }
    }

    // fn get_inner_type(&self) -> Datatype {
    //     match self {
    //         Datatype::Ref(inner) => (**inner).clone(),
    //         _ => panic!("Datatype::get_inner_type was asked for the inner type of {}",self),
    //     }
    // }

    fn is_ref(&self) -> bool {
        match self {
            Datatype::Ref(_) => true,
            _ => false,
        }
    }
}