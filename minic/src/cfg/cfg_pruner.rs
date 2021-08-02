
use super::cfg_builder::CFBlockTerminator;

// Block merging strategy
//
// foreach block in blocks
//   if block.terminator == UnconditionalBranch
//     let dest = block.terminator.dest()
//     if dest != block && dest.preds.count() == 1 {
//       block.instructions.extend(dest.instructions) // Move successor instructions to this block
//       block.term = dest.term
//       blocks.remove(dest)
//   }



impl super::cfg_builder::CFG {
    pub fn merge_blocks(&mut self) {
        for (id,func) in &mut self.functions {
            println!("== Pruning function {}", id);
            func.merge_blocks();
        }
    }
}

impl super::cfg_builder::CFFunction {
    fn merge_blocks(&mut self) {
        let mut changed = true;
        while changed {
            changed = false;
            let block_ids = self.block_order.clone();
            // println!("Block order is {:?}", block_ids);
            for block_id in block_ids {
                // println!("Checking {} for redundant successors", block_id);
                let term = self.blocks.get(&block_id).unwrap().term.clone();
                match term {
                    CFBlockTerminator::Jump{label:dest_label} => {
                        // println!("It has a single successor");
                        let dest_block = self.blocks.get(&dest_label).unwrap().clone();
                        // println!("  That successor has {} preds", dest_block.preds.len());
                        if dest_block.preds.len() == 1 {
                            // println!("Merging block_id {} with successor block {:?}", block_id, dest_block);
                            self.blocks.get_mut(&block_id).unwrap().stmts.extend(dest_block.stmts.clone());
                            self.blocks.get_mut(&block_id).unwrap().term = dest_block.term.clone();
                            self.blocks.remove(&dest_label);
                            // Recalculate the preds and block_order
                            self.set_preds_and_block_order();
                            changed = true;
                            break;
                        }
                    },
                    _ => {}
                }

                // println!("Checking {} for no statements", block_id);
                // Don't remove the start block
                if block_id != self.start_block {
                    if self.blocks.get(&block_id).unwrap().stmts.len() == 0 {
                        // println!("  We've got zero statements");
                        let term = self.blocks.get(&block_id).unwrap().term.clone();
                        match term {
                            // We have a single successor, so we can replace our preds' labels with our successor (regardless of whether they're conditional or not)
                            CFBlockTerminator::Jump{label:dest_label} => {
                                // println!("  Single successor");
                                let dest_block = self.blocks.get(&dest_label).unwrap().clone();
                                for pred_id in self.blocks.get(&block_id).unwrap().preds.clone() {
                                    match &self.blocks.get(&pred_id).unwrap().term {
                                        CFBlockTerminator::Jump{label:pred_dest_label} => {
                                            // println!("   Setting a pred's unconditional jump to our successor");
                                            self.blocks.get_mut(&pred_id).unwrap().term = CFBlockTerminator::Jump{
                                                label:dest_label.clone()
                                            };                             
                                        },
                                        CFBlockTerminator::CondJump{expr:expr, true_label, false_label} => {
                                            if *true_label == block_id {
                                            // println!("   Setting a pred's true jump to our successor");
                                                self.blocks.get_mut(&pred_id).unwrap().term = CFBlockTerminator::CondJump{
                                                    expr:expr.clone(),
                                                    true_label:dest_label.clone(),
                                                    false_label:false_label.clone()
                                                };                             
                                            } else {
                                                // println!("   Setting a pred's false jump to our successor");
                                                if *false_label == block_id {
                                                    self.blocks.get_mut(&pred_id).unwrap().term = CFBlockTerminator::CondJump{
                                                        expr:expr.clone(),
                                                        true_label:true_label.clone(),
                                                        false_label:dest_label.clone()
                                                    };        
                                                } else {
                                                    panic!("A predecessor block didn't have us as a successor");
                                                }
                                            }
                                        },
                                        _ => {}
                                    }
                                }
                                self.blocks.remove(&block_id);
                                // Recalculate the preds and block_order
                                self.set_preds_and_block_order();
                                changed = true;
                                break;
                            },
                            // If we have a conditional branch, then we can stick that on all of our preds ONLY if
                            // all of the preds have UNconditional branches
                            CFBlockTerminator::CondJump{expr:_, true_label, false_label} => {
                                // println!("For pruning and empty block with a conditional jump, we would need to verify all predecessors have unconditional jumps")            
                            },
                            _ => {}
                        }
                    }
                }
            }
        }
    }
}



