use super::ast::*;
use std::collections::HashMap;

fn get_parm_types(parms: Vec<Decl>) -> Vec<Datatype> {
    //this could be done with a lambda function, but too lazy
    let types = Vec::new();
    for parm in parms {
        types.push(parm.datatype);
    }
    types
}

fn type_check_stmts(stmts: Vec<Statement>, symb_table: Vec<HashMap<String, Datatype>>, struct_table: &HashMap<String, Vec<Decl>>, return_type: Datatype) -> bool {
    for stmt in stmts {
        if !type_check_stmt(stmt, symb_table, struct_table, return_type) {
            return false;
        }
    }
    return true;
}

fn type_check_stmt(stmt: Statement, symb_table: Vec<HashMap<String, Datatype>>, struct_table: &HashMap<String, Vec<Decl>>, return_type: Datatype) -> bool{
    match stmt {
        Statement::Block{stmts} => type_check_stmts(stmts, symb_table, &struct_table, return_type),
        Statement::Assignment{lvalue, expr} => {} , //not sure what to do with LValue
        Statement::Print{expr, endl} => check_print_stmt(expr, symb_table, &struct_table, return_type),
        Statement::If{guard, then_, else_} => (if type_of(guard, symb_table, struct_table) == Datatype::Bool { //else error
                                                                                        type_check_stmts(vec![*then_, *else_], symb_table, &struct_table, return_type)
                                                                                    }),
        Statement::While{guard, block} => if type_of(guard, symb_table, struct_table) == Datatype::Bool { //else error
                                                                    type_check_stmt(*block, symb_table, struct_table, return_type)
                                                                },
        Statement::Delete{expr} => (match type_of(expr, symb_table, struct_table) {
                                        Datatype::Structure{id} => true,
                                        _ => false
                                    }),
        Statement::Return{expr} => (type_of(expr, symb_table, struct_table) == return_type),
        Statement::Call{id, args} => (match id_lookup(id, symb_table) {
                                     None => Err(format!("Function call attempted on unknown id: {}", id)),
                                     Some(Datatype::Func{inp, outp}) => {}//type check each arg and store their types. then compare to function input
                                    })
    }
    //match on stmt
    //block -> check each stmt inside
    //assignment -> type_of(lhs) == type_of(rhs)
    //print -> type check expr
    //if -> guard is bool, type_of(then) == type_of(else)
    //while -> guard is bool, check body
    //delete -> expr is struct
    //return -> expr matches return type of function
    //call -> id is a function, args match function input
}

fn local_symb_table_insert(symb_table: Vec<HashMap<String, Datatype>>, id: String, t: Datatype) {
    let local_table = symb_table[symb_table.len() - 1];
    if local_table.contains_key(&id) {
        Err(format!("Error - Redeclaration of {}", id));
    }
    else {
        local_table.insert(id, t);
    }
}

//type check stmt (statements themselves do not have a type)


//type of expr
//true/false -> bool
//void -> void
//int -> int
//var -> check symbol table
//unary -> !x => bool, -x => int
//binary -> arithmetic => int, logical => bool
//new -> struct (if id is in struct table)
//dot -> if expr is a struct, id is a field, then type is field type
//inv -> if id a func, args match func input, then type is func output type

fn type_check_func(func: Function, symb_table: Vec<HashMap<String, Datatype>>, struct_table: &HashMap<String, Vec<Decl>>) -> bool {
    //Function: parms, return type, decls, stmts,
    let mut valid = true;
    let local_symb_table = HashMap::new();
    symb_table.push(local_symb_table);
    for parm in func.parms {
        local_symb_table_insert(symb_table, parm.id, parm.datatype);
    }
    //load decls into local symb table
    //decl logic goes here



    //type check stmts using symb table, struct table, and make sure any return matches return type
    for stmt in func.stmts {
        if !type_check_stmt(stmt, symb_table, struct_table, func.return_type) {
            valid = false;
        }
    }
    valid
}

fn create_symb_table(decls: &Vec<Decl>, funcs: &Vec<Function>) -> Vec<HashMap<String, Datatype>> {
    let mut symb_table = vec![HashMap::new()];
    for decl in decls {
        local_symb_table_insert(symb_table, decl.id, decl.datatype);
    }
    for func in funcs {
        local_symb_table_insert(symb_table, func.id, Datatype::Func{input: get_parm_types(func.parms), output:Box::new(func.return_type)});
    }
    symb_table
}

fn create_struct_table(types: Vec<TypeDeclaration>) -> HashMap<String, Vec<Decl>> {
    let mut struct_table = HashMap::new();
    for structure in &types {
        struct_table.insert(structure.id, structure.decls);
    }
    struct_table
}

fn type_check_funcs(funcs: Vec<Function>, decls: Vec<Decl>, types: Vec<TypeDeclaration>) -> bool{
    let struct_table = create_struct_table(types);
    let symb_table = create_symb_table(&decls, &funcs);
    let mut valid = true;
    for func in funcs {
        if !type_check_func(func, symb_table.clone(), &struct_table) {
            valid = false;
        }
    }
    valid 
}

pub fn type_checks(program: AST) -> bool {
    type_check_funcs(program.functions, program.declarations, program.types)
}