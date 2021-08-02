// Actually, this is everything except expressions (which can't use left-recursive descent)

use crate::ast::*;

use crate::lexer::Token;
use crate::lexer::print_tokenvec;

use crate::trace::Trace;

use log::{info,warn};
use crate::parser::expression::{expect_expression,expect_invocation_expression};

struct SimpleLogger;

// Writes a message and info about the remaining tokens to msgs.
pub fn log(tokens:&[Token], msg:&str) {
    info!("{} with {} tokens left. Next token is {}", msg, tokens.len(), tokens.get(0).unwrap());
}

//
// Function-naming convention:
// Functions prefixed with "expect_" will return an error if they don't match what they're looking for,
// so they return Result<(tokens,type), String>
// Functions prefixed with "parse_" do not consider it an error if they do not match what they're looking
// for (thing "statement?"), so they return (tokens,Option<type>)
// Functions prefixed with "consume_" return a vector of some type and always succeed (think "statement*")
// so they are not wrapped in Option/Result. They just return (tokens,Vec<type>) 
//

pub fn expect_token(tokens:&[Token], expected:Token) -> Result<&[Token],String> {
    if tokens.get(0) == Some(&expected) {
        Ok(&tokens[1..])
    } else {
        Err(format!("Expected a {} and didn't get one", expected))
    }
}

pub fn expect_identifier_string(tokens:&[Token]) -> Result<(&[Token],String),String> {
    match tokens.get(0) {
        Some(tok) => {
            let my_copy = tok.clone();
            match my_copy {
                Token::ID(id) => Ok((&tokens[1..],id)),
                _ => Err(format!("Didn't find an identifier")),
            }
        },
        _ => Err(format!("Didn't find an identifier"))        
    }
}

pub fn consume_arguments(mut tokens:&[Token]) -> (&[Token],Vec<Expression>) {
    let mut args:Vec<Expression> = Vec::new();
    // 'outer: loop {
        match expect_expression(tokens) {
            Ok((rest,expr)) => {
                args.push(expr);
                tokens = rest;
                loop {
                    match tokens.get(0) {
                        Some(&Token::COMMA) => {
                            let (rest,expr) = expect_expression(&tokens[1..]).expect("Expected expression after comma in function call");
                            args.push(expr);
                            tokens = rest;
                        },
                        _ => break,
                    }
                }
            },
            Err(_msg) => {} // Didn't even get a first argument
        // }
    }
    (tokens,args)
}



pub fn expect_block(tokens:&[Token]) -> Result<(&[Token],Statement),String> {
    if tokens.get(0) == Some(&Token::LBRACE) {
        let rest = &tokens[1..];
        // This will return if consume_statementList yields Err
        let (rest,stmts) = consume_statementlist(rest);
        if rest.get(0) == Some(&Token::RBRACE) {
            return Ok((&rest[1..], Statement::Block{stmts}));
        } else {
            return Err(format!("Error: Expected a closing brace at the end of a block of statements"));
        }
    } else {
        return Err(format!("Error: Expected a left brace to open a block"));
    }
}

fn expect_lvalue(mut tokens:&[Token]) -> Result<(&[Token],Lvalue),String> {
    let (rest,id) = expect_identifier_string(tokens)?;
    let mut lvalue = Lvalue::Base{id};
    tokens = rest;
    loop {
        match tokens.get(0) {
            Some(&Token::DOT) => {
                let (rest,id) = expect_identifier_string(&tokens[1..]).expect("Exected identifier after dot in lvalue");
                lvalue = Lvalue::Dotted{lvalue:Box::new(lvalue),id};
                tokens = rest;
            },
            _ => break,
        }
    }
    Ok((tokens,lvalue))
}

pub fn expect_assignment(tokens:&[Token]) -> Result<(&[Token],Statement),String> {
    let (rest,lvalue) = expect_lvalue(tokens)?;
    let rest = expect_token(rest,Token::ASSIGN)?;
    match rest.get(0) {
        Some(Token::READ) => {
            let rest = expect_token(&rest[1..],Token::SEMICOLON).expect("Expected semicolon after '= read'");
            Ok((rest,Statement::Assignment{lvalue,expr:Expression::Read}))
        },
        _ => {
            let (rest,expr) = expect_expression(rest).expect("Expected expression as RVALUE");
            let rest = expect_token(&rest,Token::SEMICOLON)?;
            Ok((rest,Statement::Assignment{lvalue,expr}))        
        }
    }
}

pub fn expect_print_statement(mut tokens:&[Token]) -> Result<(&[Token],Statement),String> {
    match tokens.get(0) {
        Some(Token::PRINT) => {
            let (rest,expr) = expect_expression(&tokens[1..]).expect("Didn't find expression after PRINT token");
            tokens = rest;
            let mut endl = false;
            // Catch endl signifier
            match expect_token(&tokens,Token::ENDL) {
                Ok(rest) => {
                    endl = true;
                    tokens = rest;
                },
                Err(_msg) => {},
            }
            let rest = expect_token(tokens,Token::SEMICOLON).expect("Missing semicolon after print statement");
            return Ok((rest,Statement::Print{expr,endl}))
        },
        _ => return Err(format!("Failed to find a print keyword"))
    }
}

pub fn expect_if_statement(mut tokens:&[Token]) -> Result<(&[Token],Statement),String> {
    match (tokens.get(0),tokens.get(1)) {
        (Some(Token::IF),Some(Token::LPAREN)) => {
            let rest = &tokens[2..];
            match expect_expression(rest) {
                Ok((rest,guard)) => {
                    println!("{:?}",rest);
                    match expect_token(rest, Token::RPAREN) {
                        Ok(rest) => {
                            match expect_block(rest) {
                                Ok((rest,block)) => {
                                    let then_ = Box::new(block);
                                    let mut else_ = Box::new(Statement::Block{stmts:Vec::new()}); // Empty block if we lack an else clause
                                    match rest.get(0) {
                                        Some(&Token::ELSE) => {
                                            let (rest,block) = expect_block(&rest[1..]).expect("Missing 'else' code block in IF");
                                            else_ = Box::new(block);
                                            tokens = rest;
                                        },
                                        _ => tokens = rest, // If we didn't see an "else", then leave else_ as an empty block
                                    }
                                    Ok((tokens,Statement::If{guard, then_, else_}))        
                                },
                                Err(msg) => Err(format!("Error parsing 'then' block of IF because : {}",msg)),
                            }
                        },
                        Err(msg) => Err(format!("Missing RPAREN after guard expression in IF")),
                    }        
                },
                Err(msg) => Err(format!("Error parsing guard in IF because : {}",msg)),
            }
        },
        _ => Err(format!("Failed to find an 'if (' when parsing an if statement")),
    }
}

pub fn expect_while_statement(tokens:&[Token]) -> Result<(&[Token],Statement),String> {
    match tokens.get(0) {
        Some(Token::WHILE) => {
            let rest = &tokens[1..];
            let rest = expect_token(rest, Token::LPAREN).expect("Missing LPAREN after WHILE");
            let (rest,guard) = expect_expression(rest).expect("Missing guard expression WHILE");
            let rest = expect_token(rest, Token::RPAREN).expect("Missing RPAREN after guard expression in WHILE");
            let (rest,block) = expect_block(rest).expect("Missing code block in WHILE");
            let block = Box::new(block);
            Ok((rest,Statement::While{guard, block}))
        },
        _ => Err(format!("Failed to find a 'while' keyword"))
    }
}

pub fn expect_delete_statement(tokens:&[Token]) -> Result<(&[Token],Statement),String> {
    match tokens.get(0) {
        Some(Token::DELETE) => {
            let rest = &tokens[1..];
            let (rest,expr) = expect_expression(rest).expect("Missing expression after DELETE");
            let rest = expect_token(rest, Token::SEMICOLON).expect("Missing semicolon in DELETE statement");
            Ok((rest,Statement::Delete{expr}))
        },
        _ => Err(format!("Failed to find a 'delete' keyword"))
    }
}

pub fn expect_return_statement(mut tokens:&[Token]) -> Result<(&[Token],Statement),String> {
    match tokens.get(0) {
        Some(Token::RETURN) => {
            let rest = &tokens[1..];
            let (rest,expr) = expect_expression(rest).unwrap_or((rest,Expression::VoidExp));
            let rest = expect_token(rest, Token::SEMICOLON).expect("Missing semicolon in RETURN statement");
            Ok((rest,Statement::Return{expr}))
        },
        _ => Err(format!("Failed to find a 'return' keyword"))
    }
}
pub fn expect_invocation_statement(tokens:&[Token]) -> Result<(&[Token],Statement),String> {
    let (rest,inv) = expect_invocation_expression(tokens)?;
    let rest = expect_token(rest,Token::SEMICOLON).expect("Missing semicolon after function call");
    match inv {
        Expression::Inv{id,args} => Ok((rest,Statement::Call{id:id, args:args})),
        _ => panic!("Something really bad happened. expect_invocation_expression didn't return an Inv"),
    }
}

pub fn expect_statement(tokens:&[Token]) -> Result<(&[Token],Statement),String> {
    // A little explantaion of what's going on here. All of the expect_ functions will return an Err
    // if they don't match what they're looking for. The ".or()" method on a Result will (if the result
    // is of variant Err), instead of the Err, it will return whatever you pass to or(). So, if expect_block()
    // fails, expect_assignment() gets executed, etc. If all of them fail, only then does the expession 
    // generate an Err (whose contents are that of the last call in the chain)
    match (tokens.get(0),tokens.get(1)) {
        (Some(Token::LBRACE),_) => expect_block(tokens),
        (Some(Token::PRINT),_) => expect_print_statement(tokens),
        (Some(Token::IF),Some(Token::LPAREN)) => expect_if_statement(tokens),
        (Some(Token::WHILE),Some(Token::LPAREN)) => expect_while_statement(tokens),
        (Some(Token::DELETE),_) => expect_delete_statement(tokens),
        (Some(Token::RETURN),_) => expect_return_statement(tokens),
        (Some(Token::ID(id)),Some(Token::LPAREN)) => expect_invocation_statement(tokens),
        (Some(Token::ID(id)),Some(Token::ASSIGN)) => expect_assignment(tokens),
        (Some(Token::ID(id)),Some(Token::DOT)) => expect_assignment(tokens),
        (Some(first),Some(next)) => Err(format!("expect_statement doesn't know what to do with {} {}",first,next)),
        (_,_) => Err(format!("expect_statement reached the end of the input")),
    }
    // expect_block(tokens).or(
    // expect_assignment(tokens).or(
    // expect_print_statement(tokens).or(
    // expect_if_statement(tokens).or(
    // expect_while_statement(tokens).or(
    // expect_delete_statement(tokens).or(
    // expect_return_statement(tokens).or(
    // expect_invocation_statement(tokens)
    // )
    // )
    // )
    // )
    // )
    // )
    // )
}


pub fn consume_statementlist(mut tokens:&[Token]) -> (&[Token],Vec<Statement>) {
    let mut stmts = Vec::<Statement>::new();
    loop {
        match expect_statement(tokens) {
            Ok((rest,stmt)) => {
                stmts.push(stmt);
                tokens = rest;
            },
            // If it wasn't a valid statement, then we're at the end of the list
            Err(_msg) => break,
        }
    }
    (tokens,stmts)
}

fn expect_datatype(tokens:&[Token]) -> Result<(&[Token],Datatype),String> {
    match (tokens.get(0), tokens.get(1)) {
        (Some(Token::INT), _) => Ok((&tokens[1..], Datatype::Int)),
        (Some(Token::BOOL), _) => Ok((&tokens[1..], Datatype::Bool)),
        (Some(Token::STRUCT), Some(Token::ID(struct_id))) => Ok((&tokens[2..], Datatype::Structure{id:struct_id.to_string()})),
        _ => Err(format!("expect_datatype saw something that wasn't a datatype")),
    }
}

fn expect_decl(tokens:&[Token]) -> Result<(&[Token],Decl),String> {
    match (tokens.get(0), tokens.get(1), tokens.get(2)) {
        (Some(Token::INT), Some(Token::ID(id)), _) => Ok((&tokens[2..], Decl{id:id.to_string(),datatype:Datatype::Int})),
        (Some(Token::BOOL), Some(Token::ID(id)), _) => Ok((&tokens[2..], Decl{id:id.to_string(),datatype:Datatype::Bool})),
        (Some(Token::STRUCT), Some(Token::ID(struct_id)), Some(Token::ID(id))) => Ok((&tokens[3..], Decl{id:id.to_string(),datatype:Datatype::Structure{id:struct_id.to_string()}})),
        (Some(token),_,_) => Err(format!("expect_decl saw a {} when it was expecting a datatype", token)),
        (_,_,_) => Err(format!("End of input when expecting an identifier"))
    }
}

fn expect_parameters(mut tokens:&[Token]) -> Result<(&[Token],Vec<Decl>),String> {
    tokens = require_token(&tokens, Token::LPAREN)?;
    let mut decls:Vec<Decl> = Vec::new();
    loop {
        match expect_decl(&tokens) {
            Ok((rest,decl)) => {
                decls.push(decl);
                tokens = rest;
                // If the next token is a comma, keep looping, otherwise, break.
                match tokens.get(0) {
                    Some(Token::COMMA) => tokens = &tokens[1..],
                    _ => break,
                }
            },
            _ => break,
        }
    }
    tokens = require_token(&tokens, Token::RPAREN)?;
    Ok((tokens,decls))
}

fn expect_nesteddecl(mut tokens:&[Token]) -> Result<(&[Token],Vec<Decl>),String> {
    let mut decls = Vec::new();
    // Loop as long as we see ID's
    loop {
        match expect_decl(tokens) {
            Ok((rest,decl)) => {
                let rest = expect_token(rest,Token::SEMICOLON).expect("Missing semicolon after identfier");
                tokens = rest;
                decls.push(decl);
            },
            Err(_msg) => break,
        }
    }
    if decls.len() == 0 {
        Err(format!("No type declarations found in struct"))
    } else {
        Ok((tokens, decls))
    }
}

fn require_token(tokens:&[Token], token:Token) -> Result<&[Token],String> {
    match tokens.get(0) {
        Some(tok) => {
            if *tok == token {
                Ok(&tokens[1..])
            } else {
                Err(format!("Error: Encountered a {} when looking for a {}", tok, token))
            }
        },
        None => Err(format!("Error: End of input or wrong token while looking for a {}",token))
    }
}

fn expect_return_type(tokens:&[Token]) -> Result<(&[Token],Datatype),String> {
    match expect_datatype(tokens) {
        // If it's an int, bool, or struct, then return that
        Ok(result) => Ok(result),
        Err(msg) => {
            // Is it a void?
            let rest = expect_token(tokens,Token::VOID)?;
            Ok((rest,Datatype::Void))
        }
    }
}

fn expect_function(mut tokens:&[Token]) -> Result<(&[Token],Function),String> {
    println!("expect_function called with:");
    print_tokenvec(tokens);
    match (tokens.get(0), tokens.get(1)) {
        (Some(Token::FUN), Some(Token::ID(id))) => {
            let rest = &tokens[2..];

            let (rest,parms) = expect_parameters(&rest)?;
            // let rest = require_token(&rest, Token::RPAREN)?;
            let (rest, return_type) = expect_return_type(&rest)?;
            let rest = require_token(&rest, Token::LBRACE)?;
            let (rest,decls) = consume_decls(rest);
            let (rest,stmts) = consume_statementlist(rest);
            let rest = require_token(&rest, Token::RBRACE)?;
            tokens = rest;
            return Ok((tokens,Function{id:id.clone(), decls, parms, return_type, stmts}))
        },
        (Some(Token::FUN), _) => return Err(format!("Function declaration lacking identifier")),
        (_,_) => return Err(format!("Missing FUN when scanning for a function")),
    }
}

// Parses: function*
pub fn consume_functions(mut tokens:&[Token]) -> (&[Token],Vec<Function>) {
    let mut funcs:Vec<Function> = Vec::new();
    loop {
        match expect_function(tokens) {
            Ok((rest,func)) => {
                funcs.push(func);
                tokens = rest;
            },
            Err(_msg) => return (tokens,funcs),
        }
    }
}


pub fn consume_types(mut tokens:&[Token]) -> Result<(&[Token],Vec<TypeDeclaration>),Trace> {
    let mut types:Vec<TypeDeclaration> = Vec::new();
    loop {
        // If we see "struct ID {", that can only be a type definition
        match (tokens.get(0),tokens.get(1),tokens.get(2)) {
            (Some(&Token::STRUCT),Some(&Token::ID(ref id)),Some(Token::LBRACE)) => {
                match expect_nesteddecl(&tokens[3..]) {
                    Ok((rest,decls)) => {
                        match expect_token(rest, Token::RBRACE) {
                            Ok(rest) => {
                                match expect_token(rest, Token::SEMICOLON) {
                                    Ok(rest) => {
                                        types.push(TypeDeclaration{id:id.clone(),decls});
                                        tokens = rest;        
                                    },
                                    Err(msg) => return Err(Trace::new(msg).with(format!("Missing SEMICOLON after struct")))
                                }
                            },
                            Err(msg) => return Err(Trace::new(msg).with(format!("Missing RBRACE after struct fields"))),
                        }
                    },
                    Err(msg) => return Err(Trace::new(msg).with(format!("Error scanning for field declarations within a struct"))),
                }
            },
            // Anything other than "struct ID {" has to be something else, so we're done looping
            _ => break, // Reached end of structs
        }
    }
    Ok((tokens, types))
}

// Expects to find a type ID (',' ID)* ';'
// It splits them into separate type/id Decls and returns them in a vector
fn expect_declaration(mut tokens:&[Token]) -> Result<(&[Token],Vec<Decl>),String> {
    let mut decls:Vec<Decl> = Vec::new();

    let (rest,decl) = expect_decl(tokens)?;
    // Now that we have the first decl, get its type, and then we can start scanning for more IDs
    let the_type = decl.datatype.clone();
    decls.push(decl);
    tokens = rest;
    loop {
        match tokens.get(0) {
            Some(Token::COMMA) => {
                let (rest,id) = expect_identifier_string(&tokens[1..]).expect("Expected an identifier after comma in var declaration");
                tokens = rest;
                decls.push(Decl{id:id.to_string(), datatype:the_type.clone()});
            },
            Some(Token::SEMICOLON) => {
                tokens = &tokens[1..];
                break;
            },
            Some(tok) => panic!("Encountered invalid token ({}) when parsing a variable declaration", tok),
            _ => return Err(format!("Encountered end-of-input when parsing a variable declaration"))
        }    
    }
    Ok((tokens,decls))
}

pub fn consume_decls(mut tokens:&[Token]) -> (&[Token],Vec<Decl>) {
    let mut decls:Vec<Decl> = Vec::new();
    loop {
        match expect_declaration(tokens) {
            Ok((rest,other_decls)) => {
                decls.extend(other_decls);
                tokens = rest;
            },
            Err(_msg) => break,
        }
    }
    (tokens, decls)
}

