use std::collections::{HashMap,HashSet,VecDeque};

use super::super::ast::*;
use super::super::instruction::Instruction;
use super::UniqueNameFactory;


// A CFG (Control Flow Graph) contains a hashtable of functions
// and the name of the starting function ('main', ostensibly)
#[derive(Debug)]
pub struct CFG {
    pub types: Vec<TypeDeclaration>,
    pub declarations: Vec<Decl>,
    pub functions:HashMap<String,CFFunction>,
    start_function:String,
}

#[derive(Debug, Clone)]
pub struct CFFunction {
    pub parms:Vec<Decl>,
    pub decls:Vec<Decl>,
    pub ret_type:Datatype,
    pub blocks:HashMap<String,CFBlock>,
    pub block_order:Vec<String>, // A more-or-less topologically-sorted list of block id's
    pub start_block:String,
    pub exit_block:String,
}

impl CFFunction {
    fn append_stmt_to_block_id(&mut self,stmt:&Statement,block_id:&str) {
        let block = self.blocks.get_mut(block_id).unwrap();
        block.append_stmt(stmt);
    }

    pub fn get_blocks(&self) -> HashMap<String,CFBlock> {
        self.blocks.clone()
    }

    pub fn set_preds_and_block_order(&mut self) {
        // Clear out whatever is there
        for block in self.blocks.values_mut() {
            block.preds = HashSet::new();
        }
        // Reset the block order
        self.block_order = Vec::new();

        // Now, let's set the predecessors by starting at start and following the jumps
        let mut queue = VecDeque::<String>::new();
        let mut seen = HashSet::<String>::new();
        queue.push_back(self.start_block.clone());
        // println!("Queue len is {}",queue.len());
        while queue.len() > 0 {
            let cur_block_id = queue.pop_front().unwrap();
            self.block_order.push(cur_block_id.clone());
            seen.insert(cur_block_id.clone());
            // println!("Processing block {}",cur_block_id);
            let block = self.blocks.get_mut(&cur_block_id).unwrap();

            // Check to see if the block doesn't have any statements
            if block.stmts.len() == 0 {
                // println!("Block {} is empty", cur_block_id);
            }

            let term = block.term.clone();
            std::mem::drop(block);
            let children:Vec<String> = match &term {
                CFBlockTerminator::Undef => {
                    panic!("Block {} is UNDEFINED", cur_block_id);
                },
                CFBlockTerminator::Return => {
                    // println!("Block {} is the return block", cur_block_id);
                    vec!()
                },
                CFBlockTerminator::Jump{label} => vec!(label.to_string()),
                CFBlockTerminator::CondJump{expr:_, true_label, false_label} => vec!(true_label.to_string(),false_label.to_string()),
            };
            for label in children.iter() {
                let target_block = self.blocks.get_mut(label).unwrap();
                target_block.preds.insert(cur_block_id.clone());
                if ! seen.contains(label) && ! queue.contains(label) {
                    // println!("Adding {} to the queue",label);
                    queue.push_back(label.clone());
                }
            }
        }
        for block_id in self.blocks.keys() {
            if ! seen.contains(block_id) {
                panic!("ERROR: We have an orphan block (no predecessors) named : {}",block_id);
            }
        }

    }
}

// #[derive(Eq,Debug,Clone)]
// enum CFGDatatype {
//     Void,
//     Null,
//     Bool,
//     Int,
//     Structure{id:String},
//     Ref(Box<CFGDatatype>),
// }

// impl PartialEq for CFGDatatype {
//     fn eq(&self, other: &Self) -> bool {
//        match (self,other) {
//           (CFGDatatype::Void,CFGDatatype::Void) => true,
//           (CFGDatatype::Bool,CFGDatatype::Bool) => true,
//           (CFGDatatype::Int,CFGDatatype::Int) => true,
//           // Null types match any structure
//           (CFGDatatype::Null,CFGDatatype::Structure{id:_}) => true,
//           (CFGDatatype::Structure{id:_},CFGDatatype::Null) => true,
//           // Structs must be of the same name
//           (CFGDatatype::Structure{id:id1},CFGDatatype::Structure{id:id2}) => id1==id2,
//           // References must point to equivalent datatypes
//           (CFGDatatype::Ref(inner1),CFGDatatype::Ref(inner2)) => inner1==inner2,
//           // Any other combo is not equal
//           (_,_) => false,
//        }
//     }
//  }


// A CFBlock (Control Flow Block) contains a set of statements
// and a termination jump (either a return, an unconditional jump, or a
// conditional jump)
#[derive(Debug, Clone)]
pub struct CFBlock {
    pub id: String,
    pub stmts:Vec<Statement>,
    pub term:CFBlockTerminator,
    pub preds:HashSet<String>,
    pub instructions:Vec<Instruction>,
}

impl CFBlock {
    fn append_stmt(&mut self,stmt:&Statement) {
        self.stmts.push(stmt.clone());
    }
}

// A CFBlockTerminator is just what we should do at the end of this block
// Do we return, do an unconditional jump, or a if/then/else jump
#[derive(Debug,Clone)]
pub enum CFBlockTerminator {
    Return,
    Jump{label:String},
    CondJump{expr:Expression,true_label:String,false_label:String},
    Undef, // Undef means that we haven't determined what this should do, yet
}

// All of the things a function needs in order to properly insert a statement into a CFFunction
// (so we're not passing all four of them around)
struct CFGBlockBuilderContext {
    current_block_id:String,
    exit_block_id:String,
    // return_var:String,
    block_name_factory:UniqueNameFactory,
}

impl CFGBlockBuilderContext {
    fn create_new_block(&mut self, cf_func:&mut CFFunction) -> String {
        let block_name = self.block_name_factory.next();
        self.create_new_block_with_id(cf_func, &block_name);
        block_name
    }

    fn create_new_block_with_id(&mut self, cf_func:&mut CFFunction, id:&str) {
        cf_func.blocks.insert(
            id.to_string(),
            CFBlock {
                id:id.to_string(),
                stmts:Vec::new(),
                term:CFBlockTerminator::Undef,
                preds:HashSet::new(),
                instructions:Vec::new(),
            }
        );
    }

    fn delete_block_with_id(&self, cf_func:&mut CFFunction, id:&str) {
        cf_func.blocks.remove(id);
    }
}

struct CFGBlockResult {
    // current_block_id:String,
    return_equiv:bool,
}

impl AST {
    pub fn gen_cfg(&self) -> Result<CFG,String> {
        // Start with an empty hashmap and a start block of "main"
        let mut cfg = CFG{
            types: self.types.clone(),
            declarations: self.declarations.clone(),
            functions:HashMap::new(),
            start_function:"main".to_string(),
        };

        // TODO Create data types
        // TODO Create global vars

        //create symbol table with globals

        println!("Create CFFunction for each function");
        for func in &self.functions {
            // Transform one function
            match func.make_cffunction() {
                Ok(cffunc) => {
                    // If transformation went ok, then add it to the hashmap
                    cfg.functions.insert(func.id.clone(), cffunc);
                },
                Err(msg) => return Err(msg)
            }
        }
        Ok(cfg)
    }
}

impl Function {
    //Function:
    //      pub id: String,
    //      pub parms: Vec<Decl>,
    //      pub decls: Vec<Decl>,
    //      pub return_type: Datatype,
    //      pub stmts: Vec<Statement>,
    fn make_cffunction(&self) -> Result<CFFunction,String> {

        let start_block_id = format!("{}_start",self.id);
        let exit_block_id = format!("{}_exit",self.id);
        let block_name_factory = UniqueNameFactory::new(format!("L{}_",self.id));

        let mut builder_context = CFGBlockBuilderContext {
            current_block_id:start_block_id.clone(),
            exit_block_id:exit_block_id.clone(),
            // return_var:"%_retval_".to_string(),
            block_name_factory,
        };

        // If it's a structure, we make a pointer to it
        let llvm_return_type = match &self.return_type {
            // Structures are passed by reference, so we wrap it into a reference here
            Datatype::Structure{id} => Datatype::Ref(Box::new(self.return_type.clone())),
            // Otherwise, just clone it
            _ => self.return_type.clone(),
        };

        let mut cf_func = CFFunction {
            blocks:HashMap::new(),
            start_block:start_block_id.clone(),
            exit_block:exit_block_id.clone(),
            block_order:Vec::new(),
            decls:Vec::new(),
            parms:Vec::new(),
            ret_type:llvm_return_type,
        };

        builder_context.create_new_block_with_id(&mut cf_func, &start_block_id);
        builder_context.create_new_block_with_id(&mut cf_func, &exit_block_id);
        cf_func.blocks.get_mut(&exit_block_id).unwrap().term = CFBlockTerminator::Return;

        //Add the parameters to the parms table
        for parm in &self.parms {
            cf_func.parms.push(
                Decl{
                    id:parm.id.clone(),
                    datatype:
                        match &parm.datatype {
                            // Structures are passed by reference, so we wrap it into a reference here
                            Datatype::Structure{id} => Datatype::Ref(Box::new(parm.datatype.clone())),
                            // Otherwise, just clone it
                            _ => parm.datatype.clone(),
                        }
                }
            );
            //println!("### added {:?} to yield {:?}", parm, cf_func.locals);
        }
        // cf_func.parms = self.parms.clone();

        //Do we need to deal with structs as above here?
        cf_func.decls = self.decls.clone();

        for stmt in &self.stmts {
            match stmt.add_to_cffunc(&mut cf_func,&mut builder_context) {
                Ok(result) => {
                    // println!("Checking statement {} typechecked and return-equiv={}",stmt,return_equiv);
                    if result.return_equiv {
                        break;
                    }
                },
                Err(msg) => return Err(format!("In function {}, adding statement:\n   {}\nto a CFFunction failed because:\n  {}",self.id,stmt,msg)),
            }
        }
        // Once we get here, we've exhausted all of the statements (or encountered a return-equiv one, so
        // we must jump to the exit)
        cf_func.blocks.get_mut(&builder_context.current_block_id).unwrap().term = CFBlockTerminator::Jump{label:exit_block_id.clone()};
        cf_func.set_preds_and_block_order();
        Ok(cf_func)
    }
}

impl Statement {
    // Returns new current block
    fn add_to_cffunc(&self, mut cf_func:&mut CFFunction, mut builder_context:&mut CFGBlockBuilderContext) -> Result<CFGBlockResult,String> {
        // Make a mutable copy of the block id, because it's likely to change
        let mut working_block_id = builder_context.current_block_id.clone();
        // let mut working_block = cfg.blocks.get(&working_block_id).unwrap();
        match self {
            Statement::Block{stmts} => {
                // I'm not sure we have to actually create a new block, here. We may just
                // need to add all of the internal statements to the block (while checking, after
                // we add each one, to see if the block changed, like in the case of an If)
                for stmt in stmts {
                    match stmt.add_to_cffunc(&mut cf_func,&mut builder_context) {
                        Ok(result) => {
                            // The statement may have closed our old block and started a new one
                            working_block_id = builder_context.current_block_id.clone();
                            // If the statement returned, then we don't need to process any more statements
                            if result.return_equiv {
                                // Set the termination of this block to be Return
                                cf_func.blocks.get_mut(&working_block_id).unwrap().term = CFBlockTerminator::Return;
                                return Ok(CFGBlockResult{
                                    return_equiv:true,
                                })
                            }
                        },
                        Err(msg) => return Err(format!("Error when adding block to CFFunction: {}",msg))
                    }
                }
                // If we get here, we made it through all of the statements without encountering a
                // return (or return-equivalence)
                builder_context.current_block_id = working_block_id;
                Ok(CFGBlockResult{
                    return_equiv:false,
                })
            },
            Statement::Assignment{lvalue,expr} => {
                // evaluate expr
                // figure out where lvalue is (if it's a plain ID, then just assign to
                // a new virtual register and put that register's name in the symbol table
                // for that ID. Otherwise, generate LLVM code to find the pointer to the
                // memory location

                // First, get the _actual_ block to append to
                // We probably need to wrap this into a method within cfg or we should do this at the beginning of this function
                // since just about every variant is going to need to do it
                cf_func.append_stmt_to_block_id(self, &working_block_id);
                Ok(CFGBlockResult{
                    return_equiv:false,
                })
            },
            Statement::Print{expr, endl} => {
                // call printf
                cf_func.append_stmt_to_block_id(self, &working_block_id);
                Ok(CFGBlockResult{
                    return_equiv:false,
                })
            },
            Statement::Delete{expr} => {
                cf_func.append_stmt_to_block_id(self, &working_block_id);
                Ok(CFGBlockResult{
                    return_equiv:false,
                })
            },
            Statement::Call{id, args} => {
                cf_func.append_stmt_to_block_id(self, &working_block_id);
                Ok(CFGBlockResult{
                    return_equiv:false,
                })
            },
            Statement::Return{expr} => {
                // Add the return statement to the block
                cf_func.append_stmt_to_block_id(self, &working_block_id);
                // Mark the block as ending with a return
                cf_func.blocks.get_mut(&builder_context.current_block_id).unwrap().term =
                    CFBlockTerminator::Jump{label:builder_context.exit_block_id.clone()};
                // Return a result indicating our return-equiv
                Ok(CFGBlockResult{
                    return_equiv:true,
                })
            },
            Statement::While{guard, block} => {
                // 1 - Start three new blocks: guard, body, exit
                // 2 - Link the current block to 'guard'
                // 3 - put the guard expression into 'guard' and a branch
                //     if true to 'body' and if false to 'exit'
                // 4 - Put body statements into 'body' (by recursing here)
                // 5 - Set current_block_id's terminator to be a jump to 'guard' if body wasn't return-equiv
                // 6 - Set current_block_id to be 'exit'
                // 7 - Return result indicating our return-equivalence

                let guard_id = builder_context.create_new_block(cf_func);
                // println!("Created a While guard, with ID : {}",guard_id);
                // Set the end of the current block to be our new guard block
                cf_func.blocks.get_mut(&builder_context.current_block_id).unwrap().term = CFBlockTerminator::Jump{
                    label:guard_id.clone()
                };

                // Starter blocks for then and else clauses and the exit block
                let body_id = builder_context.create_new_block(cf_func);
                let exit_id = builder_context.create_new_block(cf_func);

                // Put the conditional jump for the guard
                cf_func.blocks.get_mut(&guard_id).unwrap().term = CFBlockTerminator::CondJump{
                    expr:guard.clone(),
                    true_label:body_id.clone(),
                    false_label:exit_id.clone(),
                };

                // BODY
                // Set the current_block_id to be the then block
                builder_context.current_block_id = body_id;
                // Populate the then clause with its statement(s)
                let body_result = block.add_to_cffunc(cf_func,builder_context)?;
                // Now that we're at the end of the body (which may have made more blocks and changed current_block_id)
                // if it wasn't return-equiv, then jump to exit

                cf_func.blocks.get_mut(&builder_context.current_block_id).unwrap().term = CFBlockTerminator::Jump{
                    label:guard_id.clone()
                };

                // If body was return-equv, then we don't even need an exit block
                // We should be able to remove it later
                builder_context.current_block_id = exit_id.clone();

                Ok(CFGBlockResult{
                    return_equiv:body_result.return_equiv
                })

            },
            Statement::If{guard, then_, else_} => {
                // 1 - Start four new blocks: guard, then_, else_, exit
                // 2 - link current block to 'guard'
                // 3 - put the guard expression into 'guard' and a branch
                //     if true to 'then_' and if false to 'else_'
                // 4 - Put then_ statement into 'then_' block (by recursing)
                // 5 - Link current_block_id's terminator as a jump to 'exit' if then block wasn't return-equiv
                // 6 - Put else_ statement into 'else_' block (by recursing)
                // 7 - Set current_block_id's terminator as a jump to 'exit' if else block wasn't return-equiv
                // 8 - Set current_block_id to be 'exit'
                // 9 - Return result indicating our return-equivalence

                let guard_id = builder_context.create_new_block(cf_func);
                // println!("Created a If guard, with ID : {}",guard_id);
                // Set the end of the current block to be our new guard block
                // TODO: we can probably get rid of the guard block and just put our conditional
                // jump at the end of current_block. But this will probably get cleaned up
                // if we do optimization which eliminates empty blocks
                cf_func.blocks.get_mut(&builder_context.current_block_id).unwrap().term = CFBlockTerminator::Jump{
                    label:guard_id.clone()
                };

                // Starter blocks for then and else clauses and the exit block
                let then_id = builder_context.create_new_block(cf_func);
                let else_id = builder_context.create_new_block(cf_func);
                let if_exit_id = builder_context.create_new_block(cf_func);

                // Put the conditional jump for the guard
                cf_func.blocks.get_mut(&guard_id).unwrap().term = CFBlockTerminator::CondJump{
                    expr:guard.clone(),
                    true_label:then_id.clone(),
                    false_label:else_id.clone(),
                };

                // THEN

                // Set the current_block_id to be the then block
                builder_context.current_block_id = then_id;
                // Populate the then clause with its statement(s)
                let then_result = then_.add_to_cffunc(cf_func,builder_context)?;
                // Now that we're at the end of the then (which may have made more blocks)
                // if it wasn't return-equiv, then jump to exit
                cf_func.blocks.get_mut(&builder_context.current_block_id).unwrap().term =
                    if then_result.return_equiv {
                        CFBlockTerminator::Jump{ label:builder_context.exit_block_id.clone() }
                    } else {
                        CFBlockTerminator::Jump{ label:if_exit_id.clone() }
                    };

                // ELSE

                // Set the current_block_id to be the then block
                builder_context.current_block_id = else_id;
                // Populate the then clause with its statement(s)
                let else_result = else_.add_to_cffunc(cf_func,builder_context)?;
                // Now that we're at the end of the else (which may have made more blocks)
                // if it wasn't return-equiv, then jump to exit
                cf_func.blocks.get_mut(&builder_context.current_block_id).unwrap().term =
                    if else_result.return_equiv {
                        CFBlockTerminator::Jump{ label:builder_context.exit_block_id.clone() }
                    } else {
                        CFBlockTerminator::Jump{ label:if_exit_id.clone() }
                    };

                // If both branches returned, then we don't even need an exit block
                // We should be able to remove it
                let return_equiv = then_result.return_equiv && else_result.return_equiv;
                // If we're return_equivalent, then both branches returned and we don't need an exit
                if return_equiv {
                    cf_func.blocks.remove(&if_exit_id);
                } else {
                    // Otherwise, set it as the current block
                    builder_context.current_block_id = if_exit_id.clone();
                }

                // Set the current_block_id to be our exit block


                // This block is return-equivalent only if both of the branches are
                Ok(CFGBlockResult{
                    return_equiv
                })
            },
        }
    }
}
