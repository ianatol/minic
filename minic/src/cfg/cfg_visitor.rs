
use std::collections::{HashSet,HashMap};
use std::cmp::Ordering;

use super::cfg_builder::{CFBlock,CFBlockTerminator};
use super::super::instruction::{Instruction,LLVMOperand};


#[derive(Debug,Clone,Eq)]
enum LLVMCodeReference {
    InstructionReference{block_id:String, idx:usize},
    PhiReference{block_id:String, virt_reg:String},
}

// The next three impl's are so that we can sort vectors of LLVMCodeReferences (and then reverse them)
// so that we can delete instructions from the tail toward the front
impl Ord for LLVMCodeReference {
    fn cmp(&self, other: &Self) -> Ordering {

        match (&self, &other) {
            (LLVMCodeReference::InstructionReference{block_id:self_block_id, idx:self_idx},
                LLVMCodeReference::InstructionReference{block_id:other_block_id, idx:other_idx}) => {
                    if self_block_id != other_block_id {
                        self_block_id.cmp(other_block_id)
                    } else {
                        self_idx.cmp(other_idx)
                    }
            },
            // Anything other than two instructions, it doesn't matter if we do them out of order
            (_,_) => Ordering::Equal,
        }
    }
}

impl PartialOrd for LLVMCodeReference {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        Some(self.cmp(other))
    }
}

impl PartialEq for LLVMCodeReference {
    fn eq(&self, other: &Self) -> bool {
        match (&self, &other) {
            (LLVMCodeReference::InstructionReference{block_id:self_block_id, idx:self_idx},
                LLVMCodeReference::InstructionReference{block_id:other_block_id, idx:other_idx}) => 
                    self_block_id==other_block_id && self_idx==other_idx,
            (LLVMCodeReference::PhiReference{block_id:self_block_id, virt_reg:self_virt_reg},
                LLVMCodeReference::PhiReference{block_id:other_block_id, virt_reg:other_virt_reg}) => 
                    self_block_id==other_block_id && self_virt_reg==other_virt_reg,
            (_,_) => false,
        }
    }
}

pub fn propagate_constants(function_context:&mut super::code_generator::LLVMFunctionContext, block_instructions:&mut HashMap<String,Vec<Instruction>>) {

    // println!("BEFORE CONSTANT PROP:");
    // dump_all_instructions(block_instructions);

    // Where is a given virtual register being defined?
    let mut defining_instructions:HashMap<String,LLVMCodeReference> = HashMap::new();
    // Where is a given virtual register being used?
    let mut using_instructions:HashMap<String,Vec<LLVMCodeReference>> = HashMap::new();

    // Look at all of the phis
    for (cur_block_id,phis) in &function_context.phis {
        println!("Getting gen/kill for phis for block {}", cur_block_id);
        for (assigned_reg,phi) in phis {
            println!("   {} - {:?}", assigned_reg, phi);
            let gen = phi.get_gen_set();
            // We need to add _this_ phi to the using instructions vector for the registers in the gen set
            if defining_instructions.contains_key(assigned_reg) {
                panic!("defining_instructions can't already have an entry for {}", &assigned_reg);
            }
            defining_instructions.insert(
                assigned_reg.to_string(),
                LLVMCodeReference::PhiReference{
                    block_id:cur_block_id.clone(),
                    virt_reg:assigned_reg.to_string()
                }
            );
            for used_reg in &gen {
                if ! using_instructions.contains_key(used_reg) {
                    using_instructions.insert(used_reg.clone(), Vec::new());
                }
                using_instructions.get_mut(used_reg).unwrap().push(
                    LLVMCodeReference::PhiReference{
                        block_id:cur_block_id.clone(),
                        virt_reg:assigned_reg.to_string()
                    }
                );
            }
        }
    }

    // Look at all instructions
    for (cur_block_id,instructions) in block_instructions.iter() {
        println!("Getting gen/kill instructions for block {}", cur_block_id);
        for (idx,instruction) in instructions.iter().enumerate() {
            println!("   {} - {:?}", idx, instruction);
            let (kill,gen) = instruction.get_kill_gen();
            for virt_reg in kill {
                if defining_instructions.contains_key(&virt_reg) {
                    panic!("defining_instructions can't already have an entry for {}", &virt_reg);
                }
                defining_instructions.insert(
                    virt_reg,
                    LLVMCodeReference::InstructionReference{
                        block_id:cur_block_id.to_string(),
                        idx:idx
                    }
                );
            }
            for virt_reg in &gen {
                if ! using_instructions.contains_key(virt_reg) {
                    using_instructions.insert(virt_reg.clone(), Vec::new());
                }
                using_instructions.get_mut(virt_reg).unwrap().push(
                    LLVMCodeReference::InstructionReference{
                        block_id:cur_block_id.to_string(),
                        idx:idx
                    }
                );
            }
        }
    }

    // for (virt_reg, instr) in &defining_instructions {
    //     println!("  {} is defined at {:?}", virt_reg, instr);
    // }

    let all_virtual_regs = using_instructions.keys().cloned().collect::<HashSet<String>>();
    let mut known_virt_reg_values:HashMap<String,LLVMOperand> = HashMap::new();
    
    // Find all virtual registers that can be replaced with constants
    let mut worklist:Vec<LLVMCodeReference> = defining_instructions.values().cloned().collect();
    while worklist.len() > 0 {
        println!("Worklist is {} long", worklist.len());
        let instruction_to_check = worklist.pop().unwrap();
        println!("Checking instruction {:?}", instruction_to_check);
        match &instruction_to_check {
            LLVMCodeReference::InstructionReference{block_id, idx} => {
                let instruction = &block_instructions[block_id][*idx];
                match instruction.resolve(&all_virtual_regs, &known_virt_reg_values) {
                    None => {},
                    Some((reg_id,llvm_value)) => {
                        // The instruction was able to resolve to something
                        println!("{:?} reduces to {}={:?}", instruction, reg_id, llvm_value);
                        if known_virt_reg_values.contains_key(&reg_id) {
                            // There's already a known value
                            if known_virt_reg_values[&reg_id] != llvm_value {
                                // panic!("Found two different values for {}", reg_id);
                            }
                        } else {
                            // We have new information about a variable
                            println!("That's news we can use!");
                            if using_instructions.contains_key(&reg_id) {
                                println!("  So, we're adding {:?} to the worklist", using_instructions[&reg_id]);
                                // Add any instructions which use this register
                                worklist.extend(using_instructions[&reg_id].clone());
                                // println!("worklist now has {:?}", worklist);
                            } else {
                                println!("Interesting... there isn't any instruction which even uses {}", reg_id);
                                using_instructions.insert(reg_id.clone(), Vec::new());
                            }
                            known_virt_reg_values.insert(reg_id, llvm_value);
                        }
                    }
                }    
            },
            LLVMCodeReference::PhiReference{block_id, virt_reg} => {
                // println!("Getting a phi from block {} with virtual reg {}", block_id, virt_reg);
                let phi = function_context.phis.get(block_id).unwrap().get(virt_reg).unwrap();
                match phi.resolve(&all_virtual_regs, &known_virt_reg_values) {
                    None => {},
                    Some(llvm_value) => {
                        // The instruction was able to resolve to something
                        println!("{:?} reduces to {}={:?}", phi, virt_reg, llvm_value);
                        if known_virt_reg_values.contains_key(virt_reg) {
                            // There's already a known value
                            if known_virt_reg_values[virt_reg] != llvm_value {
                                panic!("Found two different values for {}", virt_reg);
                            }
                        } else {
                            // We have new information about a variable
                            println!("That's news!");
                            // Add any instructions which use this register
                            worklist.extend(using_instructions[virt_reg].clone());
                            known_virt_reg_values.insert(virt_reg.to_string(), llvm_value);
                        }
                    }
                }    
            }
        }
    }

    println!("All known replacements are: {:?}", known_virt_reg_values);

    // At this point, known_virt_reg_values should contain all virtual registers that we can replace with
    // constant values. So we can replace them in all instructions and we can also delete the instructions
    // which define them
    let mut instructions_to_delete:Vec<LLVMCodeReference> = Vec::new();
    // Pick a virtual register that we can replace
    for (virt_reg, replacement) in &known_virt_reg_values {
        println!("  Preparing to replace {} with {:?}", virt_reg, replacement);
        for instruction_needing_replacement in &using_instructions[virt_reg] {
            match instruction_needing_replacement {

                LLVMCodeReference::InstructionReference{block_id, idx} => {
                    let mut instruction_vec = block_instructions.get_mut(block_id).unwrap();
                    // println!("We should replace {} with {} in {:?} ({:?})", virt_reg, replacement, instruction_needing_replacement, instruction_vec[*idx]);
                    let new_instruction = instruction_vec[*idx].replace(virt_reg, &replacement.to_string());
                    let old_inst = std::mem::replace(&mut instruction_vec[*idx], new_instruction);
                },
                LLVMCodeReference::PhiReference{block_id, virt_reg:assigned_reg} => {
                    println!("Getting a phi from block {} with virtual reg {}", block_id, assigned_reg);
                    let phi = function_context.phis.get_mut(block_id).unwrap().get_mut(assigned_reg).unwrap();
                    phi.replace_register(virt_reg, &replacement.to_string());
                    println!("We should replace {} with {} in {:?} (and then check it for being trivial)", virt_reg, replacement, phi);
                }
            }
        }

        // Lastly add its defining instruction to the list of stuff to delete
        instructions_to_delete.push(defining_instructions[virt_reg].clone());
    }

    instructions_to_delete.sort();
    instructions_to_delete.reverse();
    for instruction_needing_deletion in instructions_to_delete {
        // println!("We need to delete {:?}", instruction_needing_deletion);
        match instruction_needing_deletion {
            LLVMCodeReference::InstructionReference{block_id, idx} => {
                block_instructions.get_mut(&block_id).unwrap().remove(idx);
            },
            LLVMCodeReference::PhiReference{block_id, virt_reg} => {
                function_context.phis.get_mut(&block_id).unwrap().remove(&virt_reg);
            }
        }
    }

    // println!("AFTER CONSTANT PROP:");
    // dump_all_instructions(block_instructions);
}

pub fn dump_all_instructions(block_instructions:&HashMap<String,Vec<Instruction>>) {
    for (block_id, instructions) in block_instructions.iter() {
        for instruction in instructions {
            match instruction {
                Instruction::Comment(_) => {},
                _ => {
                    println!("{:?}", instruction);
                }
            }
        }
    }
}

