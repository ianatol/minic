use super::ast::*;
use super::lexer::Token;
use std::collections::HashMap;

//use super::trace::Trace;

#[derive(Clone)]
struct Context {
    //structs
    types:HashMap<String,HashMap<String,Datatype>>,
    // We only need to note the types of the parameters and the return type
    functions:HashMap<String,(Vec<Datatype>,Datatype)>,
    global_vars:HashMap<String,Datatype>,
    local_vars:HashMap<String,Datatype>,
}

impl Context {
    fn get_variable_type(&self, id:&str) -> Result<Datatype,String> {
        match self.local_vars.get(id).or(self.global_vars.get(id)) {
            Some(type_) => Ok(type_.clone()),
            None => Err(format!("Error: Couldn't find variable {} in local nor global symbol tables",id)),
        }
    }
}

impl AST {
    pub fn type_check(&self) -> Result<(),String> {
        // We need to hold all of our vars, structs, functions in a way that we can get to them
        let mut context = Context {
            types: HashMap::new(),
            functions: HashMap::new(),
            global_vars: HashMap::new(),
            local_vars: HashMap::new(),
        };
        // Manually provide for an external function
        context.functions.insert(
            "parmTest".to_string(),
            (vec![Datatype::Int, Datatype::Int, Datatype::Int, Datatype::Int, Datatype::Int, Datatype::Int, Datatype::Int, Datatype::Int, Datatype::Int], Datatype::Int)
        );
        //
        // First, build a hashmap of structs, making sure that nothing got declared twice
        // Go through the AST vector, inserting structs into 'types' hashmap, checking for duplicates
        println!("Checking structs...");
        for type_ in &self.types {
            if context.types.contains_key(&type_.id) {
                return Err(format!("Error: struct {} declared more than once",&type_.id));
            }
            // The context doesn't already have this struct, so let's add its fields (while checking
            // _those_ for duplicates)
            let mut struct_fields:HashMap<String,Datatype> = HashMap::new();
            for decl in &type_.decls {
                if struct_fields.contains_key(&decl.id) {
                    return Err(format!("Error: struct {} has duplicate field {}",type_.id,decl.id));
                }
                // We need to check each type to make sure that, if it's a struct, that that struct exists
                match &decl.datatype {
                    Datatype::Structure{id:refd_id} => {
                        // 
                        if ! context.types.contains_key(refd_id.as_str()) && ! refd_id.eq(&type_.id) {
                            return Err(format!("Error: struct {} has field {} which is of type struct {} which doesn't exist",type_.id,decl.id,refd_id));
                        }
                    },
                    _ => {}
                }
                struct_fields.insert(decl.id.clone(),decl.datatype.clone());
            }
            context.types.insert(type_.id.clone(),struct_fields);
        }
        //
        // Next, do the same for all of the variables
        println!("Checking global vars...");
        for var in &self.declarations {
            if context.global_vars.contains_key(&var.id) {
                return Err(format!("Error: Global var {} declared more than once",&var.id));
            }
            // If its type is a struct, make sure that the name of the struct exists in our types table
            match &var.datatype {
                Datatype::Structure{id} => {
                    if !context.types.contains_key(id) {
                        return Err(format!("Error: variable {} was of type 'struct {}', which wasn't declared",var.id,id));
                    }
                },
                _ => {}, // We don't need to verify any other type
            };
            //println!("inserting global variable {}",var.id);
            context.global_vars.insert(var.id.clone(),var.datatype.clone());
        }
        //
        // Next, do the same for all of the functions
        println!("Checking function declarations...");
        for func in &self.functions {
            if context.functions.contains_key(&func.id) {
                return Err(format!("Error: Function {} declared more than once",&func.id));
            }
            // Check the parameter types. **NOTE** We don't check for duplicate id's in the formal params,
            // here, because that will be done when we typecheck the function, itself (where we build the
            // local symbol table)
            for parm in &func.parms {
                // If its type is a struct, make sure that the name of the struct exists in our types table
                match &parm.datatype {
                    Datatype::Structure{id} => {
                        if ! context.types.contains_key(id) {
                            return Err(format!("Error: function {} had a parameter {} which was of undeclared type 'struct {}'",func.id,parm.id,&id));
                        }
                    },
                    _ => {}, // We don't need to verify any other type
                };
            }
            // Check the return type
            match &func.return_type {
                Datatype::Structure{id} => {
                    if ! context.types.contains_key(id) {
                        return Err(format!("Error: function {} had a return type which was of undeclared type 'struct {}'",func.id,id));
                    }
                },
                _ => {}, // We don't need to verify any other type
            };

            // Make a vector of _just_ the datatypes (strip out the id's)
            let parmtypes = func.parms.clone().into_iter().map(|p| p.datatype).collect();
            context.functions.insert(func.id.clone(),(parmtypes,func.return_type.clone()));
        }

        // Make sure that there's a main and that it's ()->int
        match context.functions.get("main") {
            Some(func) => {
                match (func.0.len(), &func.1) {
                    (0,Datatype::Int) => {}, // This is what we want
                    (_,Datatype::Int) => return Err(format!("Error: main function has arguments, expected none")),
                    (0, ret_type) => return Err(format!("Error: main function has return type {}, expected Int", ret_type)),
                    (_,_) => return Err(format!("Error: Program contains no function named \"main\"")),
                }
            },
            None => return Err(format!("Error: Program contains no function named \"main\"")), 
        };

        //
        // At this point, the execution context should be all prepped
        //
        // Start checking functions

        println!("Checking function bodies...");
        for func in &self.functions {
            match func.type_check(context.clone()) {
                Ok(_) => {},
                Err(msg) => return Err(format!("Error checking function {} : {}",func.id,msg))
            }
        }
        Ok(())
    }
}


impl Function {
    fn type_check(&self, mut context:Context) -> Result<(),String> {
        // Create a context (with the globals and the local vars)
        context.local_vars = HashMap::new();

        // Add the parameters to the local symbol table
        for parm in &self.parms {
            if context.local_vars.contains_key(&parm.id) {
                return Err(format!("Error: Parameters already contained an variable named {}",parm.id));
            };
            context.local_vars.insert(parm.id.clone(),parm.datatype.clone());
        }

        // Add local decls to the local symbol table
        for decl in &self.decls {
            if context.local_vars.contains_key(&decl.id) {
                return Err(format!("Error: Local symbol table already contained an variable named {}",decl.id));
            };
            context.local_vars.insert(decl.id.clone(),decl.datatype.clone());
        }

        for stmt in &self.stmts {
            match stmt.type_check(&context,&self.return_type) {
                Ok(return_equiv) => {
                    // println!("Checking statement {} typechecked and return-equiv={}",stmt,return_equiv);
                    if return_equiv {
                        return Ok(());
                    }
                },
                Err(msg) => return Err(format!("In function {}, checking statement:\n   {}\nfailed because:\n  {}",self.id,stmt,msg)),
            }
        }
        // If we get all the way here, then we never encountered a return-equivalent statement
        // So, if we have a non-void return type, that's a problem.
        if self.return_type != Datatype::Void {
            Err(format!("Error: non-void function {} doesn't always return a value",self.id))
        } else {
            Ok(())
        }
    }
}

impl Lvalue {
    fn get_type(&self, context:&Context) -> Result<Datatype,String> {
        match self {
            Lvalue::Base{id} => {
                // Basic ids, we just look them up in the context
                context.get_variable_type(id)
            },
            Lvalue::Dotted{lvalue,id:rec_id} => {
                // With dotted ones, we need to get the type of the part to the left
                // of the dot, make sure it's a struct, and then make sure that struct
                // has a record with id
                match lvalue.get_type(context) {
                    Ok(type_) => {
                        match type_ {
                            Datatype::Structure{id:struct_id} => {
                                // It's a struct. Now, see if that struct exists in the context (probably assured, since
                                // we're probably checking this whenever we declare a var or function)
                                match context.types.get(&struct_id) {
                                    Some(struct_) => {
                                        // So, we now have a HashMap<String,Datatype> of the records within the struct
                                        // Make sure that the rec_id is in there
                                        match struct_.get(rec_id) {
                                            Some(rec_type) => Ok(rec_type.clone()),
                                            None => Err(format!("Error: struct {} doesn't have a record named {}",struct_id,rec_id))
                                        }
                                    },
                                    None => {
                                        // Somehow, we were given a structure id which was never declared
                                        Err(format!("Error: Dotted Lvalue {} involved a struct name, {}, which was never declared",self,struct_id))
                                    },
                                }
                            },
                            // If the type isn't a struct, we can't reference a record in it
                            _ => Err(format!("Error: {} is not a structure, so it can't have a record '{}'",lvalue,rec_id))
                        }
                    }
                    Err(msg) => Err(format!("Error resolving the type to the left of the dot in {}",self))
                }
            }
        }
    }
}

// Add a get_type method to Expression
// Given all of the context, it will return the Datatype variant or an Err
impl Expression {
    fn get_type(&self, context:&Context) -> Result<Datatype,String> {
        match self {
            // First, get all of the literals out of the way
            Expression::True => Ok(Datatype::Bool),
            Expression::False => Ok(Datatype::Bool),
            Expression::VoidExp => Ok(Datatype::Void),
            Expression::Null => Ok(Datatype::Null),//Err(format!("We were asked to get the type of a null")),
            Expression::Int(val) => Ok(Datatype::Int),
            Expression::Read => Ok(Datatype::Int), // Read only returns ints
            // Variables get looked up in the symbol table
            Expression::Var{id} => context.get_variable_type(&id),
            // Unary operators depend upon what type they're operating on
            Expression::Unary{oper,expr} => {
                match oper {
                    Token::BANG => {
                        // Expect a Bool and return a Bool
                        match expr.get_type(context) {
                            Ok(Datatype::Bool) => Ok(Datatype::Bool),
                            Ok(tok) => Err(format!("There was a boolean NOT operating on a type {}",tok)),
                            Err(msg) => Err(format!("Operand failed to type-check with error: {}",msg)),
                        }
                    },
                    Token::MINUS => {
                        // Expect an Int and return an Int
                        match expr.get_type(context) {
                            Ok(Datatype::Int) => Ok(Datatype::Int),
                            Ok(tok) => Err(format!("There was arithmetic negation operating on a type {}",tok)),
                            Err(msg) => Err(format!("Operand failed to type-check with error: {}",msg)),
                        }
                    },
                    tok => return Err(format!("{} isn't a unary operator",tok)),
                }
            },
            // Binary operators depend upon two operator types. First, we have to figure out what operator it is
            // before we decide what types we need the expr's to be.
            Expression::Binary{oper,left,right} => {
                match oper {
                    // (bool,bool) -> bool
                    Token::AND | Token::OR => {
                        match (left.get_type(context), right.get_type(context)) {
                            (Ok(Datatype::Bool),Ok(Datatype::Bool)) => Ok(Datatype::Bool),
                            (Ok(tokl),Ok(tokr)) => Err(format!("We wanted two booleans to operate on, and we got {} and {}",tokl, tokr)),
                            (Err(msg),_) => Err(format!("Left operand failed to type-check with error: {}",msg)),
                            (_,Err(msg)) => Err(format!("Right operand failed to type-check with error: {}",msg)),
                        }       
                    },
                    // (int,int)|(struct,struct) -> bool
                    Token::EQ | Token::NE => {
                        match (left.get_type(context), right.get_type(context)) {
                            (Ok(Datatype::Int),Ok(Datatype::Int)) => Ok(Datatype::Bool),
                            (Ok(Datatype::Structure{id:left}),Ok(Datatype::Null)) => Ok(Datatype::Bool),
                            (Ok(Datatype::Null),Ok(Datatype::Structure{id:right})) => Ok(Datatype::Bool),
                            (Ok(Datatype::Null),Ok(Datatype::Null)) => Ok(Datatype::Bool),
                            (Ok(Datatype::Structure{id:left}),Ok(Datatype::Structure{id:right})) => {
                                if left.eq(&right) {
                                    Ok(Datatype::Bool)
                                } else {
                                    Err(format!("Expression {} tried to compare struct {} with struct {}",self,left,right))
                                }
                            },
                            (Ok(tokl),Ok(tokr)) => Err(format!("We wanted two ints to operate on, and we got {} and {}",tokl, tokr)),
                            (Err(msg),_) => Err(format!("Left operand failed to type-check with error: {}",msg)),
                            (_,Err(msg)) => Err(format!("Right operand failed to type-check with error: {}",msg)),
                        }       
                    },
                    // (int,int) -> bool
                    Token::LT | Token::GT | Token::LE | Token::GE => {
                        match (left.get_type(context), right.get_type(context)) {
                            (Ok(Datatype::Int),Ok(Datatype::Int)) => Ok(Datatype::Bool),
                            (Ok(tokl),Ok(tokr)) => Err(format!("We wanted two ints to operate on, and we got {} and {}",tokl, tokr)),
                            (Err(msg),_) => Err(format!("Left operand failed to type-check with error: {}",msg)),
                            (_,Err(msg)) => Err(format!("Right operand failed to type-check with error: {}",msg)),
                        }       
                    },
                    // (int,int) -> int
                    Token::PLUS | Token::MINUS | Token::STAR | Token::SLASH => {
                        match (left.get_type(context), right.get_type(context)) {
                            (Ok(Datatype::Int),Ok(Datatype::Int)) => Ok(Datatype::Int),
                            (Ok(tokl),Ok(tokr)) => Err(format!("We wanted two ints to operate on, and we got {} and {}",tokl, tokr)),
                            (Err(msg),_) => Err(format!("Left operand failed to type-check with error: {}",msg)),
                            (_,Err(msg)) => Err(format!("Right operand failed to type-check with error: {}",msg)),
                        }       
                    },
                    tok => return Err(format!("{} isn't a binary operator",tok)),
                    
                }
            },
            //Expr needs to be of type struct, id needs to be a field in that struct
            //Struct -> T
            Expression::Dot{expr,id} => {
                match expr.get_type(context) {
                    Ok(Datatype::Structure{id:struct_id}) => {
                        //We have a struct, now check that dot's id is a field in the struct
                        //First, lookup struct in types table
                        match context.types.get(&struct_id) {
                            //If we find it, check that the right operand is a field in it
                            Some(struct_) => {
                                match struct_.get(id) {
                                    //If it is, give back that field's type
                                    Some(t) => Ok(t.clone()),
                                    None => Err(format!("Error: Left operand struct {} did not contain field {}", struct_id, id))
                                }},
                            None => Err(format!("Error: Struct table did not contain struct {}", struct_id))
                        }
                    },
                    Ok(t) => Err(format!("Error: Left operand of dot expression expected Struct, evaluated to {}", t)),
                    Err(msg) => Err(format!("Error: Left operand of dot expression failed to type-check with error: {}", msg))
                }
            },
            //Id needs to be looked up to be in function table, args need to be type checked to match function's input types
            Expression::Inv{id,args} => {
                match context.functions.get(id) {
                    Some((func_args, func_output)) => {
                        //Type check each arg and make a list of their types
                        let mut arg_types = Vec::new();
                        for arg in args {
                            match arg.get_type(context) {
                                Ok(t) => arg_types.push(t),
                                Err(msg) => return Err(format!("Error while typechecking args of function {}. Error: {}", id, msg))
                            }
                        }
                        if arg_types == (func_args.clone()) {
                            Ok(func_output.clone())
                        }
                        else {
                            Err(format!("Arguments given to function call {} did not match declared function parameter types", id))
                        }
                        //This type list must == function's input type list
                    },
                    None => Err(format!("Function with name {} was called, but never declared", id))
                }
            },
            // New: Lookup id in struct table and return that type
            Expression::New{id} => {
                match context.types.get(id) {
                    Some(struct_) => Ok(Datatype::Structure{id:(id.clone())}),
                    None => Err(format!("Error: New called on id: {}, but that id was not found in struct table.", id))
                }
            }
        }
    }
}

// Add a type_check method to Statement
// Given a context (datatypes, variable tables, functions), it will return whether the statement: 1) typechecks, 2) is return-equiv
impl Statement {
    // Returns Result<is-return-equiv, String>
    fn type_check(&self, context:&Context, expected_return:&Datatype) -> Result<bool,String> {
        match self {
            // Block: All statements must typecheck until we encounter something which returns
            Statement::Block{stmts} => {
                for stmt in stmts {
                    match stmt.type_check(context, &expected_return) {
                        Ok(return_equiv) => {
                            if return_equiv {
                                return Ok(true); // This statement returns, so we can finish
                            }

                        },
                        Err(msg) => return Err(format!("Error typechecking a block: {}",msg))
                    };
                }
                Ok(false) // Everything type-checked, but we didn't encounter a return
            },
            Statement::Assignment{lvalue,expr} => {
                let left_result = lvalue.get_type(context);
                let right_result = expr.get_type(context);
                //If right is null, left needs to be struct 
                match (left_result, right_result) {
                    (Ok(Datatype::Int),Ok(Datatype::Int)) => Ok(false),
                    (Ok(Datatype::Bool),Ok(Datatype::Bool)) => Ok(false),
                    (Ok(Datatype::Structure{id:left}),Ok(Datatype::Null)) => Ok(false),
                    (Ok(Datatype::Structure{id:left}),Ok(Datatype::Structure{id:right})) => 
                        if left.eq(&right) { Ok(false) } else { Err(format!("Cannot assign a struct {} to a struct {}",right,left))},
                    // (Ok(Datatype::Structure{id}),Ok(Datatype::Void)) => Ok(false),
                    (Ok(left),Ok(right)) => Err(format!("Cannot assign a {} to a {}",right,left)),
                    (Err(msg),_) => Err(format!("Error evaluating lvalue in an assignment: {}",msg)),
                    (_,Err(msg)) => Err(format!("Error evaluating rvalue in an assignment: {}",msg)),
                }
            }
            // Print: make sure that the expr resolves to an Int
            Statement::Print{expr, endl} => {
                match expr.get_type(context) {
                    Ok(Datatype::Int) => Ok(false),
                    Ok(tok) => Err(format!("Print expects an Int expression, and we got a {}",tok)),
                    Err(msg) => Err(format!("Error evaluating the expression of a print: {}",msg)),
                }
            },
            // If: make sure that guard is boolean. Make sure then/else blocks both typecheck. If both
            // are return-equivalent, then so is this.
            Statement::If{guard, then_, else_} => {
                match guard.get_type(context) {
                    Ok(Datatype::Bool) => {
                        // Type check both blocks
                        let then_result = then_.type_check(context, &expected_return);
                        let else_result = else_.type_check(context, &expected_return);
                        match (then_result,else_result) {
                            (Ok(then_returns),Ok(else_returns)) => Ok(then_returns && else_returns),
                            (Err(msg),_) => Err(format!("Then clause failed to typecheck : {}",msg)),
                            (_,Err(msg)) => Err(format!("Else clause failed to typecheck : {}",msg)),
                        }
                    },
                    Ok(tok) => Err(format!("If expected a boolean guard, and we got a {}",tok)),
                    Err(msg) => Err(format!("Error evaluating the guard of an If: {}",msg)),
                }
            },
            Statement::While{guard, block} => {
                match guard.get_type(context) {
                    // If the guard evaluates to a bool, then just recurse to typecheck the block
                    Ok(Datatype::Bool) => block.type_check(context, &expected_return),
                    Ok(tok) => Err(format!("Error: While expression expected a boolean guard, and we got a {}",tok)),
                    Err(msg) => Err(format!("Error evaluating the guard of a while: {}",msg)),
                }
            },
            // Delete: Make sure that the expression is a struct
            Statement::Delete{expr} => {
                match expr.get_type(context) {
                    Ok(Datatype::Structure{id}) => Ok(false),
                    Ok(t) => Err(format!("Error: Delete expression expected struct type, got {}", t)),
                    Err(msg) => Err(format!("Error found while typechecking Delete statement operand: {}", msg))
                 }
            },
            // Return: Make sure that the returned type matches the expected_return (the type of the function we're in)
            Statement::Return{expr} => {
                // println!("The expression within the return is {}",expr);
                match expr.get_type(context) {
                    Ok(return_type) => {
                        // println!("The expression evaluated to {}",return_type);
                        if return_type == *expected_return {
                            Ok(true)
                        } else {
                            Err(format!("Return statement returned {} in a function that returns {}",return_type,&expected_return))
                        }
                    },
                    Err(msg) => Err(format!("Error evaluating expression of a return statement: {}",msg)),
                }
            },
            // Function call. Make sure arg exprs' types match the types of the formal parameters
            Statement::Call{id, args} => {
                match context.functions.get(id) {
                    Some((func_args, func_output)) => {
                        //Type check each arg and make a list of their types
                        let mut arg_types = Vec::new();
                        for arg in args {
                            match arg.get_type(context) {
                                Ok(t) => arg_types.push(t),
                                Err(msg) => return Err(format!("Error while typechecking args of function {}. Error: {}", id, msg))
                            }
                        }
                        if arg_types == (func_args.clone()) {
                            return Ok(false)
                        }
                        else {
                            return Err(format!("Arguments given to function call {} did not match declared function parameter types", id))
                        }
                        //This type list must == function's input type list
                    },
                    None => return Err(format!("Function with name {} was called, but never declared", id))
                }
            },
        }
    }
}

#[test]
fn run_all_tests(){
    test_struct_redecl();
    test_struct_inner_redecl();
    test_good_struct_ref();
    test_bad_struct_ref();
    test_self_struct_ref();
    test_func_redecl();
    test_undecl_struct();
    test_global_redecl();
    test_param_redecl();
    test_main_type();
    test_variable_shadowing();
    test_print_typechecking();
    test_relational_operators();
}

 #[test]
 fn test_struct_redecl() {
    // Redeclaration of structs
    let tokens = super::lexer::tokenize_string("struct A { int a; }; struct A { int a; }; fun main() int {}").unwrap();
    let (remain,ast) = super::parser::parse_program(&tokens).unwrap();
    assert_eq!(remain.len(),0);
    assert_eq!(ast.type_check(),Err(format!("Error: struct A declared more than once")));
 }

 #[test]
 fn test_struct_inner_redecl() {
    // Redeclaration _within_ structs
    let tokens = super::lexer::tokenize_string("struct A { int a; int a; }; fun main() int {}").unwrap();
    let (remain,ast) = super::parser::parse_program(&tokens).unwrap();
    assert_eq!(remain.len(),0);
    assert_eq!(ast.type_check(),Err(format!("Error: struct A has duplicate field a")));
 }

 #[test]
 fn test_good_struct_ref() {
    // Referencing other structs good
    let tokens = super::lexer::tokenize_string("struct A { int a; }; struct B { struct A a; }; fun main() int { return 0; }").unwrap();
    let (remain,ast) = super::parser::parse_program(&tokens).unwrap();
    assert_eq!(remain.len(),0);
    assert_eq!(ast.type_check(),Ok(()));
 }

 #[test]
 fn test_bad_struct_ref() {
    // Referencing other structs bad
    let tokens = super::lexer::tokenize_string("struct A { int a; }; struct B { struct C a; }; fun main() int {return 0; }").unwrap();
    let (remain,ast) = super::parser::parse_program(&tokens).unwrap();
    assert_eq!(remain.len(),0);
    assert_eq!(ast.type_check(),Err(format!("Error: struct B has field a which is of type struct C which doesn\'t exist")));
 }

 #[test]
 fn test_self_struct_ref() {
    // Referencing self struct good
    let tokens = super::lexer::tokenize_string("struct A { int a; struct A b; }; fun main() int { return 0; }").unwrap();
    let (remain,ast) = super::parser::parse_program(&tokens).unwrap();
    assert_eq!(remain.len(),0);
    assert_eq!(ast.type_check(),Ok(()));
 }

 #[test]
 fn test_func_redecl() {
    // Redeclaration of funcs
    let tokens = super::lexer::tokenize_string("fun main() int {} fun main() int { return 0; }").unwrap();
    let (remain,ast) = super::parser::parse_program(&tokens).unwrap();
    assert_eq!(remain.len(),0);
    assert_eq!(ast.type_check(),Err(format!("Error: Function main declared more than once")));
 }
    // Use of undeclared struct
    // This fails because the parser thinks this is a struct declaration
    // let tokens = super::lexer::tokenize_string("struct A a;").unwrap();
    // let (remain,ast) = super::parser::parse_program(&tokens).unwrap();
    // assert_eq!(remain.len(),0);
    // assert_eq!(ast.type_check(),Err(format!("Error: Global var a declared more than once")));

#[test]
fn test_undecl_struct() {
    // Use of undeclared struct
    let tokens = super::lexer::tokenize_string("int b; struct A a; fun main() int {}").unwrap();
    let (remain,ast) = super::parser::parse_program(&tokens).unwrap();
    assert_eq!(remain.len(),0);
    assert_eq!(ast.type_check(),Err(format!("Error: variable a was of type 'struct A', which wasn't declared")));
}

#[test]
fn test_global_redecl() {
    // Redeclaration of global vars
    let tokens = super::lexer::tokenize_string("int a; int a; fun main() void { return 0; }").unwrap();
    let (remain,ast) = super::parser::parse_program(&tokens).unwrap();
    assert_eq!(remain.len(),0);
    assert_eq!(ast.type_check(),Err(format!("Error: Global var a declared more than once")));
}

#[test]
fn test_param_redecl() {
    // Redeclaration of global vars
    let tokens = super::lexer::tokenize_string("fun test(int a, bool a) void {} fun main() int {}").unwrap();
    let (remain,ast) = super::parser::parse_program(&tokens).unwrap();
    assert_eq!(remain.len(),0);
    assert_eq!(ast.type_check(),Err(format!("Error checking function test : Error: Parameters already contained an variable named a")));
}

#[test]
fn test_main_type() {
    // Main needs to be present, take zero params, and return int
    let tokens = super::lexer::tokenize_string("fun main() int { return 0; }").unwrap();
    let (remain,ast) = super::parser::parse_program(&tokens).unwrap();
    assert_eq!(remain.len(),0);
    assert_eq!(ast.type_check(),Ok(()));

    // Main must be of type int
    let tokens = super::lexer::tokenize_string("fun main() void {}").unwrap();
    let (remain,ast) = super::parser::parse_program(&tokens).unwrap();
    assert_eq!(remain.len(),0);
    assert_eq!(ast.type_check(),Err(format!("Error: main function has return type Void, expected Int")));
 
    // Main can't take any parameters
    let tokens = super::lexer::tokenize_string("fun main(int a) int { return 0; }").unwrap();
    let (remain,ast) = super::parser::parse_program(&tokens).unwrap();
    assert_eq!(remain.len(),0);
    assert_eq!(ast.type_check(),Err(format!("Error: main function has arguments, expected none")));
 }


#[test]
fn test_variable_shadowing() {
    // No shadowing. This should fail.
    let tokens = super::lexer::tokenize_string("int a; fun main() int { bool b; b=a; }").unwrap();
    let (remain,ast) = super::parser::parse_program(&tokens).unwrap();
    assert_eq!(remain.len(),0);
    assert_eq!(ast.type_check(),Err(format!("Error checking function main : In function main, checking statement:\n   Assignment b=Expression::Var(a)\nfailed because:\n  Cannot assign a Int to a Bool")));

    // a should be treated as bool and things should check ok
    let tokens = super::lexer::tokenize_string("int a; fun main() int { return 0; } fun test(bool a) int { bool b; b=a; return 0; }").unwrap();
    let (remain,ast) = super::parser::parse_program(&tokens).unwrap();
    assert_eq!(remain.len(),0);
    assert_eq!(ast.type_check(),Ok(()));
}

#[test]
fn test_typecheck_return_types() {
    // 
    let tokens = super::lexer::tokenize_string("struct A { int a; }; fun main() int { return 0; } fun b() bool { return true; } fun c() struct A { struct A c; return c; } fun d() void { return; }").unwrap();
    let (remain,ast) = super::parser::parse_program(&tokens).unwrap();
    assert_eq!(remain.len(),0);
    assert_eq!(ast.type_check(),Ok(()));
}

#[test]
fn test_print_typechecking() {
    // 
    let tokens = super::lexer::tokenize_string("int a; fun main() int { print 0; return 0; }").unwrap();
    let (remain,ast) = super::parser::parse_program(&tokens).unwrap();
    assert_eq!(remain.len(),0);
    assert_eq!(ast.type_check(),Ok(()));

    // a should be treated as bool and things should check ok
    let tokens = super::lexer::tokenize_string("int a; fun main() int { print true; return 0; }").unwrap();
    let (remain,ast) = super::parser::parse_program(&tokens).unwrap();
    assert_eq!(remain.len(),0);
    assert_eq!(ast.type_check().unwrap_err().split(':').last().unwrap(),"\n  Print expects an Int expression, and we got a Bool");
}

#[test]
fn test_relational_operators() {
    // relating two ints should work
    let tokens = super::lexer::tokenize_string("fun main() int { int a; int b; if (a>b) {} return 0; }").unwrap();
    let (remain,ast) = super::parser::parse_program(&tokens).unwrap();
    assert_eq!(remain.len(),0);
    assert_eq!(ast.type_check(),Ok(()));

    // relating int with int literal should work
    let tokens = super::lexer::tokenize_string("fun main() int { int a; if (a>3) {} return 0; }").unwrap();
    let (remain,ast) = super::parser::parse_program(&tokens).unwrap();
    assert_eq!(remain.len(),0);
    assert_eq!(ast.type_check(),Ok(()));

    // relating int with bool should fail
    let tokens = super::lexer::tokenize_string("fun main() int { int a; bool b; if (a>b) {} return 0; }").unwrap();
    let (remain,ast) = super::parser::parse_program(&tokens).unwrap();
    assert_eq!(remain.len(),0);
    assert!(ast.type_check().unwrap_err().ends_with("We wanted two ints to operate on, and we got Int and Bool"));

    // relating int with struct should fail
    let tokens = super::lexer::tokenize_string("struct A { int a; }; fun main() int { struct A a; bool b; if (a<b) {} return 0; }").unwrap();
    let (remain,ast) = super::parser::parse_program(&tokens).unwrap();
    assert_eq!(remain.len(),0);
    assert_eq!(ast.type_check().unwrap_err().split(':').last().unwrap()," We wanted two ints to operate on, and we got Struct A and Bool");

    // Checking all four relationals
    let tokens = super::lexer::tokenize_string("fun main() int { int a; int b; if (a>b && a<b || a<=b || a>=b) {} return 0; }").unwrap();
    let (remain,ast) = super::parser::parse_program(&tokens).unwrap();
    assert_eq!(remain.len(),0);
    assert_eq!(ast.type_check(),Ok(()));

}

#[test]
fn test_boolean_operators() {
    // 
    let tokens = super::lexer::tokenize_string("fun main() int { bool a; bool b; if (a && b) {} return 0; }").unwrap();
    let (remain,ast) = super::parser::parse_program(&tokens).unwrap();
    assert_eq!(remain.len(),0);
    assert_eq!(ast.type_check(),Ok(()));

    // 
    let tokens = super::lexer::tokenize_string("fun main() int { bool a; bool b; if (a || b) {} return 0; }").unwrap();
    let (remain,ast) = super::parser::parse_program(&tokens).unwrap();
    assert_eq!(remain.len(),0);
    assert_eq!(ast.type_check(),Ok(()));
    
    // 
    let tokens = super::lexer::tokenize_string("fun main() int { int a; bool b; if (a || b) {} return 0; }").unwrap();
    let (remain,ast) = super::parser::parse_program(&tokens).unwrap();
    assert_eq!(remain.len(),0);
    assert_eq!(ast.type_check().unwrap_err().split(':').last().unwrap()," We wanted two booleans to operate on, and we got Int and Bool");

    // 
    let tokens = super::lexer::tokenize_string("struct A { int a; }; fun main() int { struct A a; bool b; if (a || b) {} return 0; }").unwrap();
    let (remain,ast) = super::parser::parse_program(&tokens).unwrap();
    assert_eq!(remain.len(),0);
    assert_eq!(ast.type_check().unwrap_err().split(':').last().unwrap()," We wanted two booleans to operate on, and we got Struct A and Bool");

    // // 
    // let tokens = super::lexer::tokenize_string("fun main() int { bool a; bool b; a = a && b || b; return 0; }").unwrap();
    // let (remain,ast) = super::parser::parse_program(&tokens).unwrap();
    // assert_eq!(remain.len(),0);
    // assert_eq!(ast.type_check().unwrap_err().split(':').last().unwrap()," We wanted two ints to operate on, and we got Struct A and Bool");
}

#[test]
fn test_atrith_operators() {
    // 
    let tokens = super::lexer::tokenize_string("fun main() int { int a; int b; a = a + b; return 0; }").unwrap();
    let (remain,ast) = super::parser::parse_program(&tokens).unwrap();
    assert_eq!(remain.len(),0);
    assert_eq!(ast.type_check(),Ok(()));

    // 
    let tokens = super::lexer::tokenize_string("fun main() int { int a; bool b; a = a + b; return 0; }").unwrap();
    let (remain,ast) = super::parser::parse_program(&tokens).unwrap();
    assert_eq!(remain.len(),0);
    assert_eq!(ast.type_check().unwrap_err().split(':').last().unwrap()," We wanted two ints to operate on, and we got Int and Bool");
    
    // 
    let tokens = super::lexer::tokenize_string("struct A { int a; }; fun main() int { int a; struct A b; a = a + b; return 0; }").unwrap();
    let (remain,ast) = super::parser::parse_program(&tokens).unwrap();
    assert_eq!(remain.len(),0);
    assert_eq!(ast.type_check().unwrap_err().split(':').last().unwrap()," We wanted two ints to operate on, and we got Int and Struct A");
}

#[test]
fn test_struct_fields() {
    // 
    let tokens = super::lexer::tokenize_string("struct A { int a; }; fun main() int { struct A a; int b; b = a.a; return 0; }").unwrap();
    let (remain,ast) = super::parser::parse_program(&tokens).unwrap();
    assert_eq!(remain.len(),0);
    assert_eq!(ast.type_check(),Ok(()));

}
