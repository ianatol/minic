
pub mod interferencegraph;

use super::instruction::Instruction;
use super::cfg::cfg_builder::{CFFunction,CFBlockTerminator};
use super::cfg::code_generator::{LLVMFunctionContext,Phi};
use std::collections::{HashMap,HashSet};

use interferencegraph::*;


pub struct DataFlow {
    pub gen: HashMap<String,HashSet<String>>,
    pub kill: HashMap<String,HashSet<String>>,
    pub live_out: HashMap<String,HashSet<String>>,
    pub all_virtual_regs: HashSet<String>,    
}

pub fn get_data_flow(cf_func:&CFFunction, function_context:&LLVMFunctionContext, block_instructions:&HashMap<String,Vec<Instruction>>) -> DataFlow {
    // self.build_virtual_regs
    // BUILD TABLE OF VIRTUAL REGS
    // Now that phis are created (and all trivial ones removed), we can find out all of the virtual registers used
    let mut data_flow:DataFlow = DataFlow {
        gen:HashMap::new(),
        kill:HashMap::new(),    
        live_out:HashMap::new(),
        all_virtual_regs:HashSet::new(),
    };

    for cur_block_id in block_instructions.keys() {
        // println!("Getting gen/kill for {}", cur_block_id);
        let mut block_gen:HashSet<String> = HashSet::new();
        let mut block_kill:HashSet<String> = HashSet::new();

        // Here's check all of the phis (which count as assignments)
        if function_context.phis.contains_key(cur_block_id) {
            for (assigned_llvm_reg, phi) in function_context.phis.get(cur_block_id).unwrap() {
                let mut instr_kill:HashSet<String> = HashSet::new();
                let mut instr_gen:HashSet<String> = HashSet::new();
                // for assigned_llvm_reg in phis.keys() {
                    // let phi = phis.get(assigned_llvm_reg).unwrap();
                    // println!("Found a phi assigning to {}", assigned_llvm_reg);
                    data_flow.all_virtual_regs.insert(assigned_llvm_reg.clone());
                    instr_kill.insert(assigned_llvm_reg.clone());
                    for oper in &phi.operands {
                        // Only add virtual registers... not values
                        if oper.reg_id.as_ref().unwrap().starts_with('%') {
                            data_flow.all_virtual_regs.insert(oper.reg_id.as_ref().unwrap().clone());
                            instr_gen.insert(oper.reg_id.as_ref().unwrap().clone());
                        }
                    }
                // println!("instruction_kill: {:?}   instruction_gen: {:?}", instr_kill, instr_gen);
                let block_gen_add:HashSet<String> = instr_gen.difference(&block_kill).cloned().collect();
                block_gen = block_gen.union(&block_gen_add).cloned().collect();
                block_kill = block_kill.union(&instr_kill).cloned().collect();
                // println!("block_kill: {:?}    block_gen: {:?}", block_kill, block_gen);
            }
        }

        for instruction in block_instructions.get(cur_block_id).unwrap() {
            let (instr_kill,instr_gen) = instruction.get_kill_gen();
            // println!("instruction_kill: {:?}   instruction_gen: {:?}", instr_kill, instr_gen);
            // Make sure we get all virtual regs
            data_flow.all_virtual_regs.extend(instr_kill.clone());
            data_flow.all_virtual_regs.extend(instr_gen.clone());
            let block_gen_add:HashSet<String> = instr_gen.difference(&block_kill).cloned().collect();
            block_gen = block_gen.union(&block_gen_add).cloned().collect();
            block_kill = block_kill.union(&instr_kill).cloned().collect();
            // println!("block_kill: {:?}    block_gen: {:?}", block_kill, block_gen);
        }
        // We don't have to look at block terminators because they're already encoded into the instructions
        data_flow.gen.insert(cur_block_id.clone(), block_gen);
        data_flow.kill.insert(cur_block_id.clone(), block_kill);
        data_flow.live_out.insert(cur_block_id.clone(), HashSet::new());
    }
    // Lastly, add the parameters of the function to start block's kill set
    for parm in &cf_func.parms {
        data_flow.kill.get_mut(&cf_func.start_block).unwrap().insert(format!("%{}",parm.id));
        data_flow.all_virtual_regs.insert(format!("%{}",parm.id));
    }

    println!("All kill sets are:");
    for block_id in data_flow.kill.keys() {
        println!("{} = {:?}", block_id, data_flow.kill[block_id]);
    }

    data_flow
}

pub fn build_live_in_out(cf_func:&CFFunction, data_flow:&mut DataFlow) {
    let mut changed:bool = true;            
    while changed {
        changed = false;
        // Go through all blocks and get their new live_out's... if any changed, then we need to loop again
        for cur_block_id in data_flow.gen.keys() {
            // print!("Calculating the LiveOut for {}", cur_block_id);
            match &cf_func.blocks.get(cur_block_id).unwrap().term {
                CFBlockTerminator::Jump{label} => {
                    // println!(" with one successor: {}", label);
                    let new_live_out = get_live_in_for_block_id(data_flow, &label);
                    if data_flow.live_out[cur_block_id] != new_live_out {
                        // println!("LiveOut for block {} changed to {:?}", cur_block_id, &new_live_out);
                        data_flow.live_out.insert(cur_block_id.clone(), new_live_out);
                        changed = true;
                    }
                },
                CFBlockTerminator::CondJump{expr:_, true_label, false_label} => {
                    // println!(" with successors: {} and {}", true_label, false_label);
                    let mut new_live_out:HashSet<String> = get_live_in_for_block_id(data_flow, &true_label);
                    new_live_out = new_live_out.union(&get_live_in_for_block_id(data_flow, &false_label)).cloned().collect::<HashSet<String>>();
                    if data_flow.live_out[cur_block_id] != new_live_out {
                        // println!("LiveOut for block {} changed to {:?}", cur_block_id, &new_live_out);
                        data_flow.live_out.insert(cur_block_id.clone(), new_live_out);
                        changed = true;
                    }
                },
                // Anything has no successors
                _ => {
                    // println!(" which has NO successors")
                },
            }
        }            
    }
}

pub fn get_live_in_for_block_id(data_flow:&DataFlow, block_id:&str) -> HashSet<String> {
    // println!("Getting live_in for block {}", block_id);
    // LiveIn is the gen unioned with (live_out - kill)
    let mut live_in = data_flow.live_out[block_id].clone();
    live_in = live_in.difference(&data_flow.kill[block_id].clone()).cloned().collect();
    live_in = live_in.union(&data_flow.gen[block_id]).cloned().collect();
    // println!("live_in for {} is {:?}", block_id, live_in);
    live_in
}

pub fn remove_non_critical_instructions(function_context:&mut LLVMFunctionContext, block_instructions:&mut HashMap<String,Vec<Instruction>>, data_flow:&DataFlow) -> bool {
    // We assume that data_flow.live_out is correct, at this point
    let mut instructions_removed = false;
    let mut changed_in_loop:bool = true;            
    while changed_in_loop {
        println!("Doing a dead-code-removal pass");
        changed_in_loop = false;
        let mut new_block_instructions:HashMap<String,Vec<Instruction>> = HashMap::new();

        // Go through all blocks and remove non_critical instructions
        for cur_block_id in block_instructions.keys() {

            let mut new_instructions:Vec<Instruction> = Vec::new();
            let mut live_set = data_flow.live_out[cur_block_id].clone();
            // Example of iterating through the instructions backward
            for instruction in block_instructions.get(cur_block_id).unwrap().clone().into_iter().rev() {
                match instruction.is_critical(&live_set) {
                    None => {
                        instructions_removed = true;
                        changed_in_loop = true;
                        println!("Looks like {:?} is not needed", instruction);
                    },
                    Some(more_live) => {
                        new_instructions.push(instruction.clone());
                        live_set = live_set.union(&more_live).cloned().collect();
                    }
                }
            }
            new_instructions.reverse();
            new_block_instructions.insert(cur_block_id.clone(), new_instructions);
            let new_phis:HashMap<String,HashMap<String,Phi>> = HashMap::new();

            if function_context.phis.contains_key(cur_block_id) {
                let block_phis = function_context.phis.get_mut(cur_block_id).unwrap();
                let mut new_phis_for_this_block:HashMap<String,Phi> = HashMap::new();
                for (assigned_reg,phi) in block_phis.iter() {
                    match phi.is_critical(&live_set, assigned_reg) {
                        None => {
                            instructions_removed = true;
                            changed_in_loop = true;
                            println!("Looks like phi using {:?} is not needed", assigned_reg);
                        },
                        Some(more_live) => {
                            new_phis_for_this_block.insert(assigned_reg.clone(), phi.clone());
                            live_set = live_set.union(&more_live).cloned().collect();
                        }
                    }
                }
                function_context.phis.insert(cur_block_id.clone(), new_phis_for_this_block);
            }
        }

        // Copy the new instruction lists to where they need to be
        for cur_block_id in new_block_instructions.keys() {
            block_instructions.insert(cur_block_id.clone(), new_block_instructions[cur_block_id].clone());
        }
    }
    instructions_removed
}

pub fn build_interference_graph(data_flow:&DataFlow, function_context:&LLVMFunctionContext, block_instructions:&HashMap<String,Vec<Instruction>>) -> InterferenceGraph {
    // println!("===================");
    // println!(" Building interference graph");
    // println!("===================");

    let mut graph = InterferenceGraph::new();

    for cur_block_id in block_instructions.keys() {

        // Go through all the instructions in this block... BACKWARDS
        let mut backward_instructions = block_instructions[cur_block_id].clone();
        backward_instructions.reverse();
        // Start with the LiveOut for this block
        let mut live_set = data_flow.live_out[cur_block_id].clone();
        for instruction in backward_instructions {
            let (instr_kill,instr_gen) = instruction.get_kill_gen();
            // If there's anything in instr_kill, remove it from live_out and create edges from this node to all remaining in live_out
            for node in instr_kill {
                // println!("Removing {} from live_set:{:?}", node, live_set);
                if ! live_set.contains(&node) {
                    println!("Looks like {} not in the live set. Defined but never used?", node);
                    // panic!("How is {} not in the live set? Defined and never used?", node);
                }
                live_set.remove(&node);
                for other_node in &live_set {
                    graph.add_node(&node);
                    graph.add_node(&other_node);
                    graph.add_edge(&node, &other_node);
                }
            }
            // Now, add anything in the gen set to live_set
            for var in instr_gen {
                live_set.insert(var.clone());
            }
        }

        // Check the phis (which count as assignments)
        if function_context.phis.contains_key(cur_block_id) {
            for (assigned_llvm_reg, phi) in &function_context.phis[cur_block_id] {
                let mut instr_kill:HashSet<String> = HashSet::new();
                let mut instr_gen:HashSet<String> = HashSet::new();
                // println!("While building the interference graph, found a phi assigning to {}", assigned_llvm_reg);

                instr_kill.insert(assigned_llvm_reg.clone());
                for node in &instr_kill {
                    // println!("Removing {} from live_set:{:?}", node, live_set);
                    if ! live_set.contains(node) {
                        panic!("How is {} not in the live set? Defined and never used?", node);
                    }
                    live_set.remove(node);
                    for other_node in &live_set {
                        graph.add_node(&node);
                        graph.add_node(&other_node);
                        graph.add_edge(&node, &other_node);
                    }
                }

                for oper in &phi.operands {
                    // Only add virtual registers... not values
                    if oper.reg_id.as_ref().unwrap().starts_with('%') {
                        instr_gen.insert(oper.reg_id.as_ref().unwrap().clone());
                    }
                }
                // Now, add anything in the gen set to live_set
                for var in &instr_gen {
                    live_set.insert(var.clone());
                }
                // println!("instruction_kill: {:?}   instruction_gen: {:?}", instr_kill, instr_gen);
            }
        }
        println!("Emptying out the live set");
        let mut remaining_regs:Vec<String> = live_set.iter().cloned().collect();
        while remaining_regs.len() > 0 {
            let node = remaining_regs.pop().unwrap();
            for other_node in &remaining_regs {
                graph.add_node(&node);
                graph.add_node(&other_node);
                graph.add_edge(&node, &other_node);
            }
        }
    }
    // println!("Total graph is {}", graph);
    graph
}

pub fn color_interference_graph(graph:&InterferenceGraph, registers:&Vec<String>, pre_assigned_regs:&HashMap<String,String>) -> HashMap<String,Option<String>> {
    let mut reg_assignments:HashMap<String,Option<String>> = HashMap::new();
    let mut node_stack:Vec<(String, HashSet<InterferenceEdge>)> = Vec::new();
    let mut parm_stack:Vec<(String, HashSet<InterferenceEdge>)> = Vec::new();
    let mut graph = graph.clone();
    while graph.nodes.len() > 0 {
        let unconstrained_nodes = graph.get_unconstrained_nodes(registers.len());
        if unconstrained_nodes.len() > 0 {
            // Take the first one
            let node_id:String = unconstrained_nodes.iter().cloned().collect::<Vec<String>>()[0].clone();
            println!("Selecting constrained node {} (with {} edges) for removal", node_id, graph.get_edge_count(&node_id));
            if ! pre_assigned_regs.contains_key(&node_id) {
                node_stack.push((node_id.clone(), graph.remove_node_and_edges(&node_id)));
            } else {
                parm_stack.push((node_id.clone(), graph.remove_node_and_edges(&node_id)));
                println!("Not putting in the stack, because it has been pre-assigned {}", pre_assigned_regs[&node_id]);
            }
        } else {
            // No unconstrained nodes, just take another one
            println!("No unconstrained nodes left");
            let node_id = graph.all_nodes().iter().cloned().collect::<Vec<String>>()[0].clone();
            println!("Selecting {} (with {} edges) for removal", node_id, graph.get_edge_count(&node_id));
            if ! pre_assigned_regs.contains_key(&node_id) {
                node_stack.push((node_id.clone(), graph.remove_node_and_edges(&node_id)));
            } else {
                parm_stack.push((node_id.clone(), graph.remove_node_and_edges(&node_id)));
                println!("Not putting in the stack, because it has been pre-assigned {}", pre_assigned_regs[&node_id]);
            }
        }
    }
    println!("=== Parm stack is ===");
    for edge in &parm_stack {
        println!("  {:?}", edge);
    }
    println!("=== Node stack is ===");
    for edge in &node_stack {
        println!("  {:?}", edge);
    }

    // First, we put in the pre-assigned registers (which should be up to the first four arguments)
    // for (virt_reg1, real_reg1) in pre_assigned_regs {
    //     // Make all parms connected
    //     graph.add_node(virt_reg1);
    //     for (virt_reg2, real_reg2) in pre_assigned_regs {
    //         graph.add_node(virt_reg2);
    //         if virt_reg1 != virt_reg2 {
    //             graph.add_edge(virt_reg1, virt_reg2);
    //         }
    //     }
    //     reg_assignments.insert(virt_reg1.to_string(), Some(real_reg1.to_string()));
    // }

    while parm_stack.len() > 0 {
        // Grab a node from the stack
        let (node, edges) = parm_stack.pop().unwrap();
        // Not its register assignment
        reg_assignments.insert(node.clone(), Some(pre_assigned_regs[&node].clone()));

        // Add it to the graph
        println!("Adding node {}", node);
        graph.add_node(&node);
        // Add all of the edges to parms
        for edge in &edges {
            graph.add_node(&edge.node1);
            graph.add_node(&edge.node2);
            graph.add_edge(&edge.node1, &edge.node2);
            // Because nodes we add later will want to be able to find out these nodes' colors, we need to add them
            // if they're not already there
            if ! reg_assignments.contains_key(&edge.node1) {
                println!("{} is connected to {}, but that's still on the stack, so we give it None color for now", node, edge.node1);
                reg_assignments.insert(edge.node1.clone(), None);
            }
            if ! reg_assignments.contains_key(&edge.node2) {
                println!("{} is connected to {}, but that's still on the stack, so we give it None color for now", node, edge.node2);
                reg_assignments.insert(edge.node2.clone(), None);
            }
        }
        // Also connect us to every other node that's already there (since all parms interfere with each other)
        for other_node in &graph.nodes.clone() {
            if &node != other_node {
                graph.add_edge(&node, other_node);
            }
        }
    }

    println!("Coloring...");
    while node_stack.len() > 0 {
        // Grab a node from the stack
        let (node, edges) = node_stack.pop().unwrap();
        // Add it to the graph
        println!("Adding node {}", node);
        graph.add_node(&node);
        for edge in &edges {
            graph.add_edge(&edge.node1, &edge.node2);
        }
        // Now, find all of the colors/registers we're connected to
        reg_assignments.insert(node.clone(), None); // This virtual register has no color, yet
        let mut used_colors:HashSet<String> = HashSet::new();
        let connected = graph.get_nodes_connected_to(&node);
        for connected_node in connected {
            println!("   it's connected to {}", connected_node);
            match &reg_assignments[&connected_node] {
                None => { println!("   and it's uncolored"); }, // The other node doesn't have a color/register
                Some(reg) => {
                    println!("   and it has color {}", reg);
                    used_colors.insert(reg.clone()); 
                },
            }
        }
        // Now, see if there's a color left for us
        println!("Finding a color we can use for {}", node);
        for reg in registers {
            if ! used_colors.contains(reg) {
                println!("Looks like {} is available", reg);
                reg_assignments.insert(node.clone(), Some(reg.clone()));
                break;
            }
        }
        println!("Assignments are now: {:?}", reg_assignments);
    }
    reg_assignments
}