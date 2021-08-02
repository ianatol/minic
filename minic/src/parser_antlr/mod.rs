
extern crate serde_json;

// Modeled after
// https://www.youtube.com/watch?v=hIi_UlyIPMg

use std::fs;
use serde::{Serialize,Deserialize};
use crate::lexer::Token;

//
// The structures herein are for direct deserialization of JSON objects into Rust
// structures. From there, it is expected to convert them to more-detailed AST structures
// (eg. in native_ast.rs)

// Following are the structs which will be de-serialized from JSON into static types
// JSON arrays get deserialized to Vec<Value>
// JSON objects get deserialized to Map<String,Value>
//
// serde_json::Value is an enum/variant consisting of [ Null, Bool, Number, String, Array, Object ]
// it has methods for determining type: .is_null(), .is_array(), .is_bool(), .is_i64(), .is_f64(), etc.
// Note that these testing methods do not correspond to JSON types (there's no f64 or i64 in JSON). Rather,
// they're for determining if a JSON value can be sensibly converted to a Rust type.
// There are also methods for casting: .as_bool(), .as_array(), etc. which return an Optional of that type
// See: https://docs.serde.rs/serde_json/value/enum.Value.html
//
// You do not need to create structs representing the entire _depth_ of the JSON. You can just
// set an identifier's type to "serde_json::Value", and, from there, downward in the JSON, serde will
// just treat it as a monolithic "Value".
//
// You also don't need to include every property in every JSON object in your struct. If there are JSON
// properties and nowhere to put them in your struct, they're just discarded.
// See also: https://www.reddit.com/r/rust/comments/7hasv6/mixed_valuestruct_deserialization_with_serde_json/

#[derive(Serialize, Deserialize)]
pub struct JSONAST {
	pub types: Vec<JSONDatatype>,
	pub declarations: Vec<JSONDatatypeField>,
	pub functions: Vec<Function>,
}

#[derive(Serialize, Deserialize)]
pub struct JSONDatatype {
	pub id: String,
	pub line: u32,
	pub fields: Vec<JSONDatatypeField>,
}

#[derive(Serialize, Deserialize)]
pub struct JSONDatatypeField {
	pub id: String,
	pub line: u32,
	// In the JSON format, we've got a field called "type", but that's a reserved word
	// in Rust. So, we need a different name for it ("datatype") in our struct, but that
	// would break the deserialization (since serde won't find a "type" field in our struct
	// when it encounters "type" in the JSON). The following directive tells serde to map
	// out "datatype" field to the JSON's "type" field.
	// See: https://serde.rs/field-attrs.html
	#[serde(rename = "type")] 
	pub datatype: String,
}

// I _was_ using this for the declarations in struct AST (i.e. declarations : Vec<Declaration>)
// but the fields, for now, are identical to JSONDatatypeField, so we're using that so that we can
// reuse the print formatters.
//
// #[derive(Serialize, Deserialize)]
// pub struct Declaration {
// 	pub id: String,
// 	pub line: u32,
// 	// See explanation in JSONDatatypeField
// 	#[serde(rename = "type")] 
// 	pub datatype: String,
// }

#[derive(Serialize, Deserialize)]
pub struct Function {
	pub id: String,
	pub line: u32,
	pub declarations: Vec<JSONDatatypeField>,
	pub parameters: Vec<JSONDatatypeField>,
	pub return_type: String,
	pub body: Vec<serde_json::Value>,
}



// Here are the functions to read an AST from strings/files

pub fn parse_json_string(content:&str) -> Result<crate::ast::AST, String> {
	let result:Result<JSONAST,serde_json::Error> = serde_json::from_str(&content);
	match result {
		Ok(json_ast) => {
			let types = json_types_to_ast_types(json_ast.types);
			let declarations = json_decls_to_ast_decls(json_ast.declarations);
			let functions = json_funcs_to_ast_funcs(json_ast.functions)?;
			Ok(crate::ast::AST{types,declarations,functions})
		},
		Err(msg) =>Err(format!("Error parsing the JSON : {}", msg))
	}
}

pub fn parse_json_file(filename:&str) -> Result<crate::ast::AST, String> {
	println!("Reading {}", &filename);
	
	match fs::read_to_string(&filename) {
		Ok(content) => {
			parse_json_string(&content)
		},
		Err(msg) => Err(format!("Error reading file {} : {}", filename, msg))
	}	
}

pub fn parse_file(filename:&str) -> Result<crate::ast::AST, String> {
	println!("Executing ANTLR4 (in Java)...");
	let output = std::process::Command::new("java")
		.arg("-cp")
		.arg("../ANTLR4/antlr-4.8-complete.jar:../ANTLR4/javax.json-1.0.4.jar:../ANTLR4/build")
		.arg("MiniCompiler")
		.arg(filename)
		.output()
		.expect(&format!("Failed to compile {}",filename));
	if output.status.success() {
		parse_json_string(std::str::from_utf8(&output.stdout).unwrap())
	} else {
		println!("Failed to invoke ANTLR4");
		println!("Stdout was '{:?}'", String::from_utf8(output.stdout).expect("Failed to convert stdout bytes to string"));
		println!("Stderr was '{:?}'", String::from_utf8(output.stderr).expect("Failed to convert stderr bytes to string"));
		match std::env::current_dir() {
			Ok(pathbuf) => {
				println!("We were looking in {}",pathbuf.as_path().to_str().unwrap());
			},
			Err(msg) => println!("Wow... we can't even figure out thw current directory")
		}
		Err(format!("ANTLR stage failed with exit code : {}.",output.status.code().unwrap()))
	}
}

fn json_datatype_to_ast_datatype(datatype_str:&str) -> crate::ast::Datatype {
	match datatype_str {
		"int" => crate::ast::Datatype::Int,
		"bool" => crate::ast::Datatype::Bool,
		"void" => crate::ast::Datatype::Void,
		struct_id => crate::ast::Datatype::Structure{id:struct_id.to_string()},
	}
}

fn json_decls_to_ast_decls(decls:Vec<JSONDatatypeField>) -> Vec<crate::ast::Decl> {
	let mut ast_decls:Vec<crate::ast::Decl> = Vec::new();
	for decl in decls {
		let (decl_id,decl_datatype_str) = (decl.id,decl.datatype);
		let decl_datatype = json_datatype_to_ast_datatype(&decl_datatype_str);
		ast_decls.push(crate::ast::Decl{id:decl_id,datatype:decl_datatype})
	}
	ast_decls
}

fn json_types_to_ast_types(types:Vec<JSONDatatype>) -> Vec<crate::ast::TypeDeclaration> {
	let mut ast_types:Vec<crate::ast::TypeDeclaration> = Vec::new();
	for type_ in types {
		let decls = json_decls_to_ast_decls(type_.fields);
		let ast_type = crate::ast::TypeDeclaration {
			id:type_.id,
			decls:decls,
		};
		ast_types.push(ast_type);
	}
	ast_types
}


use std::collections::HashMap;
use crate::ast::Lvalue;
fn json_lval_to_ast_lval(stmt:&serde_json::Value) -> Result<crate::ast::Lvalue,String> {
	match serde_json::from_value::<HashMap<String,serde_json::Value>>(stmt.clone()) {
		Ok(obj) => {
			let line = obj.get("line").unwrap().as_u64().unwrap_or_else(|| panic!("Failed decoding 'line' in lvalue: {:?}",obj));
			let id = obj.get("id").unwrap().as_str().unwrap_or_else(|| panic!("Failed decoding 'id' in lvalue: {:?}",obj));
			match obj.get("left") {
				Some(left_json) => {
					// Grab the left and right JSON objects and turn those into AST objects, first.
					let lvalue = json_lval_to_ast_lval(left_json)?;
					Ok(Lvalue::Dotted{lvalue:Box::new(lvalue),id:id.to_string()})
				},
				None => {
					Ok(Lvalue::Base{id:id.to_string()})
				},
			}
		},
		Err(msg) => Err(format!("Error decoding an lvalue from JSON : {:?}",msg)),
	}
}


use crate::ast::Expression;
fn json_expr_to_ast_expr(stmt:&serde_json::Value) -> Result<crate::ast::Expression,String> {
	match serde_json::from_value::<HashMap<String,serde_json::Value>>(stmt.clone()) {
		Ok(obj) => {
			let line = obj.get("line").unwrap().as_u64().unwrap_or_else(|| panic!("Failed decoding 'line' in expression: {:?}",obj));
			let exp = obj.get("exp").unwrap().as_str().unwrap_or_else(|| panic!("Failed decoding 'exp' in expression: {:?}",obj));
			match exp {
				"true" => {
					Ok(Expression::True)
				},
				"false" => {
					Ok(Expression::False)
				},
				"null" => {
					Ok(Expression::Null)
				},
				"num" => {
					let num_as_str = obj.get("value").unwrap().as_str().unwrap_or_else(|| panic!("Failed decoding 'value' in 'num' expression: {:?}",obj));
					let num = num_as_str.parse::<u64>().unwrap_or_else(|_| panic!("Failed converting {} to a u64 in 'id' expression: {:?}",num_as_str,obj));
					Ok(Expression::Int(num))
				},
				"id" => {
					let id = obj.get("id").unwrap().as_str().unwrap_or_else(|| panic!("Failed decoding 'id' in 'id' expression: {:?}",obj));
					Ok(crate::ast::Expression::Var{id:id.to_string()})
				},
				"new" => {
					let id = obj.get("id").unwrap().as_str().unwrap_or_else(|| panic!("Failed decoding 'id' in 'new' expression: {:?}",obj));
					Ok(crate::ast::Expression::New{id:id.to_string()})
				},
				"dot" => {
					// Grab the left and right JSON objects and turn those into AST objects, first.
					let expr = json_expr_to_ast_expr(obj.get("left").unwrap())?;
					let id = obj.get("id").unwrap().as_str().unwrap_or_else(|| panic!("Failed decoding 'id' in 'dot' expression: {:?}",obj));
					Ok(crate::ast::Expression::Dot{expr:Box::new(expr),id:id.to_string()})
				},
				"unary" => {
					// Grab the left and right JSON objects and turn those into AST objects, first.
					let operand = json_expr_to_ast_expr(obj.get("operand").unwrap())?;
					let oper = match obj.get("operator").unwrap().as_str().unwrap_or_else(|| panic!("Failed decoding 'operator' in 'unary' expression: {:?}",obj)) {
						"!" => Token::BANG,
						"-" => Token::MINUS,
						op => panic!("Couldn't decide how to hand {} in binary expession : {:?}",op, obj)
					};
					Ok(crate::ast::Expression::Unary{oper,expr:Box::new(operand)})	
				},
				"binary" => {
					// Grab the left and right JSON objects and turn those into AST objects, first.
					let left = json_expr_to_ast_expr(obj.get("lft").unwrap())?;
					let right = json_expr_to_ast_expr(obj.get("rht").unwrap())?;
					let oper = match obj.get("operator").unwrap().as_str().unwrap() {
						"+" => Token::PLUS,
						"-" => Token::MINUS,
						"*" => Token::STAR,
						"/" => Token::SLASH,
						"&&" => Token::AND,
						"||" => Token::OR,
						"==" => Token::EQ,
						"!=" => Token::NE,
						">" => Token::GT,
						"<" => Token::LT,
						">=" => Token::GE,
						"<=" => Token::LE,
						op => panic!("Couldn't decode binary expession : {}",op)
					};
					Ok(crate::ast::Expression::Binary{oper,left:Box::new(left),right:Box::new(right)})	
				},
				"invocation" => {
					let mut args:Vec<Expression> = Vec::new();
					let id = obj.get("id").unwrap().as_str().unwrap_or_else(|| panic!("Failed decoding 'id' in 'invocation' expression: {:?}",obj));
					let arg_list = obj.get("args").unwrap().as_array().unwrap_or_else(|| panic!("Failed decoding 'args' in 'invocation' expression: {:?}",obj));
					for arg in arg_list {
						match json_expr_to_ast_expr(&arg) {
							Ok(expr) =>	args.push(expr),
							Err(msg) => panic!("Failed to parse statement in a block because : {}",msg),
						};
					}
					Ok(Expression::Inv{id:id.to_string(),args})
				},
				"read" => {
					Ok(Expression::Read)
				},
				_ => {
					Err(format!("Error decoding from JSON. I don't know what a '{}' expression is",exp))
				},
			}
		},
		Err(msg) => Err(format!("Error decoding an expression from JSON : {:?}",msg)),
	}
}

use crate::ast::Statement;
fn json_stmt_to_ast_stmt(stmt:&serde_json::Value) -> Result<crate::ast::Statement,String> {
	match serde_json::from_value::<HashMap<String,serde_json::Value>>(stmt.clone()) {
		Ok(obj) => {
			// Block statements don't contain a line number, so we can't reliably extract it here.
			// The alternatives are:
			//    1) don't bother
			//    2) extract the line number in all matches _except_ block statements
			//    3) Set line to some nonsense value when it's not present (which the 'block' match would be expected to ignore)
			// let line = obj.get("line").unwrap().as_u64().unwrap_or_else(|| panic!("Failed decoding 'line' as u64 in expression: {:?}",obj));
			let stmt = obj.get("stmt").unwrap().as_str().unwrap_or_else(|| panic!("Failed decoding 'stmt' in expression: {:?}",obj));
			match stmt {
				"return" => {
					match obj.get("exp") {
						Some(exp) => {
							// There was an expression with the 'return'
							let expr = json_expr_to_ast_expr(exp)?;
							Ok(Statement::Return{expr})		
						},
						None => {
							Ok(Statement::Return{expr:Expression::VoidExp})
						},
					}
				},
				"while" => {
					let guard = json_expr_to_ast_expr(obj.get("guard").unwrap())?;
					let block = json_stmt_to_ast_stmt(obj.get("body").unwrap())?;
					Ok(Statement::While{guard,block:Box::new(block)})
				},
				"if" => {
					let guard = json_expr_to_ast_expr(obj.get("guard").unwrap())?;
					let then_ = json_stmt_to_ast_stmt(obj.get("then").unwrap())?;
					match obj.get("else") {
						Some(else_) => {
							let else_ = json_stmt_to_ast_stmt(else_)?;
							// The object had an 'else' clause
							Ok(Statement::If{guard,then_:Box::new(then_),else_:Box::new(else_)})
						},
						None => {
							// The object lacked an 'else' clause
							let else_ = Statement::Block{stmts:Vec::new()};
							Ok(Statement::If{guard,then_:Box::new(then_),else_:Box::new(else_)})
						}
					}
				},
				"block" => {
					let list_as_json_value = obj.get("list").unwrap();
					let list = list_as_json_value.as_array().unwrap();
					let mut stmts:Vec<Statement> = Vec::new();
					for item in list {
						match json_stmt_to_ast_stmt(&item) {
							Ok(stmt) =>	stmts.push(stmt),
							Err(msg) => panic!("Failed to parse statement in a block because : {}",msg),
						};
					}
					Ok(Statement::Block{stmts})
				},
				"assign" => {
					let lvalue = json_lval_to_ast_lval(obj.get("target").unwrap())?;
					let expr = json_expr_to_ast_expr(obj.get("source").unwrap())?;
					Ok(Statement::Assignment{lvalue,expr})
				},
				"print" => {
					let expr = json_expr_to_ast_expr(obj.get("exp").unwrap())?;
					let endl = obj.get("endl").unwrap().as_bool().unwrap();
					Ok(Statement::Print{expr,endl})
				},
				"delete" => {
					let expr = json_expr_to_ast_expr(obj.get("exp").unwrap())?;
					Ok(Statement::Delete{expr})
				},
				"invocation" => {
					let mut args:Vec<Expression> = Vec::new();
					let id = obj.get("id").unwrap().as_str().unwrap_or_else(|| panic!("Failed decoding 'id' in 'invocation' statement: {:?}",obj));
					let arg_list = obj.get("args").unwrap().as_array().unwrap_or_else(|| panic!("Failed decoding 'args' in 'invocation' statement: {:?}",obj));
					for arg in arg_list {
						match json_expr_to_ast_expr(&arg) {
							Ok(expr) =>	args.push(expr),
							Err(msg) => panic!("Failed to parse statement in a block because : {}",msg),
						};
					}
					Ok(Statement::Call{id:id.to_string(),args})
				},
				_ => {
					Err(format!("Error decoding statement from JSON. I don't know what a '{}' statement is",stmt))
				}
			}
		},
		Err(msg) => Err(format!("Error decoding a statement from JSON : {:?}",msg)),
	}
}

fn json_stmts_to_ast_stmts(stmts:&Vec<serde_json::Value>) -> Result<Vec<crate::ast::Statement>,String> {
	let mut ast_stmts:Vec<crate::ast::Statement> = Vec::new();
	for stmt in stmts {
		match json_stmt_to_ast_stmt(&stmt) {
			Ok(ast_stmt) => ast_stmts.push(ast_stmt),
			Err(msg) => return Err(format!("{}",msg)),
		}
	}
	Ok(ast_stmts)
}

fn json_funcs_to_ast_funcs(funcs:Vec<Function>) -> Result<Vec<crate::ast::Function>,String> {
	let mut ast_funcs:Vec<crate::ast::Function> = Vec::new();
	for func in funcs {
		let parms = json_decls_to_ast_decls(func.parameters);
		let decls = json_decls_to_ast_decls(func.declarations);
		let stmts = json_stmts_to_ast_stmts(&func.body)?;
		let return_type = json_datatype_to_ast_datatype(&func.return_type);
		let ast_func = crate::ast::Function {
			id:func.id,
			parms:parms,
			decls:decls,
			return_type:return_type,
			stmts:stmts,
		};
		ast_funcs.push(ast_func);
	}
	Ok(ast_funcs)
}

#[test]
fn test1() {
	match parse_program("../ANTLR4/1.mini") {
		Ok(ast) => {
			println!("TYPES {:?}",json_types_to_ast_types(ast.types));
			println!("DECLS {:?}",json_decls_to_ast_decls(ast.declarations));
			println!("FUNCS {:?}",json_funcs_to_ast_funcs(ast.functions));
			// println!("OUTPUT FROM MINI: {}",result);
		},
		Err(msg) => println!("Error : {}",msg),
	};
	let ast = parse_json_file("../ANTLR4/2.json").unwrap();
	for function in &ast.functions {
		println!("\t{}", function.id);	
		for parameter in &function.parameters {
			println!("\t  {}:{}", parameter.id, parameter.datatype);
		}
	}
	println!("TYPES {:?}",json_types_to_ast_types(ast.types));
	println!("DECLS {:?}",json_decls_to_ast_decls(ast.declarations));
	println!("FUNCS {:?}",json_funcs_to_ast_funcs(ast.functions));

	// assert_eq!(
	// 	ast.functions.iter().map(|&func| func.id ).collect::<Vec<_>(),
	// 	vec!["f", "foo", "g", "main"].iter().copied()
	// );
	// match parse_json_file(String::from("../ANTLR4/1.json")) {
	// 	Ok(ast) => 	{
	// 		println!("We found the following function declarations:");
	// 		for function in ast.functions {
	// 			println!("\t{}", function.id);			
	// 		}
	// 	},
	// 	Err(msg) => println!("Error loading AST from JSON : {}", msg)
	// }


	 assert_eq!(1,2);
}

