use std::collections::HashSet;

extern crate getopts;

// All AST structs (Statement, Expression, Type, etc)
pub mod ast;
// use ast::AST;
pub mod instruction;

use std::io::Write;

mod lexer;
// mod parser;
// mod trace;

mod type_checker_joe;
mod context_list;
mod parser_antlr;
mod cfg;
mod dataflow;
mod output;

#[derive(Clone,PartialEq,Eq,Hash)]
pub enum Optimization {
	RemoveTrivialPhis,
	RemoveEmptyBlocks,
	ConstantPropagation,
	DeadCodeRemoval,
	RegisterAssignment,
	RemoveComments,
}


fn print_usage(program: &str) {
    println!("Usage: {} source_file (-l[r]|-a[r]) [-o(optimizations)]", program);
	println!("  -l  : Compile to LLVM (stack-based)");
	println!("  -lr : Compile to LLVM (SSA/register-based)");
	println!("  -a  : Compile to ARM  (stack-based)");
	println!("  -ar : Compile to ARM  (w/ register allocation)");
	println!("");
	println!("  Optimizations");
	println!("    c : Constant propagation");
	println!("    d : Dead code removal");
	println!("    e : Empty block removal");
	println!("    q : Don't output comments (quiet)");
	println!("    t : Trivial phi removal");
	println!("    A : All optimizations");
	println!("");
	println!("  Example:");
	println!("    {} -ar -odc : output ARM with register assignment and dead-code removal and constant propagation", program);
	println!("    {} -l -oqe : output stack-based LLVM with empty block removal and minimal comments", program);
	println!("    {} -a -oA : output stack-based ARM with all optimizations", program);
	println!("");
}

fn main() {
	// Adapted from https://docs.rs/getopts/0.2.21/getopts/
    let args: Vec<String> = std::env::args().collect();
    let program = args[0].clone();

	if args.len() < 3 {
        print_usage(&program);
		std::process::exit(1);
	}

	let input_filename = args[1].clone();	
	let input_file_path = std::path::Path::new(&input_filename);
	
	let mut output_filename = String::new();
	let mut compile_target = cfg::code_generator::CompileTarget::LLVM;
	let mut ssa_mode = cfg::code_generator::SSAMode::Stack;
	let mut arch = cfg::code_generator::Arch::I64;
	let mut optimizations:HashSet<Optimization> = HashSet::new();
	match args[2].as_str() {
		"-l" => {
			compile_target = cfg::code_generator::CompileTarget::LLVM;
			ssa_mode = cfg::code_generator::SSAMode::Stack;
			arch = cfg::code_generator::Arch::I64;
			output_filename = format!("intermediate.ll");
		},
		"-lr" => {
			compile_target = cfg::code_generator::CompileTarget::LLVM;
			ssa_mode = cfg::code_generator::SSAMode::Register;
			arch = cfg::code_generator::Arch::I64;
			output_filename = format!("intermediate.ll");
		},
		"-a" => {
			compile_target = cfg::code_generator::CompileTarget::ARM;
			ssa_mode = cfg::code_generator::SSAMode::Register;
			arch = cfg::code_generator::Arch::I32;
			output_filename = format!("intermediate.s");
		},
		"-ar" => {
			compile_target = cfg::code_generator::CompileTarget::ARM;
			ssa_mode = cfg::code_generator::SSAMode::Register;
			arch = cfg::code_generator::Arch::I32;
			optimizations.insert(Optimization::RegisterAssignment);
			output_filename = format!("intermediate.s");
		},
		_ => {
			print_usage(&program);
			std::process::exit(1);
		}
	}
	
	if args.len() > 3 {
		if args[3].starts_with("-o") {
			let mut remaining_flags = &args[3][2..];
			while remaining_flags.len() > 0 {
				match &remaining_flags[0..1] {
					"c" => { optimizations.insert(Optimization::ConstantPropagation); },
					"d" => { optimizations.insert(Optimization::DeadCodeRemoval); },
					"e" => { optimizations.insert(Optimization::RemoveEmptyBlocks); },
					"q" => { optimizations.insert(Optimization::RemoveComments); },
					"t" => { optimizations.insert(Optimization::RemoveTrivialPhis); },
					"A" => {
						optimizations.insert(Optimization::ConstantPropagation);
						optimizations.insert(Optimization::DeadCodeRemoval);
						optimizations.insert(Optimization::RemoveEmptyBlocks);
						optimizations.insert(Optimization::RemoveComments);
						optimizations.insert(Optimization::RemoveTrivialPhis);
					},
					opt => {
						println!("UNKNOWN OPTION : {}", opt);
						print_usage(&program);
						std::process::exit(1);
					}
				}
				remaining_flags = &remaining_flags[1..];
			}
		}
	}

	let mini_source_file = input_file_path.to_str().unwrap();
	println!("Compiling file : {}",mini_source_file);
	match parser_antlr::parse_file(mini_source_file) {
		Ok(ast) => {
			print!("Parse succeeded");
			println!("Typechecking...");
			match ast.type_check() {
				Ok(_) => {
					println!("Type-check was ok");
					match ast.gen_cfg() {
						Ok(mut cfg) => {
							if optimizations.contains(&Optimization::RemoveEmptyBlocks) {
								cfg.merge_blocks(); // Merge blocks with single successors which have single preds
							}
							println!("Creating file {:?}", output_filename);
							let mut file = std::fs::File::create(output_filename).unwrap();
							let mut instructions = Vec::<String>::new();
							cfg.compile(&mut instructions, arch, ssa_mode, compile_target, &optimizations);
							for instruction in instructions {
								match file.write(format!("{}\n",instruction).as_bytes()) {
									Ok(_) => {},
									Err(msg) => {
										println!("{}",msg);
										std::process::exit(5);
									},
								}
							}
							println!("Well, that seems to have gone well");
						},
						Err(msg) => {
							println!("{}",msg);
							std::process::exit(3);
						}
					}
				},
				Err(msg) => {
					println!("{}",msg);
					std::process::exit(2);
				}
			}
		},
		Err(msg) => {
			println!("Parse failed : {}", msg);
			std::process::exit(1);
		}
	}	
	std::process::exit(0);
}

