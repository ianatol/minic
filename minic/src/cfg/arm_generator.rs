
use std::collections::{HashMap,HashSet};
use std::convert::TryFrom;

use super::super::Optimization;
use super::super::ast::{Decl,Datatype};
use super::super::instruction::{Instruction};
use super::UniqueNameFactory;
use super::cfg_builder::{CFG,CFBlockTerminator};
use super::code_generator::{GlobalContext,LLVMFunctionContext,ValueSpec};
use super::super::dataflow::*;
use super::super::dataflow::interferencegraph::*;

pub struct RegisterAssignment {
    pub stack_offset:i32,
    pub real_reg:Option<String> // None if spilled
}

pub fn get_arm_global_header(cfg:&CFG, global_context:&mut GlobalContext) -> Vec<String> {
    let mut text_instructions:Vec<String> = Vec::new();

    text_instructions.push(format!("    .arch armv6t2"));
    text_instructions.push(format!("    .syntax unified"));
    text_instructions.push(format!("    .arm"));
    text_instructions.push(format!("    .fpu vfp"));
    // Next, generate the global vars
    text_instructions.push("".to_string());
    text_instructions.push("# Global variables".to_string());
    for decl in &cfg.declarations {
        let id = format!("{}",decl.id);
        let mut datatype = decl.datatype.clone();

        // If it's a struct, declare it as a pointer. Otherwise, allocate it directly
        match &datatype {
            Datatype::Structure{id:_} => datatype = Datatype::Ref(Box::new(datatype)),
            _ => {},
        };            
        
        let arm_id = format!("glob_{}",&id);
        text_instructions.push(format!("    .comm {},{},4",id.clone(),datatype.clone().get_size_in_bytes(&global_context.arch)));
        text_instructions.push(format!("{}:",&arm_id));
        text_instructions.push(format!("    .long {}",id.clone()));

        //Generate LLVM decls
        let valspec = ValueSpec {
            id:arm_id,
            datatype:Datatype::Ref(Box::new(datatype.clone())),
        };

        //Save global vars in their symbol table
        global_context.globals.insert(decl.id.clone(), valspec);
    }

    text_instructions
}


// impl super::cfg_builder::CFG {
    // Returns new current block
    // pub fn gen_arm_code(&mut self, text_instructions:&mut Vec<String>, arch:Arch, ssa_mode:SSAMode, optimizations:&HashSet<Optimization>) {
    //     if ssa_mode == SSAMode::Stack {
    //         panic!("Don't use stack mode with assembly output");
    //     }

    //     // First, generate the type definitions (structs)
    //     // TODO create structs table

    //     let mut global_context = GlobalContext {
    //         structs: HashMap::new(),
    //         globals: HashMap::new(),
    //         function_signatures: HashMap::new(),
    //         arch,
    //         ssa_mode,
    //     };
    //     // Manually provide for an external function
    //     global_context.function_signatures.insert(
    //         "parmTest".to_string(),
    //         (vec![Datatype::Int, Datatype::Int, Datatype::Int, Datatype::Int, Datatype::Int, Datatype::Int, Datatype::Int, Datatype::Int, Datatype::Int], Datatype::Int)
    //     );

    //     // Build the structs and put them in the global context
    //     for type_ in &self.types {
    //         // Build a vec of the ValueSpecs
    //         let mut fields = Vec::<ValueSpec>::new();
    //         for decl in &type_.decls {
    //             fields.push(
    //                 ValueSpec{
    //                     id:decl.id.clone(),
    //                     // If it's a struct, we store it as a reference
    //                     datatype:
    //                         match decl.datatype.clone() {
    //                             Datatype::Structure{id} => Datatype::Ref(Box::new(decl.datatype.clone())),
    //                             _ => decl.datatype.clone(),
    //                         }
    //                 }
    //             );
    //         }
    //         global_context.structs.insert(type_.id.clone(), fields);
    //     }

    //     text_instructions.extend(get_arm_global_header(&self, &mut global_context));

    //     // Note the return types of all functions so that call knows what type to allocate
    //     for (id, func) in &self.functions {
    //         global_context.function_signatures.insert(
    //             id.to_string(),
    //             (
    //                 func.parms.iter().map(|decl| decl.datatype.clone()).collect(),
    //                 func.ret_type.clone()
    //             )
    //         );
    //     }
    //     text_instructions.push("".to_string());

    //     // Now, do all of the functions
    //     for id in self.functions.clone().keys() {
    //         println!("== Processing function {}", id);
    //         let func = self.functions.get_mut(id).unwrap();
    //         func.gen_arm_code(&id, text_instructions, &mut global_context);
    //     }
    // }
// }

impl super::cfg_builder::CFFunction {
    //CFFunction:
    //c
    // Returns new current block
    pub fn gen_arm_code(&mut self, func_id:&str, global_context:&mut GlobalContext) -> Vec<String> {


        let var_name_factory = UniqueNameFactory::new(format!("%v"));

        let mut function_context = LLVMFunctionContext {
            function_symbol_tables:HashMap::new(),
            localtypes: HashMap::new(),
            initialvals: HashMap::new(),
            phis: HashMap::new(),
            return_value_id: String::from("%_retval"),
            var_name_factory,
        };
        function_context.print_all_symbol_tables();

        function_context.localtypes.insert(function_context.return_value_id.clone(), self.ret_type.clone());

        //
        // PARAMS
        //
        for decl in self.parms.clone() {
            println!("Found parm: {}", decl.id);
            // Whether we track them in registers or the stack, Structures are by reference
            let allocated_type = match &decl.datatype {
                Datatype::Structure{ref id} => {
                    Datatype::Ref(Box::new(decl.datatype.clone()))
                },
                _ => decl.datatype.clone()
            };

            let table_entry:Decl = Decl {
                id: format!("%{}", decl.id),
                datatype: allocated_type
            };

            // Lastly, add it to the start block's symbol table
            //function_context.function_symbol_tables.get_mut(&self.start_block).unwrap().insert(&decl.id, val_spec);
            // function_context.localtypes.insert(decl.id.clone(), reg_var_type);
            // function_context.write_variable(self, &self.start_block, &decl.id.clone(), &reg_id);
            function_context.localtypes.insert(decl.id.clone(), table_entry.datatype.clone());
            function_context.write_variable(self, &self.start_block, &decl.id.clone(), &table_entry.id.clone());
        }
        for table_id in function_context.function_symbol_tables.keys() {
            let table = function_context.function_symbol_tables.get(table_id).unwrap();
            println!("After parms, symbol table for {:?} is {:?}", table_id, function_context.function_symbol_tables.get(table_id).unwrap().variables);
        }
        //
        // LOCALS
        //
        // Put all local variables in the local symbol table
        // Remember, this maps source-code variable names to their llvm register id's
        for decl in self.decls.clone() {
            // Whether we track them in registers or the stack, Structures are by reference
            let allocated_type = match &decl.datatype {
                    Datatype::Structure{ref id} => {
                        Datatype::Ref(Box::new(decl.datatype.clone()))
                    },
                    _ => decl.datatype.clone()
                };


            let table_entry:Decl = Decl {
                id: format!("%{}", decl.id),
                datatype: allocated_type
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

        //
        // Here, CFBlocks fill in their own instruction vectors and phis
        //
        // We need to hold all of the instructions from all of the blocks before we output them
        let mut block_instructions = self.build_instructions(func_id, global_context, &mut function_context);
        self.resolve_phis(func_id, global_context, &mut function_context);

        let mut data_flow = get_data_flow(&self, &function_context, &block_instructions);
        build_live_in_out(&self, &mut data_flow);

        if global_context.optimizations.contains(&Optimization::ConstantPropagation) {
            super::cfg_visitor::propagate_constants(&mut function_context, &mut block_instructions);            
        }

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
            super::code_generator::remove_trivial_phis(&mut block_instructions, &mut function_context.phis);
            let mut need_data_flow = true;
            while need_data_flow {
                println!("Re-doing data flow analysis because of removing trivial phis");
                data_flow = get_data_flow(&self, &function_context, &block_instructions);
                build_live_in_out(&self, &mut data_flow);
                need_data_flow = remove_non_critical_instructions(&mut function_context, &mut block_instructions, &data_flow);    
            }    
        }

        println!("Remaining phis are:");
        for block_id in function_context.phis.clone().keys() {
            let block_phis = function_context.phis.get_mut(block_id).unwrap();
            println!("  {:?}", block_phis);
        }

        let mut real_registers:HashMap<String,Option<String>> = HashMap::new();

        let real_reg_size:i32 = 4; // Size, in bytes, of real registers. On 32-bit, it's 4 bytes.
        let all_usable_regs:Vec<String> = vec![ "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7", "r8", "r9", "r10", "r12", "r14" ].iter().map(|s| s.to_string()).collect();
        let scratch_regs:Vec<String> = vec![ "r10", "r12", "r14" ].iter().map(|s| s.to_string()).collect();
        // Anything not used as a scratch register can be assigned
        let assignable_regs:Vec<String> = all_usable_regs.iter().filter(|r| ! scratch_regs.contains(r)).cloned().collect();
        let caller_saved_regs = vec![ "r0", "r1", "r2", "r3" ];

        if global_context.optimizations.contains(&Optimization::RegisterAssignment) {
            let graph = build_interference_graph(&data_flow, &function_context, &block_instructions);
            println!("Interference graph is:");
            println!("{}", graph);
            for reg_id in &data_flow.all_virtual_regs {
                real_registers.insert(reg_id.to_string(), None);
            }
            // Pre-assign r0, r1, r2, r3 to the first four parameters
            let mut parm_regs = caller_saved_regs.iter();
            let mut register_passed_parms = self.parms.clone();
            register_passed_parms.truncate(4);
            let mut pre_assigned_regs:HashMap<String,String> = HashMap::new();
            for Decl{id,datatype} in register_passed_parms {
                pre_assigned_regs.insert(format!("%{}", id), parm_regs.next().unwrap().to_string());
            }
            println!("Preassigned regs are {:?}", pre_assigned_regs);
            real_registers = color_interference_graph(&graph, &assignable_regs, &pre_assigned_regs);
        }

        // Let's figure out what registers we really need to push
        let mut used_real_registers:HashSet<String> = HashSet::new();
        for (virt_reg, opt_real_reg) in &real_registers {
            match opt_real_reg {
                None => {},
                Some(real_reg) => { used_real_registers.insert(real_reg.clone()); }
            }
        }
        for real_reg in &scratch_regs {
            used_real_registers.insert(real_reg.to_string());
        }
        println!("Used real registers is {:?}", used_real_registers);

        // We have to have these in the order that ARM wants them (r0-r9, r10-15). So text sort won't work.
        // Use the order they are in all_usable_regs
        let mut push_at_start:Vec<String> = Vec::new();
        let mut push_before_call:Vec<String> = Vec::new();
        for real_reg in &all_usable_regs {
            if used_real_registers.contains(real_reg) {
                if caller_saved_regs.contains(&real_reg.as_str()) {
                    push_before_call.push(real_reg.to_string());
                } else {
                    push_at_start.push(real_reg.to_string());
                }
            }
        }
        println!("Push at start are {:?}", push_at_start);
        println!("Push before call are {:?}", push_before_call);




        // let mut known_virt_reg_values:HashMap<String,LLVMOperand> = HashMap::new();



        // Let's figure out what the stack is going to look like

        // Find out the largest call frame we're going to need
        let mut max_parameter_count:i32 = 0;
        for cur_block_id in block_instructions.keys() {
            for instruction in block_instructions.get(cur_block_id).unwrap() {
                max_parameter_count = std::cmp::max(max_parameter_count, instruction.get_parameter_count());
            }
        }
        println!("Largest parameter count is {} bytes", max_parameter_count);
        
        let spill_locations:i32 = 0;
        let temp_locations:i32 = 0;
        let stacked_parms:i32 = std::cmp::max(0, max_parameter_count-4); // We don't stack the first four parameters

        // let mut other_saved_regs:Vec<String> = Vec::new();
        // // Test saving of additional registers
        // other_saved_regs.push("r5".to_string());
        // other_saved_regs.push("r6".to_string());
        let num_saved_regs:i32 = i32::try_from(push_at_start.len()).ok().unwrap();

        println!("ALL VIRTUAL REGS ARE {:?}", data_flow.all_virtual_regs);
        let mut stack_offset:i32 = -real_reg_size; // fp points to the old fp, so skip over that, first...
        stack_offset -= num_saved_regs * real_reg_size; // Skip over any other regs we've pushed
        let mut reg_assignments:HashMap<String,RegisterAssignment> = HashMap::new();
        for reg_id in &data_flow.all_virtual_regs {
            // println!("Setting up virtual reg {}", reg_id);
            reg_assignments.insert(
                reg_id.clone(),
                RegisterAssignment {
                    stack_offset: stack_offset,
                    real_reg: real_registers.get(reg_id).unwrap_or(&None).clone(),
                }
            );
            stack_offset -= real_reg_size;
        }


        // // Start outputting the function
        let mut text_instructions:Vec<String> = Vec::new();
        text_instructions.push(format!("@@@@@@@@@@ Function: {} @@@@@@@@@@", func_id));
        text_instructions.push(format!("    .global {}", func_id));
        text_instructions.push(format!("{}:", func_id));
        text_instructions.push(format!("    push {{fp, lr}}")); // Save old frame pointer and return address
        if num_saved_regs > 0 {
            text_instructions.push(format!("    # Save room for {} other saved registers", num_saved_regs));
            text_instructions.push(format!("    push {{ {} }} @ Save other registers we'll use", push_at_start.join(", ")));
            text_instructions.push(format!("    add fp, sp, #{} @ Set fp back to the saved fp", num_saved_regs * real_reg_size));
        }

        text_instructions.push(format!("    # Advance sp for {} locals, {} temps, {} spills, and {} call parms", reg_assignments.len(), spill_locations, temp_locations, stacked_parms));
        let num_locals = i32::try_from(reg_assignments.len()).ok().unwrap();
        text_instructions.push(format!("    sub sp, sp, #{}", (num_locals + spill_locations + temp_locations + stacked_parms) * real_reg_size));

        for (reg_id, assignment) in &reg_assignments {
            text_instructions.push(format!("    @ {} is given [fp, #{}] and {:?}", reg_id, assignment.stack_offset, assignment.real_reg));
        }

        // Copy function parameters to the virtual regs
        for (idx,decl) in self.parms.iter().enumerate() {
            text_instructions.push(format!("    @ store parm {}", decl.id));
            // This source id has to appear in the start block's symbol table, so find its virtual register there

            // let start_block_symbol_table = function_context.function_symbol_tables.get(&self.start_block).unwrap();
            // let llvm_operand = start_block_symbol_table.variables.get(&decl.id).unwrap();
            let llvm_operand = format!("%{}", decl.id);
            println!("About to try to resolve {}", llvm_operand);
            let dst_operand = super::super::instruction::llvm_value_as_arm_operand(&llvm_operand, &reg_assignments);
            let i32_idx = i32::try_from(idx).ok().unwrap();
            text_instructions.push(format!("    @ save parm #{} to virtual reg {}", idx, llvm_operand));
            // Set source to be a register if it's one of the first four. A stack offset, otherwise
            let temp_reg1 = super::super::instruction::ARMOperand::Register("lr".to_string());
            if idx < 4 {
                let src_operand = super::super::instruction::ARMOperand::Register(format!("r{}",idx));
                text_instructions.extend(super::super::instruction::mov("", &dst_operand, &src_operand, &temp_reg1));
            } else {
                let src_operand = super::super::instruction::ARMOperand::StackOffset((i32_idx-2) * real_reg_size); // -2=(arg#-4)+2 because we have to skip over the saved lp,fp 
                text_instructions.extend(super::super::instruction::mov("", &dst_operand, &src_operand, &temp_reg1));
            };

            println!("#{} {} {}", idx, decl.id, llvm_operand);

        }

        // Now, put the phis and block code in the function instructions
        for cur_block_id in &self.block_order {
            let block = self.blocks.get(cur_block_id).unwrap();
            text_instructions.push(format!(""));

            // We don't put the start block's label here. We put it at the top of the function (to avoid needing a branch after the locals/parms setup)
            if *cur_block_id != self.start_block {
                text_instructions.push(format!("{}: # preds {:?}",cur_block_id, block.preds));
            }
            // text_instructions.push("    # CFBlock start".to_string());

            // Add the phis for this block
            for (reg_id,phi) in function_context.get_phis_for_block(cur_block_id) {
                // println!("Processing phi: {} {:?}", reg_id, phi);
                let llvm_phi_operands:String = phi.operands.iter().map(|operand| format!("[{}, %{}]", operand.reg_id.clone().unwrap(), operand.block_id)).collect::<Vec<String>>().join(", ");
                text_instructions.push(format!("#    {} = phi {} {}", reg_id, phi.datatype.get_llvm_type(&global_context.arch), llvm_phi_operands));
            }

            // Now add the block's instructions
            // println!("== Putting block instructions after phis ==");
            for instruction in block_instructions.get(cur_block_id).unwrap() {
                // instructions.push(format!(";    {:?}", instruction));
                text_instructions.extend(instruction.as_arm(&reg_assignments, &global_context.arch, &push_at_start, real_reg_size, cur_block_id, &function_context.phis, &global_context.optimizations));
            }


            text_instructions.push(format!(""));
        }
        text_instructions
    }
}


fn arm_function_header() -> Vec<String> {
    Vec::new()
}

impl super::cfg_builder::CFBlock {
    // Returns new current block
    pub fn gen_arm_instructions(&self, id:&str, cf_func:&super::cfg_builder::CFFunction, global_context:&mut GlobalContext, function_context:&mut LLVMFunctionContext) -> Vec<Instruction> {
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
                    // In register-based, the register/type of retval's current value is in function_context.return_spec
                    let return_reg = function_context.read_variable(cf_func, &global_context.ssa_mode, &self.id, &function_context.return_value_id.clone()).unwrap();
                    //instructions.push(format!("    ret {} {}",function_context.datatype_of(&function_context.return_value_id).get_llvm_type(&global_context.arch), return_reg));
                    instructions.push(Instruction::Return(Some((function_context.datatype_of(&function_context.return_value_id), return_reg))));
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
