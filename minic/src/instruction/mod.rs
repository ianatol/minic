use std::collections::{HashMap,HashSet};
use std::convert::TryFrom;

use super::Optimization;
use super::ast::*;
use super::cfg::code_generator::{Arch, SSAMode, Phi};
use super::cfg::arm_generator::RegisterAssignment;

#[derive(Debug, Clone)]
pub enum Instruction {
    Comment(String), //Use for comments
    Store(Datatype, String, String), //Type, Id, Register
    BranchUncond(String), //Block Id
    BranchCond(String, String, String), //Id, True Block, False Block
    Load(String, Datatype, String), //Register, Type, Id (Register = load type, type* Id, align 4)
    Return(Option<(Datatype, String)>), //Type, Id
    GetElementPtr(String, Datatype, String, usize), //Register, Type, Id, Struct Field Index
    Call(Datatype, String, Vec<(Datatype, String)>), //Return Type, Id, Args
    CallAndAssign(String, Datatype, String, Vec<(Datatype, String)>), //Reg, Return Type, Id, Args
    BitCast(String, Datatype, String, Datatype), //Reg, From Type, Id, To Type
    Compare(String, String, Datatype, String, String), //Reg, Operator, Operand Type, Left Operand, Right Operand 
    Logical(String, String, String, String), //Reg, Operator, Left Operand, Right Operand (No type needed because it must be i1)
    Arithmetic(String, String, Datatype, String, String), //Reg, Operator, Operand Type, Left Operand, Right Operand
}

#[derive(Clone,Debug,PartialEq)]
pub enum LLVMOperand {
    Number(i32),
    Boolean(bool),
    Null,
    Void,
    Local(String),
    Global(String)
}

impl std::fmt::Display for LLVMOperand {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match &self {
            LLVMOperand::Number(num) => write!(f, "{}", num),
            LLVMOperand::Boolean(bool) => write!(f, "{}", bool),
            LLVMOperand::Null => write!(f, "null"),
            LLVMOperand::Void => write!(f, ""),
            LLVMOperand::Local(var) => write!(f, "{}", var),
            LLVMOperand::Global(var) => write!(f, "{}", var),
        }
    }
}

impl LLVMOperand {
    pub fn to_string(&self) -> String {
        format!("{}", self)
    }

    pub fn as_arm_operand(&self, reg_assignments:&HashMap<String,RegisterAssignment>) -> ARMOperand {
        match self {
            LLVMOperand::Boolean(true) => ARMOperand::Literal(-1),
            LLVMOperand::Boolean(false) => ARMOperand::Literal(0),
            LLVMOperand::Null => ARMOperand::Literal(0),
            LLVMOperand::Void => panic!("Shouldn't be converting a void to ARM"),
            LLVMOperand::Number(num) => ARMOperand::Literal(*num),
            LLVMOperand::Global(id) => ARMOperand::Global(id.to_string()),
            LLVMOperand::Local(id) => {
                if reg_assignments.contains_key(id) {
                    // It's a local virtual register, so the only question is whether it has a real register assignment
                    match &reg_assignments[id].real_reg {
                        Some(reg_id) => ARMOperand::Register(reg_id.to_string()),
                        None => ARMOperand::StackOffset(reg_assignments[id].stack_offset),
                    }
                } else {
                    // Somehow, this register wasn't in the table of assignments
                    for reg in reg_assignments.keys() {
                        println!("  {}", reg);
                    }
                    panic!("{} wasn't in reg_assignments!",id);
                }
            }
        }
    }

    pub fn is_local_reg(&self) -> bool {
        match self {
            LLVMOperand::Local(_) => true,
            _ => false,
        }
    }

    pub fn get_local_reg_id(&self) -> String {
        match self {
            LLVMOperand::Local(id) => id.clone(),
            _ => panic!("Can't get_local_reg_id on a {:?}", self),
        }
    }

    pub fn replace_local(&self, old_reg:&str, new_reg:&str) -> Self {
        match self {
            LLVMOperand::Local(id) => {
                if id==old_reg {
                    LLVMOperand::Local(new_reg.to_string())
                } else {
                    LLVMOperand::Local(id.to_string())
                }
            },
            _ => self.clone(),
        }
    }
}


#[derive(Debug,Clone)]
pub enum ARMOperand {
    Literal(i32),
    Register(String),
    StackOffset(i32),
    Global(String),
}

impl ARMOperand {
    fn get_register(&self) -> String {
        match self {
            ARMOperand::Register(reg) => reg.to_string(),
            _ => panic!("Can't get the register for a {:?}", self),
        }
    }
}

pub fn mov(cond:&str, dst:&ARMOperand, src:&ARMOperand, temp_reg:&ARMOperand) -> Vec<String> {
    match (dst,src) {
        // Dest = Literal ** Not Allowed **
        (ARMOperand::Literal(_),_) => panic!("Can't mov to a literal"),
        // Dest = Register
        (ARMOperand::Register(dst_reg),ARMOperand::Literal(val)) => {
            // let mut adjusted_val:i32 = *val;
            // if adjusted_val < 0 {
            //     adjusted_val = ;
            // }
            // Can it fit in 8 bits?
            if val < &256 && val >= &0 {
                vec![format!("    mov{} {}, #0x{:x} @ {1} <- {2}", cond, dst_reg, val)]
            } else {
                let mut instructions:Vec<String> = Vec::new();
                instructions.push(format!("    movw{} {}, #:lower16:0x{:x} @ {1} <- {2} (lower 16 bits)", cond, dst_reg, val));
                // Do we need to bother with the upper 16 bits?
                if val > &65535 || val < &0 {
                    instructions.push(format!("    movt{} {}, #:upper16:0x{:x} @ {1} <- {2} (upper 16 bits)", cond, dst_reg, val));
                }
                instructions
            }
        },
        (ARMOperand::Register(dst_reg),ARMOperand::Register(src_reg)) => {
            // Only mov if the registers are different
            if dst_reg == src_reg {
                vec![]
            } else {
                vec![format!("    mov{} {}, {}", cond, dst_reg, src_reg)]
            }
        },
        (ARMOperand::Register(dst_reg),ARMOperand::StackOffset(src_offset)) => {
            vec![format!("    ldr{} {}, [fp, #{}]", cond, dst_reg, src_offset)]
        },
        (ARMOperand::Register(dst_reg),ARMOperand::Global(global_loc)) => {
            vec![
                format!("    movw{} {}, #:lower16:{}",cond, &temp_reg.get_register(), global_loc),
                format!("    movt{} {}, #:upper16:{}",cond, &temp_reg.get_register(), global_loc),
                format!("    ldr{} {}, [{}]", cond, dst_reg, &temp_reg.get_register())
            ]
            // format!("    ldr{}  {}, {} @ ldr problem?", cond, dst_reg, global_loc)]
        },
        // Dest = StackOffset
        (ARMOperand::StackOffset(_),ARMOperand::Literal(_)) |
        // TODO we should probably catch cases where the stack offsets are the same
        (ARMOperand::StackOffset(_),ARMOperand::StackOffset(_)) |
        (ARMOperand::StackOffset(_),ARMOperand::Global(_)) => {
            let mut instructions:Vec<String> = Vec::new();
            instructions.extend(mov(cond, &temp_reg, src, &temp_reg));
            instructions.extend(mov(cond, dst, &temp_reg, &temp_reg));
            instructions
        }
        (ARMOperand::StackOffset(dst_offset),ARMOperand::Register(src_reg)) => {
            vec![format!("    str{} {}, [fp, #{}]", cond, src_reg, dst_offset)]
        }
        // Dest = Global (just like StackOffset, but we don't use fp or brackets)
        (ARMOperand::Global(_),ARMOperand::Literal(_)) |
        (ARMOperand::Global(_),ARMOperand::StackOffset(_)) |
        (ARMOperand::Global(_),ARMOperand::Global(_)) => {
            let mut instructions:Vec<String> = Vec::new();
            instructions.extend(mov(cond, &temp_reg, src, &temp_reg));
            instructions.extend(mov(cond, dst, &temp_reg, &temp_reg));
            instructions
        }
        (ARMOperand::Global(dst_label),ARMOperand::Register(src_reg)) => {
            vec![
                format!("    movw{} {}, #:lower16:{}",cond, &temp_reg.get_register(), dst_label),
                format!("    movt{} {}, #:upper16:{}",cond, &temp_reg.get_register(), dst_label),
                format!("    str{} {}, [{}]", cond, src_reg, &temp_reg.get_register())
            ]
        }
    }
}

pub fn string_to_llvm_operand(llvm_value_or_virt_reg:&str, all_virtual_regs:&HashSet<String>) -> LLVMOperand {
    // println!("Converting {}", llvm_value_or_virt_reg);
    if llvm_value_or_virt_reg.eq("null") {
        return LLVMOperand::Null;
    }
    if llvm_value_or_virt_reg.eq("true") {
        return LLVMOperand::Boolean(true);
    }
    if llvm_value_or_virt_reg.eq("false") {
        return LLVMOperand::Boolean(false);
    }
    // If it parses as an int, then return the int. Otherwise, treat it like a global
    match llvm_value_or_virt_reg.parse::<i32>() {
        Ok(num) => return LLVMOperand::Number(num),
        Err(_) => {
            // At this point, it has to be either a virtual register or a global variable
            if all_virtual_regs.contains(llvm_value_or_virt_reg) {
                return LLVMOperand::Local(llvm_value_or_virt_reg.to_string());
            } else {
                if llvm_value_or_virt_reg.starts_with("%") {
                    for reg in all_virtual_regs {
                        println!("  {}", reg);
                    }
                    panic!("{} wasn't in all_virtual_regs!",llvm_value_or_virt_reg);
                }
                return LLVMOperand::Global(llvm_value_or_virt_reg.to_string());
            }
        }
    }
}

pub fn llvm_value_as_arm_operand(llvm_value_or_virt_reg:&str, reg_assignments:&HashMap<String,RegisterAssignment>) -> ARMOperand {
    // println!("Converting {}", llvm_value_or_virt_reg);
    if llvm_value_or_virt_reg.eq("null") {
        return ARMOperand::Literal(0);
    }
    if llvm_value_or_virt_reg.eq("true") {
        return ARMOperand::Literal(-1);
    }
    if llvm_value_or_virt_reg.eq("false") {
        return ARMOperand::Literal(0);
    }
    // If it parses as an int, then return the int. Otherwise, treat it like a global
    match llvm_value_or_virt_reg.parse::<i32>() {
        Ok(num) => return ARMOperand::Literal(num),
        Err(_) => {
            // At this point, it has to be either a virtual register or a global variable
            if reg_assignments.contains_key(llvm_value_or_virt_reg) {
                // It's a local virtual register, so the only question is whether it has a real register assignment
                match &reg_assignments[llvm_value_or_virt_reg].real_reg {
                    Some(reg_id) => {
                        return ARMOperand::Register(reg_id.to_string());
                    },
                    None => {
                        // println!("No real register for it");
                        return ARMOperand::StackOffset(reg_assignments[llvm_value_or_virt_reg].stack_offset);
                    }
                }
            } else {
                if llvm_value_or_virt_reg.starts_with("%") {
                    for reg in reg_assignments.keys() {
                        println!("  {}", reg);
                    }
                    panic!("{} wasn't in reg_assignments!",llvm_value_or_virt_reg);
                }
                return ARMOperand::Global(llvm_value_or_virt_reg.to_string());
            }
        }
    }
}

pub fn resolve_local_register(oper:LLVMOperand, known_virt_reg_values:&HashMap<String,LLVMOperand>) -> LLVMOperand {
    match oper {
        LLVMOperand::Local(ref var_name) => {
            if known_virt_reg_values.contains_key(var_name) {
                let new_oper = known_virt_reg_values[var_name].clone();
                // println!("We know that {:?} is actually a {:?}", &oper, &new_oper);
                new_oper
            } else {
                oper
            }
        },
        _ => oper
    }  
}

pub fn get_phi_moves(cur_block_id:&str, dest_label:&str, phis:&HashMap<String,HashMap<String,Phi>>, reg_assignments:&HashMap<String,RegisterAssignment>, temp_reg:&ARMOperand) -> Vec<String> {
    get_phi_moves_safe_slow(cur_block_id, dest_label, phis, reg_assignments, temp_reg)
}

pub fn get_phi_moves_naive_broken(cur_block_id:&str, dest_label:&str, phis:&HashMap<String,HashMap<String,Phi>>, reg_assignments:&HashMap<String,RegisterAssignment>, temp_reg:&ARMOperand) -> Vec<String> {
    let mut instructions:Vec<String> = Vec::new();
    if phis.contains_key(dest_label) {
        let dest_block_phis = phis.get(dest_label).unwrap();
        for (dest_reg_id,phi) in dest_block_phis {
            // The current block ID _must_ be mentioned in the list of operands
            let our_reg_id = phi.get_reg_id_for_block_id(cur_block_id);
            // Now, we have to turn these virtual registers into real ones
            instructions.push(format!("    @ for phi, {} <- {}", dest_reg_id, our_reg_id));
            let src_operand = llvm_value_as_arm_operand(&our_reg_id, reg_assignments);
            let dst_operand = llvm_value_as_arm_operand(&dest_reg_id, reg_assignments);
            instructions.extend(mov("", &dst_operand, &src_operand, &temp_reg));
        }
    }
    instructions
}

pub fn get_phi_moves_safe_slow(cur_block_id:&str, dest_label:&str, phis:&HashMap<String,HashMap<String,Phi>>, reg_assignments:&HashMap<String,RegisterAssignment>, temp_reg:&ARMOperand) -> Vec<String> {
    let mut instructions:Vec<String> = Vec::new();
    if phis.contains_key(dest_label) {
        let dest_block_phis = phis.get(dest_label).unwrap();
        // build a tuple of (dst,src) pairs
        let mut pairs:Vec<(String,String)> = Vec::new();
        for (dest_reg_id,phi) in dest_block_phis {
            // The current block ID _must_ be mentioned in the list of operands
            let our_reg_id = phi.get_reg_id_for_block_id(cur_block_id);
            pairs.push((dest_reg_id.clone(),our_reg_id));
        }
        // Now, push the source registers
        for (dest_reg_id, our_reg_id) in &pairs {
            let src_operand = llvm_value_as_arm_operand(our_reg_id, reg_assignments);
            instructions.push(format!("    @ for phi, {} <- {}", dest_reg_id, our_reg_id));
            instructions.extend(mov("", temp_reg, &src_operand, temp_reg));
            instructions.push(format!("    push {{ {} }}", temp_reg.get_register()));
        }
        // Now, pop the destination registers in reverse order
        pairs.reverse();
        for (dest_reg_id, our_reg_id) in &pairs {
            let dst_operand = llvm_value_as_arm_operand(dest_reg_id, reg_assignments);
            instructions.push(format!("    @ for phi, {} <- {}", dest_reg_id, our_reg_id));
            instructions.push(format!("    pop {{ {} }}", temp_reg.get_register()));
            instructions.extend(mov("", &dst_operand, &temp_reg, &temp_reg));
        }
    }
    instructions
}

impl Instruction {
    
    pub fn as_arm(&self, reg_assignments:&HashMap<String,RegisterAssignment>, arch:&Arch, other_saved_regs:&Vec<String>, real_reg_size:i32, cur_block_id:&str, phis:&HashMap<String,HashMap<String,Phi>>, optimizations:&HashSet<Optimization>) -> Vec<String> {
        // Some operands we use in various places
        let temp_reg1 = ARMOperand::Register("lr".to_string());
        let temp_reg2 = ARMOperand::Register("r12".to_string());
        let temp_reg3 = ARMOperand::Register("r10".to_string());

        let zero_literal = ARMOperand::Literal(0);
        let one_literal = ARMOperand::Literal(1);
        let r0_reg = ARMOperand::Register("r0".to_string());
        let r1_reg = ARMOperand::Register("r1".to_string());

        match self {
            Instruction::Comment(msg) => {
                if optimizations.contains(&Optimization::RemoveComments) {
                    Vec::new()
                } else {
                    vec![ format!("# {}", msg) ]
                }
            },
            Instruction::Load(dst, typ, src_ptr) => {
                let mut instructions:Vec<String> = Vec::new();

                let src_operand = llvm_value_as_arm_operand(&src_ptr, reg_assignments);
                let dst_operand = llvm_value_as_arm_operand(&dst, reg_assignments);
                // instructions.push(format!("    push {{ r0 }}"));
                instructions.extend(mov("", &temp_reg1, &src_operand, &temp_reg1));
                instructions.push(format!("    ldr {}, [{}] @ Load {} <- [{}]", &temp_reg2.get_register(), &temp_reg1.get_register(), dst, src_ptr));
                instructions.extend(mov("", &dst_operand, &temp_reg2, &temp_reg2));
                // instructions.push(format!("    pop {{ r0 }}"));
                instructions
            },
            Instruction::Store(typ, src, dst_ptr) => {
                let mut instructions:Vec<String> = Vec::new();

                let src_operand = llvm_value_as_arm_operand(&src, reg_assignments);
                let dst_operand = llvm_value_as_arm_operand(&dst_ptr, reg_assignments);
                // instructions.push(format!("    push {{ r0 }}"));
                // instructions.push(format!("    push {{ r1 }}"));
                instructions.extend(mov("", &temp_reg1, &src_operand, &temp_reg1));
                instructions.extend(mov("", &temp_reg2, &dst_operand, &temp_reg2));
                instructions.push(format!("    str {}, [{}] @ Load {} <- [{}]", &temp_reg1.get_register(), &temp_reg2.get_register(), src, dst_ptr));
                // instructions.push(format!("    pop {{ r1 }}"));
                // instructions.push(format!("    pop {{ r0 }}"));

                instructions
            },
            Instruction::BranchUncond(label) => {
                let mut instructions:Vec<String> = Vec::new();
                // Check to see if the dest has any phis. If so, we need to move our registers into the ones assigned to by the phis
                instructions.extend(get_phi_moves(cur_block_id, label, phis, reg_assignments, &temp_reg1));
                instructions.push(format!("    b {}", label));
                instructions
            },
            Instruction::BranchCond(virtual_reg, true_label, false_label) => {
                let mut instructions:Vec<String> = Vec::new();
                let cond_operand = llvm_value_as_arm_operand(virtual_reg, reg_assignments);
                match cond_operand {
                    ARMOperand::Register(cond_reg) => {
                        instructions.push(format!("    cmp {}, #0 @ For conditional branching", cond_reg));
                    },
                    _ => {
                        // We need the value in a register, so load it to temp
                        instructions.push(format!("    @ We need {} in a register", virtual_reg));
                        instructions.extend(mov("", &temp_reg1, &cond_operand, &temp_reg1));
                        instructions.push(format!("    cmp {}, #0 @ For conditional branching", temp_reg1.get_register()));
                    }
                }
                instructions.push(format!("    beq {}_false_exit",cur_block_id)); // If so, branch to the false exit
                instructions.push(format!("{}_true_exit:", cur_block_id));
                // Check to see if the true dest has any phis. If so, we need to move our registers into the ones assigned to by the phis
                instructions.extend(get_phi_moves(cur_block_id, true_label, phis, reg_assignments, &temp_reg1));
                instructions.push(format!("    b {}", true_label));

                // Now do the false exit
                instructions.push(format!("{}_false_exit:", cur_block_id));
                // Check to see if the true dest has any phis. If so, we need to move our registers into the ones assigned to by the phis
                instructions.extend(get_phi_moves(cur_block_id, false_label, phis, reg_assignments, &temp_reg1));
                instructions.push(format!("    b {}", false_label));

                instructions
            },
            Instruction::Return(optional) => {
                let mut instructions:Vec<String> = Vec::new();

                match optional {
                    None => {
                        instructions.push(format!("    @ Looks like return type is void, so we don't need to load anything into r0"));
                    },
                    Some((typ, id)) => {
                        let src_operand = llvm_value_as_arm_operand(&id, reg_assignments);
                        instructions.push(format!("    @ return {}", id));
                        instructions.extend(mov("", &r0_reg, &src_operand, &temp_reg1));
                    }
                }

                instructions.push(format!("    @ Set sp to saved registers"));
                instructions.push(format!("    sub sp, fp, #{}", i32::try_from(other_saved_regs.len()).ok().unwrap() * real_reg_size));
                if other_saved_regs.len() > 0 {
                    instructions.push(format!("    pop {{ {} }} @ Restore saved registers", other_saved_regs.join(", ")));
                }
                instructions.push(format!("    pop {{fp, pc}} @ return")); // Save old frame pointer and return address

                instructions
            },
            Instruction::GetElementPtr(reg, typ, id, idx) => {
                let mut instructions:Vec<String> = Vec::new();
                let mut src_operand = llvm_value_as_arm_operand(&id, reg_assignments);
                let dst_operand = llvm_value_as_arm_operand(&reg, reg_assignments);
                match src_operand {
                    ARMOperand::Register(_) => {}, // We only need to do something if it's not a regsiter
                    // Anything other than a regsiter needs to be put into one
                    _ => {
                        instructions.extend(mov("", &temp_reg1, &src_operand, &temp_reg1));
                        src_operand = temp_reg1.clone();
                    }
                }
                match dst_operand {
                    ARMOperand::Register(dst_reg) => {
                        // If the destination is a register, then we can assign directly to it
                        instructions.push(format!("    add {}, {}, #{} @ getelementptr", dst_reg, src_operand.get_register(), idx * 4));
                    },
                    _ => {
                        // Destination isn't a register, so we need to add to the temp regsiter and then mov it
                        instructions.push(format!("    add {}, {}, #{} @ getelementptr", temp_reg1.get_register(), src_operand.get_register(), idx * 4));
                        instructions.extend(mov("", &dst_operand, &temp_reg1, &temp_reg1));
                    },
                }
                instructions
            },
            Instruction::Call(ret_type, id, args) => {
                let mut instructions:Vec<String> = Vec::new();
                instructions.push(format!("    push {{ r0-r3 }}"));
                let numbered_args:Vec<(usize,String)> = (&args).iter().map(|tuple| tuple.1.clone()).enumerate().collect();
                // Split the vector into the ones which go into registers and the ones which go onto the stack
                let (reg_args,mut stack_args) =
                    if numbered_args.len() > 4 {
                        let mut reg_args = numbered_args.clone();
                        let stack_args = reg_args.split_off(4);
                        (reg_args, stack_args)
                    } else {
                        (numbered_args.clone(), vec![])
                    };
                for (idx,id) in &reg_args {
                    let src_operand = llvm_value_as_arm_operand(id, reg_assignments);
                    let dst_operand = ARMOperand::Register(format!("r{}",idx));
                    instructions.extend(mov("", &dst_operand, &src_operand, &temp_reg1));
                }
                stack_args.reverse();
                for (idx,id) in &stack_args {
                    let src_operand = llvm_value_as_arm_operand(id, reg_assignments);
                    instructions.extend(mov("", &temp_reg1, &src_operand, &temp_reg1));
                    instructions.push(format!("    push {{ lr }} @ arg{} is {}",idx,id));
                }
                instructions.push(format!("    bl {}", id));
                // Restore the stack to undo the pushes for args 4-? if there were any
                if stack_args.len() > 0 {
                    instructions.push(format!("    add sp, sp, #{} @ restore sp to before arg pushes", stack_args.len()));
                }
                // Store the return value
                instructions.extend(mov("", &temp_reg1, &r0_reg, &temp_reg1));
                // instructions.push(format!("    mov lr, r0 @ Saving return value in case we're assigning it"));
                // Pop the registers in reverse
                instructions.push(format!("    pop {{ r0-r3 }}"));
                instructions
            },
            Instruction::CallAndAssign(reg, ret_type, id, args) => {
                // Treated just like a call, but return value comes back in r0
                let mut instructions:Vec<String> = Instruction::Call(ret_type.clone(), id.to_string(), args.to_vec()).as_arm(reg_assignments, arch, other_saved_regs, real_reg_size, cur_block_id, phis, optimizations);
                // Return value is in lr.
                let dst_operand = llvm_value_as_arm_operand(reg, reg_assignments);
                instructions.extend(mov("", &dst_operand, &temp_reg1, &temp_reg1));
                instructions
            },
            Instruction::BitCast(reg, typ, id, to_typ) => {
                let mut instructions:Vec<String> = Vec::new();
                instructions.push(format!("    @ Bitcast! We should remove this (and replace all occurrences of {}", reg));
                let src_operand = llvm_value_as_arm_operand(&id, reg_assignments);
                let dst_operand = llvm_value_as_arm_operand(&reg, reg_assignments);
                instructions.extend(mov("", &dst_operand, &src_operand, &temp_reg1));
                instructions
            },
            Instruction::Compare(reg, oper, typ, left, right) => {
                let mut instructions:Vec<String> = Vec::new();
                
                let lft_operand = llvm_value_as_arm_operand(left, reg_assignments);
                let rht_operand = llvm_value_as_arm_operand(right, reg_assignments);
                let dst_operand = llvm_value_as_arm_operand(reg, reg_assignments);

                // instructions.push(format!("    push {{ r0 }}"));
                instructions.extend(mov("", &temp_reg1, &lft_operand, &temp_reg1));
                // instructions.push(format!("    push {{ r1 }}"));
                instructions.extend(mov("", &temp_reg2, &rht_operand, &temp_reg2));
                // Start with a zero in dest
                instructions.extend(mov("", &dst_operand, &zero_literal, &temp_reg3));
                instructions.push(format!("    cmp {}, {}", &temp_reg1.get_register(), &temp_reg2.get_register()));
                let borrowed_oper: &str = oper;
                let cond = match borrowed_oper {
                    "eq" => { format!("eq") },
                    "ne" => { format!("ne") },
                    "sgt" => { format!("gt") },
                    "slt" => { format!("lt") },
                    "sge" => { format!("ge") },
                    "sle" => { format!("le") },
                    _ => { panic!("Invalid operator given to compare instruction") },
                };
                instructions.extend(mov(&cond, &dst_operand, &one_literal, &temp_reg3));
                // instructions.push(format!("    pop {{ r1 }}"));
                // instructions.push(format!("    pop {{ r0 }}"));
                instructions
            },
            Instruction::Logical(reg, oper, left, right) => {
                let mut instructions:Vec<String> = Vec::new();
                let lft_operand = llvm_value_as_arm_operand(left, reg_assignments);
                let rht_operand = llvm_value_as_arm_operand(right, reg_assignments);
                let dst_operand = llvm_value_as_arm_operand(reg, reg_assignments);
                
                // instructions.push(format!("    push {{ r0-r1 }}"));
                instructions.extend(mov("", &temp_reg1, &lft_operand, &temp_reg1));
                instructions.extend(mov("", &temp_reg2, &rht_operand, &temp_reg2));
                let borrowed_oper: &str = oper;
                instructions.extend(
                    match borrowed_oper {
                        "and" => {
                            vec![ format!("    and {}, {}, {}", temp_reg1.get_register(), temp_reg1.get_register(), temp_reg2.get_register()) ]
                        },
                        "or" => {
                            vec![ format!("    orr {}, {}, {}", temp_reg1.get_register(), temp_reg1.get_register(), temp_reg2.get_register()) ]
                        },
                        _ => {
                            panic!(format!("Invalid operator given to logical instruction"))
                        },
                    }
                );
                // instructions.push(format!("    pop {{ r0-r1 }}"));
                instructions.extend(mov("", &dst_operand, &temp_reg1, &temp_reg1));
                instructions
            },
            Instruction::Arithmetic(reg, oper, typ, left, right) => {
                let mut instructions:Vec<String> = Vec::new();
                let lft_operand = llvm_value_as_arm_operand(left, reg_assignments);
                let rht_operand = llvm_value_as_arm_operand(right, reg_assignments);
                let dst_operand = llvm_value_as_arm_operand(reg, reg_assignments);
                
                // instructions.push(format!("    push {{ r0-r1 }}"));
                instructions.extend(mov("", &temp_reg1, &lft_operand, &temp_reg1));
                instructions.extend(mov("", &temp_reg2, &rht_operand, &temp_reg2));

                let borrowed_oper: &str = oper;
                match borrowed_oper {
                    "add" => {
                        instructions.push(format!("    add {}, {}, {}", &temp_reg1.get_register(), &temp_reg1.get_register(), &temp_reg2.get_register()));
                    },
                    "sub" => {
                        instructions.push(format!("    sub {}, {}, {}", &temp_reg1.get_register(), &temp_reg1.get_register(), &temp_reg2.get_register()));
                    },
                    "mul" => {
                        instructions.push(format!("    mul {}, {}, {}", &temp_reg1.get_register(), &temp_reg1.get_register(), &temp_reg2.get_register()));
                    },
                    "sdiv" => {
                        // Save r0,r1
                        instructions.push(format!("    push {{ r0-r4 }}"));
                        // Move left/right into r0 and r1
                        instructions.extend(mov("", &r0_reg, &lft_operand, &temp_reg1));
                        instructions.extend(mov("", &r1_reg, &rht_operand, &temp_reg2));
                        // divides r0 by r1 and returns quotient in r0
                        instructions.push(format!("    bl __aeabi_idiv"));
                        // r0 contains the quotient, so we need to place it into the scratch register
                        instructions.extend(mov("", &temp_reg1, &r0_reg, &temp_reg1));
                        // Restore r0,r1
                        instructions.push(format!("    pop {{ r0-r4 }}"));
                        // Move result to the real destination
                        instructions.extend(mov("", &dst_operand, &temp_reg1, &temp_reg1));
                    },
                    _ => { panic!(format!("Invalid operator given to arithmetic instruction")) },
                }
                // instructions.push(format!("    pop {{ r0-r1 }}"));
                instructions.extend(mov("", &dst_operand, &temp_reg1, &temp_reg1));
                instructions
            },
        }
    }

    pub fn as_llvm(&self, arch:&Arch, ssa_mode:&SSAMode, optimizations:&HashSet<Optimization>) -> Vec<String> {
        match self {
            Instruction::Comment(msg) => {
                if optimizations.contains(&Optimization::RemoveComments) {
                    Vec::new()
                } else {
                    vec![ format!("; {}", msg) ]
                }
            },
            Instruction::Store(typ, id, reg) => {
                vec![ format!("store {0} {1}, {0}* {2}, align 4", typ.get_llvm_type(arch), id, reg) ]
            },
            Instruction::BranchUncond(id) => {
                vec![ format!("br label %{}", id) ]
            },
            Instruction::BranchCond(id, true_block, false_block) => {
                vec![ format!("br i1 {}, label %{}, label %{}", id, true_block, false_block) ]
            },
            Instruction::Load(reg, typ, id) => {
                vec![ format!("{0} = load {1}, {1}* {2}, align 4", reg, typ.get_llvm_type(arch), id) ]
            },
            Instruction::Return(None) => {
                vec![ format!("ret void") ]
            },
            Instruction::Return(Some((typ, id))) => {
                vec![ format!("ret {} {}", typ.get_llvm_type(arch), id) ]
            },
            Instruction::GetElementPtr(reg, typ, id, idx) => {
                vec![ format!("{} = getelementptr {1},{1}* {2}, i1 0, i32 {3}", reg, typ.get_llvm_type(arch), id, idx) ]
            },
            Instruction::Call(ret_type, id, args) => {
                let llvm_args = args.iter().map(|(typ, val)| typ.get_llvm_type(arch) + " " + val).collect::<Vec<String>>().join(", ");
                vec![ format!("call {} @{}({})", ret_type.get_llvm_type(arch), id, llvm_args) ]
            },
            Instruction::CallAndAssign(reg, ret_type, id, args) => {
                let llvm_args = args.iter().map(|(typ, val)| typ.get_llvm_type(arch) + " " + val).collect::<Vec<String>>().join(", ");
                vec![ format!("{} = call {} @{}({})", reg, ret_type.get_llvm_type(arch), id, llvm_args) ]
            },
            Instruction::BitCast(reg, typ, id, to_typ) => {
                vec![ format!("{} = bitcast {} {} to {}", reg, typ.get_llvm_type(arch), id, to_typ.get_llvm_type(arch)) ]
            },
            Instruction::Compare(reg, oper, typ, left, right) => {
                vec![ format!("{} = icmp {} {} {}, {}", reg, oper, typ.get_llvm_type(arch), left, right) ]
            },
            Instruction::Logical(reg, oper, left, right) => {
                vec![ format!("{} = {} i1 {}, {}", reg, oper, left, right) ]
            },
            Instruction::Arithmetic(reg, oper, typ, left, right) => {
                vec![ format!("{} = {} {} {}, {}", reg, oper, typ.get_llvm_type(arch), left, right) ]
            },
        }
    }

    pub fn get_kill_gen(&self) -> (HashSet<String>,HashSet<String>) {
        // println!("get_kill_gen({:?})", self);
        let mut kill:HashSet<String> = HashSet::new();
        let mut gen:HashSet<String> = HashSet::new();
        match self {
            Instruction::Store(typ, id, reg) => {
                if is_reg(id) { gen.insert(id.clone()); }
                if is_reg(reg) { gen.insert(reg.clone()); }
            },
            Instruction::Load(reg, typ, id) => {
                if is_reg(reg) { kill.insert(reg.clone()); }
                if is_reg(id) { gen.insert(id.clone()); }
            },
            Instruction::Return(None) => {},
            Instruction::Return(Some((typ, id))) => {
                if is_reg(id) { gen.insert(id.clone()); }
            },
            Instruction::GetElementPtr(reg, typ, id, idx) => {
                if is_reg(reg) { kill.insert(reg.clone()); }
                if is_reg(id) { gen.insert(id.clone()); }
            },
            Instruction::Call(ret_type, id, args) => {
                // Don't add 'id'. That's the function name, but it still has a register-like name (begins with '%')
                for (typ,id) in args {
                    if is_reg(id) { gen.insert(id.clone()); }
                }
            },
            Instruction::CallAndAssign(reg, ret_type, id, args) => {
                // Don't add 'id'. That's the function name, but it still has a register-like name (begins with '%')
                for (typ,id) in args {
                    if is_reg(id) { gen.insert(id.clone()); }
                }
                kill.insert(reg.clone());
            },
            Instruction::BitCast(reg, typ, id, to_typ) => {
                if is_reg(reg) { kill.insert(reg.clone()); }
                if is_reg(id) { gen.insert(id.clone()); }
            },
            Instruction::Compare(reg, oper, typ, left, right) => {
                if is_reg(left) { gen.insert(left.clone()); }
                if is_reg(right) { gen.insert(right.clone()); }
                if is_reg(reg) { kill.insert(reg.clone()); }
            },
            Instruction::Logical(reg, oper, left, right) => {
                if is_reg(left) { gen.insert(left.clone()); }
                if is_reg(right) { gen.insert(right.clone()); }
                if is_reg(reg) { kill.insert(reg.clone()); }
            },
            Instruction::Arithmetic(reg, oper, typ, left, right) => {
                if is_reg(left) { gen.insert(left.clone()); }
                if is_reg(right) { gen.insert(right.clone()); }
                if is_reg(reg) { kill.insert(reg.clone()); }
            },
            Instruction::BranchUncond(label) => {},
            Instruction::BranchCond(id, true_label, false_label) => {
                if is_reg(id) { gen.insert(id.clone()); }
            },
            Instruction::Comment(msg) => {},
            invalid_instr => {
                panic!("Don't know what to do for get_kill_gen for {:?}", self);
            },
        }
        (kill,gen)
    }

    // We'll need this so that the function creator can query all instructions for how big of a stack frame they need
    pub fn get_parameter_count(&self) -> i32 {
        match self {
            Instruction::Call(ret_type, id, args) => {
                i32::try_from(std::cmp::max(4,args.len())).ok().unwrap()
            },
            Instruction::CallAndAssign(reg, ret_type, id, args) => {
                i32::try_from(std::cmp::max(4,args.len())).ok().unwrap()
            },
            _ => { 0 },
        }
    }

    pub fn replace(&self, old_reg:&str, new_reg:&str) -> Instruction {
        match self {
            Instruction::Store(typ, id, reg) => {
                Instruction::Store(
                    typ.clone(),
                    rep(&id,old_reg,new_reg),
                    rep(&reg,old_reg,new_reg),
                )
            },
            Instruction::Load(reg, typ, id) => {
                Instruction::Load(
                    rep(&reg,old_reg,new_reg),
                    typ.clone(),
                    rep(&id,old_reg,new_reg),
                )
            },
            Instruction::Return(optional) => {
                match optional {
                    Some((typ, id)) => {
                        Instruction::Return(
                            Some((
                                typ.clone(),
                                rep(&id,old_reg,new_reg),
                            ))   
                        )
                    },
                    None => self.clone(),
                }
            },
            Instruction::GetElementPtr(reg, typ, id, idx) => {
                Instruction::GetElementPtr(
                    rep(&reg,old_reg,new_reg),
                    typ.clone(),
                    rep(&id,old_reg,new_reg),
                    idx.clone(),
                )
            },
            // Call(Datatype, String, Vec<(Datatype, String)>), //Return Type, Id, Args
            // CallAndAssign(String, Datatype, String, Vec<(Datatype, String)>), //Reg, Return Type, Id, Args
        
            Instruction::Call(ret_type, id, args) => {
                let mut new_args:Vec<(Datatype, String)> = Vec::new();
                for (typ,id) in args {
                    new_args.push((typ.clone(), rep(&id,old_reg,new_reg)));
                }
                Instruction::Call(
                    ret_type.clone(),
                    rep(&id,old_reg,new_reg),
                    new_args
                )
            },
            Instruction::CallAndAssign(reg, ret_type, id, args) => {
                let mut new_args:Vec<(Datatype, String)> = Vec::new();
                for (typ,id) in args {
                    new_args.push((typ.clone(), rep(&id,old_reg,new_reg)));
                }
                Instruction::CallAndAssign(
                    rep(&reg,old_reg,new_reg),
                    ret_type.clone(),
                    rep(&id,old_reg,new_reg),
                    new_args
                )
            },
            Instruction::BitCast(reg, typ, id, to_typ) => {
                Instruction::BitCast(
                    rep(&reg,old_reg,new_reg),
                    typ.clone(),
                    rep(&id,old_reg,new_reg),
                    to_typ.clone(),
                )
            },
            Instruction::Compare(reg, oper, typ, left, right) => {
                Instruction::Compare(
                    rep(&reg,old_reg,new_reg),
                    oper.clone(),
                    typ.clone(),
                    rep(&left,old_reg,new_reg),
                    rep(&right,old_reg,new_reg),
                )
            },
            Instruction::Logical(reg, oper, left, right) => {
                Instruction::Logical(
                    rep(&reg,old_reg,new_reg),
                    oper.clone(),
                    rep(&left,old_reg,new_reg),
                    rep(&right,old_reg,new_reg),
                )            },
            Instruction::Arithmetic(reg, oper, typ, left, right) => {
                Instruction::Arithmetic(
                    rep(&reg,old_reg,new_reg),
                    oper.clone(),
                    typ.clone(),
                    rep(&left,old_reg,new_reg),
                    rep(&right,old_reg,new_reg),
                )
            },
            Instruction::BranchUncond(label) => {
                Instruction::BranchUncond(label.clone())
            },
            Instruction::BranchCond(id, true_label, false_label) => {
                Instruction::BranchCond(
                    rep(&id,old_reg,new_reg),
                    true_label.clone(),
                    false_label.clone(),
                )
            },
            Instruction::Comment(comment) => {
                Instruction::Comment(comment.clone())
            }
            invalid_instr => {
                panic!(format!("Instruction {:?} does not have registers to replace.", invalid_instr))
            },
        }
    }

    // Given a set of critical registers, if this instruction is critical (is a store, function call, or creates one
    // of the critical registers), returns a Some(registers it depends upon)
    pub fn is_critical(&self, critical_regs:&HashSet<String>) -> Option<HashSet<String>> {
        let mut new_crit_regs:HashSet<String> = HashSet::new();
        match self {
            Instruction::Store(typ, id, reg) => {
                new_crit_regs.insert(id.clone());
                new_crit_regs.insert(reg.clone());
                Some(new_crit_regs)
            },
            Instruction::Load(reg, typ, id) => {
                if critical_regs.contains(reg) {
                    new_crit_regs.insert(id.clone());
                    Some(new_crit_regs)
                } else {
                    None
                }
            },
            Instruction::Return(Some((typ, id))) => {
                new_crit_regs.insert(id.clone());
                Some(new_crit_regs)
            },
            Instruction::Return(None) => {
                // Return still needs to remain, even if it doesn't return a value
                Some(new_crit_regs)
            },
            Instruction::GetElementPtr(reg, typ, id, idx) => {
                if critical_regs.contains(reg) {
                    new_crit_regs.insert(id.clone());
                    Some(new_crit_regs)
                } else {
                    None
                }
            },
            Instruction::Call(ret_type, id, args) => {
                for (typ,id) in args {
                    new_crit_regs.insert(id.clone());
                }
                Some(new_crit_regs)
            },
            Instruction::CallAndAssign(reg, ret_type, id, args) => {
                for (typ,id) in args {
                    new_crit_regs.insert(id.clone());
                }
                Some(new_crit_regs)
            },
            Instruction::BitCast(reg, typ, id, to_typ) => {
                if critical_regs.contains(reg) {
                    new_crit_regs.insert(id.clone());
                    Some(new_crit_regs)
                } else {
                    None
                }
            },
            Instruction::Compare(reg, oper, typ, left, right) => {
                if critical_regs.contains(reg) {
                    new_crit_regs.insert(left.clone());
                    new_crit_regs.insert(right.clone());
                    Some(new_crit_regs)
                } else {
                    None
                }
            },
            Instruction::Logical(reg, oper, left, right) => {
                if critical_regs.contains(reg) {
                    new_crit_regs.insert(left.clone());
                    new_crit_regs.insert(right.clone());
                    Some(new_crit_regs)
                } else {
                    None
                }
            },
            Instruction::Arithmetic(reg, oper, typ, left, right) => {
                if critical_regs.contains(reg) {
                    new_crit_regs.insert(left.clone());
                    new_crit_regs.insert(right.clone());
                    Some(new_crit_regs)
                } else {
                    None
                }
            },
            Instruction::BranchUncond(label) => {
                Some(new_crit_regs)
            },
            Instruction::BranchCond(id, true_label, false_label) => {
                new_crit_regs.insert(id.clone());
                Some(new_crit_regs)
            },
            Instruction::Comment(comment) => {
                Some(new_crit_regs)
            }
        }
    }



    // If the instruction assigns to a virtual reg, and can be reduced (based upon what we know about the other operands),
    // then return the name of the virtual reg and its known value
    pub fn resolve(&self, all_virtual_regs:&HashSet<String>, known_virt_reg_values:&HashMap<String,LLVMOperand>) -> Option<(String,LLVMOperand)> {
        match self {
            Instruction::Store(_typ, _id, _reg) => {
                None
            },
            Instruction::Load(_reg, _typ, _id) => {
                None
            },
            Instruction::Return(_) => {
                None
            },
            Instruction::GetElementPtr(_reg, _typ, _id, _idx) => {
                None
            },
            Instruction::Call(_ret_type, _id, _args) => {
                None
            },
            Instruction::CallAndAssign(_reg, _ret_type, _id, _args) => {
                None
            },
            Instruction::BitCast(_reg, _typ, _id, _to_typ) => {
                None
            },
            Instruction::Compare(reg, oper, typ, left, right) => {
                let left_oper = resolve_local_register(string_to_llvm_operand(&left, all_virtual_regs), known_virt_reg_values);
                let right_oper = resolve_local_register(string_to_llvm_operand(&right, all_virtual_regs), known_virt_reg_values);
                match (left_oper, right_oper) {
                    (LLVMOperand::Number(left_num), LLVMOperand::Number(right_num)) => {
                        match oper.as_str() {
                            "eq" => { Some((reg.clone(), LLVMOperand::Boolean(left_num==right_num))) },
                            "ne" => { Some((reg.clone(), LLVMOperand::Boolean(left_num!=right_num))) },
                            "sgt" => { Some((reg.clone(), LLVMOperand::Boolean(left_num>right_num))) },
                            "slt" => { Some((reg.clone(), LLVMOperand::Boolean(left_num<right_num))) },
                            "sge" => { Some((reg.clone(), LLVMOperand::Boolean(left_num>=right_num))) },
                            "sle" => { Some((reg.clone(), LLVMOperand::Boolean(left_num<=right_num))) },
                            _ => panic!("Unknown comparison operator")
                        }
                    },
                    // Otherwise, there's no replacement to be done
                    _ => None
                }
            },
            Instruction::Logical(reg, oper, left, right) => {
                let left_oper = resolve_local_register(string_to_llvm_operand(&left, all_virtual_regs), known_virt_reg_values);
                let right_oper = resolve_local_register(string_to_llvm_operand(&right, all_virtual_regs), known_virt_reg_values);
                match (left_oper, right_oper) {
                    (LLVMOperand::Boolean(left_bool), LLVMOperand::Boolean(right_bool)) => {
                        match oper.as_str() {
                            "and" => { Some((reg.clone(), LLVMOperand::Boolean(left_bool && right_bool))) },
                            "or" => { Some((reg.clone(), LLVMOperand::Boolean(left_bool || right_bool))) },
                            _ => panic!("Unknown comparison operator")
                        }
                    },
                    // Otherwise, there's no replacement to be done
                    _ => None
                }
            },
            Instruction::Arithmetic(reg, oper, typ, left, right) => {
                let left_oper = resolve_local_register(string_to_llvm_operand(&left, all_virtual_regs), known_virt_reg_values);
                let right_oper = resolve_local_register(string_to_llvm_operand(&right, all_virtual_regs), known_virt_reg_values);
                match (left_oper, right_oper) {
                    (LLVMOperand::Number(left_num), LLVMOperand::Number(right_num)) => {
                        match oper.as_str() {
                            "add" => { Some((reg.clone(), LLVMOperand::Number(left_num+right_num))) },
                            "sub" => { Some((reg.clone(), LLVMOperand::Number(left_num-right_num))) },
                            "mul" => { Some((reg.clone(), LLVMOperand::Number(left_num*right_num))) },
                            "sdiv" => { Some((reg.clone(), LLVMOperand::Number(left_num/right_num))) },
                            _ => panic!("Unknown comparison operator")
                        }
                    },
                    // Otherwise, there's no replacement to be done
                    _ => None                        
                }
            },
            Instruction::BranchUncond(label) => {
                None
            },
            Instruction::BranchCond(id, true_label, false_label) => {
                None
            },
            Instruction::Comment(comment) => {
                None
            }
        }
    }
        



}

fn is_reg(id:&str) -> bool {
    id.starts_with("%")
}

// Replace reg with repl_reg if matches find_reg
fn rep(reg:&str, find_reg:&str, repl_reg:&str) -> String {
    if reg == find_reg {
        repl_reg.to_string()
    } else {
        reg.to_string()
    }
}

