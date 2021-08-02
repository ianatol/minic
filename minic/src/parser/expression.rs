
use crate::parser::statement::{expect_identifier_string,expect_token,consume_arguments,log};
use crate::ast::*;
use crate::lexer::Token;

pub fn expect_invocation_expression(tokens:&[Token]) -> Result<(&[Token],Expression),String> {
    match (tokens.get(0),tokens.get(1)) {
        (Some(Token::ID(ref id)),Some(Token::LPAREN)) => {
            let (rest,args) = consume_arguments(&tokens[2..]);
            let rest = expect_token(rest,Token::RPAREN).expect("Missing RPAREN after arguments in function call");
            Ok((rest,Expression::Inv{id:id.clone(),args}))
       },
       _ => Err(format!("Didn't match a valid invocation expression"))
    }
}

fn expect_terminal_expression(tokens:&[Token],since_altered:u32) -> Result<(&[Token],Expression),String> {
    match (tokens.get(0),tokens.get(1)) {
        (Some(Token::NEW),Some(Token::ID(ref id))) => Ok((&tokens[2..],Expression::New{id:id.clone()})),
        (Some(&Token::TRUE),_) => Ok((&tokens[1..], Expression::True)),
        (Some(&Token::FALSE),_) => Ok((&tokens[1..], Expression::False)),
        (Some(&Token::NULL),_) => Ok((&tokens[1..], Expression::Null)),
        (Some(&Token::NUM(val)),_) => Ok((&tokens[1..], Expression::Int(val))),
        (Some(Token::ID(ref id)),Some(Token::LPAREN)) => expect_invocation_expression(tokens),
        (Some(Token::ID(ref id)),_) => Ok((&tokens[1..],Expression::Var{id:id.clone()})),
        (Some(tok),_) =>     expect_expression_recurse(tokens,since_altered+1),
        // Some(tok) => Err(format!("No terminal expression found in {}", tok)),
        _ => Err(format!("Didn't find a valid terminal expression")),
    }
}

fn expect_paren_expression(tokens:&[Token],since_altered:u32) -> Result<(&[Token],Expression),String> {
    match tokens.get(0) {
        Some(&Token::LPAREN) => {
            // If we have something in parens, start over with expect_expression_recurse on the inside
            let (rest,expr) = expect_expression_recurse(&tokens[1..],0)?;
            let rest = expect_token(rest, Token::RPAREN).expect("Expected a RPAREN after LPAREN expression");
            Ok((rest,expr))
        },
        _ => expect_terminal_expression(tokens,since_altered+1),
    }
}

fn expect_dot_expression(mut tokens:&[Token],since_altered:u32) -> Result<(&[Token],Expression),String> {
    let (rest,expr1) = expect_paren_expression(tokens,since_altered+1)?;
    let mut expr = expr1;
    tokens = rest;
    loop {
        match tokens.get(0) {
            Some(&Token::DOT) => {
                let (rest,id) = expect_identifier_string(&tokens[1..]).expect("Exected identifier after dot in expression");
                expr = Expression::Dot{expr:Box::new(expr),id};
                tokens = rest;
            },
            _ => break,
        }
    }
    Ok((tokens,expr))
}

fn expect_unary_expression(tokens:&[Token],since_altered:u32) -> Result<(&[Token],Expression),String> {
    match tokens.get(0) {
        Some(&Token::MINUS) => {
            let (rest,expr) = expect_unary_expression(&tokens[1..],0).expect("Expected an expression after MINUS");
            Ok((rest,Expression::Unary{oper:Token::MINUS,expr:Box::new(expr)}))
        },
        Some(&Token::BANG) => {
            let (rest,expr) = expect_unary_expression(&tokens[1..],0).expect("Expected an expression after BANG");
            Ok((rest,Expression::Unary{oper:Token::BANG,expr:Box::new(expr)}))
        },
        // Anything else, just give back the one expression we got
        _ => expect_dot_expression(tokens,since_altered+1),
    }
}

fn expect_mult_expression(tokens:&[Token],since_altered:u32) -> Result<(&[Token],Expression),String> {
    let (rest,left) = expect_unary_expression(tokens,since_altered+1)?;
    match rest.get(0) {
        Some(&Token::STAR) => {
            let (rest,right) = expect_mult_expression(&rest[1..],0).expect("Expected an expression after STAR");
            Ok((rest,Expression::Binary{oper:Token::STAR,left:Box::new(left),right:Box::new(right)}))
        },
        Some(&Token::SLASH) => {
            let (rest,right) = expect_mult_expression(&rest[1..],0).expect("Expected an expression after SLASH");
            Ok((rest,Expression::Binary{oper:Token::SLASH,left:Box::new(left),right:Box::new(right)}))
        },
        // Anything else, just give back the one expression we got
        _ => Ok((rest,left)),
    }
}


fn expect_add_expression(tokens:&[Token],since_altered:u32) -> Result<(&[Token],Expression),String> {
    let (rest,left) = expect_mult_expression(tokens,since_altered+1)?;
    match rest.get(0) {
        Some(&Token::PLUS) => {
            let (rest,right) = expect_add_expression(&rest[1..],0).expect("Expected an expression after PLUS");
            Ok((rest,Expression::Binary{oper:Token::PLUS,left:Box::new(left),right:Box::new(right)}))
        },
        Some(&Token::MINUS) => {
            let (rest,right) = expect_add_expression(&rest[1..],0).expect("Expected an expression after MINUS");
            Ok((rest,Expression::Binary{oper:Token::MINUS,left:Box::new(left),right:Box::new(right)}))
        },
        // Anything else, just give back the one expression we got
        _ => Ok((rest,left)),
    }
}

fn expect_rel_expression(tokens:&[Token],since_altered:u32) -> Result<(&[Token],Expression),String> {
    let (rest,left) = expect_add_expression(tokens,since_altered+1)?;
    match rest.get(0) {
        Some(&Token::LT) => {
            let (rest,right) = expect_add_expression(&rest[1..],0).expect("Expected an expression after LT");
            Ok((rest,Expression::Binary{oper:Token::LT,left:Box::new(left),right:Box::new(right)}))
        },
        Some(&Token::GT) => {
            let (rest,right) = expect_add_expression(&rest[1..],0).expect("Expected an expression after GT");
            Ok((rest,Expression::Binary{oper:Token::GT,left:Box::new(left),right:Box::new(right)}))
        },
        Some(&Token::LE) => {
            let (rest,right) = expect_add_expression(&rest[1..],0).expect("Expected an expression after LE");
            Ok((rest,Expression::Binary{oper:Token::LE,left:Box::new(left),right:Box::new(right)}))
        },
        Some(&Token::GE) => {
            let (rest,right) = expect_add_expression(&rest[1..],0).expect("Expected an expression after GE");
            Ok((rest,Expression::Binary{oper:Token::GE,left:Box::new(left),right:Box::new(right)}))
        },
        // Anything else, just give back the one expression we got
        _ => Ok((rest,left)),
    }
}

fn expect_eq_expression(tokens:&[Token],since_altered:u32) -> Result<(&[Token],Expression),String> {
    let (rest,left) = expect_rel_expression(tokens,since_altered+1)?;
    match rest.get(0) {
        Some(&Token::EQ) => {
            let (rest,right) = expect_rel_expression(&rest[1..],0).expect("Expected an expression after EQ");
            Ok((rest,Expression::Binary{oper:Token::EQ,left:Box::new(left),right:Box::new(right)}))
        },
        Some(&Token::NE) => {
            let (rest,right) = expect_rel_expression(&rest[1..],0).expect("Expected an expression after NE");
            Ok((rest,Expression::Binary{oper:Token::NE,left:Box::new(left),right:Box::new(right)}))
        },
        // Anything else, just give back the one expression we got
        _ => Ok((rest,left)),
    }
}


fn expect_bool_expression(tokens:&[Token],since_altered:u32) -> Result<(&[Token],Expression),String> {
    // println!("expect_bool_expression called with")
    let (rest,left) = expect_eq_expression(tokens,since_altered+1)?;
    match rest.get(0) {
        Some(&Token::AND) => {
            let (rest,right) = expect_bool_expression(&rest[1..],0).expect("Expected an expression after EQ");
            Ok((rest,Expression::Binary{oper:Token::AND,left:Box::new(left),right:Box::new(right)}))
        },
        Some(&Token::OR) => {
            let (rest,right) = expect_bool_expression(&rest[1..],0).expect("Expected an expression after NE");
            Ok((rest,Expression::Binary{oper:Token::OR,left:Box::new(left),right:Box::new(right)}))
        },
        // Anything else, just give back the one expression we got
        _ => Ok((rest,left)),
    }
}

fn expect_expression_recurse(mut tokens:&[Token],since_altered:u32) -> Result<(&[Token],Expression),String> {
    // This is a really hacky way of preventing infinite recursion. At each step in the parsing, we note
    // whether or not the token-stream has been altered (basically, any time we call the next step in the
    // chain with "&tokens[x..]" instead of just "tokens"), we reset since_altered to zero. Otherwise, we
    // pass since_altered+1. If we get back here and since_altered is greater than the number of parsing
    // functions we have in the loop, then we know a full loop has happened without the token-stream having
    // been altered, so there's no reason to expect a different outcome if we continue. Ideally, the threshold
    // should be set to the exact number of functions forming the largest recursion loop. If the threshold value
    // is set too low, then a function near the "top" of the call chain could alter the token-stream and this
    // guard could still terminate the recursion. If it's set too high, we merely risk going through the loop
    // more than once. So, we set it too high to be safe-but-a-little-inefficient.
    if since_altered < 15 {
        expect_bool_expression(tokens,since_altered+1)
    } else {
        Err(format!("Recursed too deep without matchng any token"))
    }
}

pub fn expect_expression(tokens:&[Token]) -> Result<(&[Token],Expression),String> {
    log(tokens,"expect_expression:enter");
    expect_expression_recurse(tokens,0)
}