pub mod expression;
pub mod statement;

use crate::lexer::{Token,tokenize_file};
use crate::ast::AST;
use statement::{consume_functions,consume_types,consume_decls};

pub fn parse_file(filename:&str) -> Result<AST,String> {
    match tokenize_file(filename) {
        Ok(tokens) => {
           parse_tokens(&tokens) 
        },
        Err(msg) => Err(format!("Problem when tokenizing file : {}",msg))
    }
}

pub fn parse_tokens(tokens:&[Token]) -> Result<AST,String> {
    println!("Reading type declarations (structs)");
    let (rest, types) = consume_types(tokens).ok().expect("Error scanning for type definitions");
    println!("Reading variable declarations");
    let (rest, decls) = consume_decls(rest);
    println!("Reading functions");
    let (rest, funcs) = consume_functions(rest);
    println!("Functions found : {}", funcs.len());
    if rest.len() > 0 {
        Err(format!("Error when parsing. There were tokens left over : {:?}",rest))
    } else {
        Ok(AST{types, declarations:decls, functions:funcs})
    }
}


#[test]
fn test_parser_structs() {
    // Plain struct
    let tokens = super::lexer::tokenize_string("struct A { int a; };").unwrap();
    let (remain,ast) = parse_program(&tokens).unwrap();
    assert_eq!(remain.len(),0);
    assert_eq!(format!("{:?}",ast),"AST { types: [TypeDeclaration { id: \"A\", decls: [Decl { id: \"a\", datatype: Int }] }], declarations: [], functions: [] }");

    // Empty struct - Error
    let tokens = super::lexer::tokenize_string("struct A { };").unwrap();
    let (remain,ast) = parse_program(&tokens).unwrap();
    assert_eq!(remain.len(),0);
    assert_eq!(format!("{:?}",ast),"Missing declarations in struct A: \"No type declarations found in struct\"");

    // Struct use without any declaration
    let tokens = super::lexer::tokenize_string("struct A a;").unwrap();
    let (remain,ast) = parse_program(&tokens).unwrap();
    assert_eq!(remain.len(),0);
    assert_eq!(format!("{:?}",ast),"AST { types: [], declarations: [Decl { id: \"a\", datatype: Structure { id: \"A\" } }], functions: [] }");

}

#[test]
fn test_parser_expressions() {
    let tokens = super::lexer::tokenize_string("fun main() int { int a; int b; if (a>b && a<b || a<=b || a>=b) {} return 0; }").unwrap();
    let (remain,ast) = parse_program(&tokens).unwrap();
    assert_eq!(remain.len(),0);
    assert_eq!(ast.type_check(),Ok(()));

   // // 
    let tokens = super::lexer::tokenize_string("fun main() int { bool a; bool b; a = a && b || b; return 0; }").unwrap();
    let (remain,ast) = parse_program(&tokens).unwrap();
    assert_eq!(remain.len(),0);
    assert_eq!(ast.type_check(),Ok(()));

}

#[test]
fn test_parse_return_types() {
    // 
   let tokens = super::lexer::tokenize_string("struct A { int a; }; fun main() int { return 0; } fun b() bool { return true; } fun c() struct A { struct A c; return c; } fun d() void { return; }").unwrap();
   let (remain,ast) = parse_program(&tokens).unwrap();
   assert_eq!(remain.len(),0);
   assert_eq!(ast.type_check(),Ok(()));
}