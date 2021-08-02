
use super::ast::Datatype;
use super::cfg::cfg_builder::CFG;
use super::cfg::code_generator::{SSAMode,Arch,GlobalContext,ValueSpec};
use super::instruction::Instruction;

trait CodeOutput {
    fn get_global_header(cfg:&CFG, global_context:&mut GlobalContext) -> Vec<String>;
    fn get_global_footer(cfg:&CFG, global_context:&mut GlobalContext) -> Vec<String>;
    fn get_function_header(cfg:&CFG, global_context:&mut GlobalContext) -> Vec<String>;
    fn get_function_footer(cfg:&CFG, global_context:&mut GlobalContext) -> Vec<String>;
    fn get_instruction_as_text(instruction:&Instruction, arch:&Arch, ssa_mode:&SSAMode) -> Vec<String>;
}

struct LLVMOutput {
    ssa_mode:SSAMode,
}

impl CodeOutput for LLVMOutput {
    fn get_global_header(cfg:&CFG, global_context:&mut GlobalContext) -> Vec<String> {
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

    fn get_global_footer(cfg:&CFG, global_context:&mut GlobalContext) -> Vec<String> {
        Vec::new()
    }

    fn get_function_header(cfg:&CFG, global_context:&mut GlobalContext) -> Vec<String> {
        Vec::new()
    }

    fn get_function_footer(cfg:&CFG, global_context:&mut GlobalContext) -> Vec<String> {
        Vec::new()
    }

    fn get_instruction_as_text(instruction:&Instruction, arch:&Arch, ssa_mode:&SSAMode) -> Vec<String> {
        Vec::new()
    }
}
