
use std::fmt;
use std::fs;
use regex::Regex;

#[derive(PartialEq,Clone,Debug)]
pub enum Token {
	// Types
	INT,
	BOOL,
	VOID,
	// Literals
	NULL,
	TRUE,
	FALSE,
	NUM(u64),
	ID(String),
	// Keywords
	STRUCT,
	// VAR,
	FUN,
	PRINT,
	ENDL,
	NEW,
	READ,
	IF,
	THEN,
	ELSE,
	WHILE,
	DELETE,
	RETURN,
	// Punctuation
	COLON,
	SEMICOLON,
	DOT,
	COMMA,
	ASSIGN,
	GT,
	LT,
	LE,
	GE,
	EQ,
	NE,
	AND,
	OR,
	PLUS,
	MINUS,
	STAR,
	SLASH,
	BANG,
	LPAREN,
	RPAREN,
	LBRACE,
	RBRACE,
}

// So that println!/format!/write! work when passed things with Tokens
impl fmt::Display for Token {
	fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
		match self {
			Token::INT => write!(f, "{}", "INT"),
			Token::BOOL => write!(f, "{}", "BOOL"),
			Token::VOID => write!(f, "{}", "VOID"),
			Token::NULL => write!(f, "{}", "NULL"),
			Token::TRUE => write!(f, "{}", "TRUE"),
			Token::FALSE => write!(f, "{}", "FALSE"),
			Token::NUM(n) => write!(f, "{}({})", "NUM",n),
			Token::ID(id) => write!(f, "{}({})", "ID",id),
			Token::STRUCT => write!(f, "{}", "STRUCT"),
			Token::FUN => write!(f, "{}", "FUN"),
			// Token::VAR => write!(f, "{}", "VAR"),
			Token::PRINT => write!(f, "{}", "PRINT"),
			Token::ENDL => write!(f, "{}", "ENDL"),
			Token::NEW => write!(f, "{}", "NEW"),
			Token::READ => write!(f, "{}", "READ"),
			Token::IF => write!(f, "{}", "IF"),
			Token::THEN => write!(f, "{}", "THEN"),
			Token::ELSE => write!(f, "{}", "ELSE"),
			Token::WHILE => write!(f, "{}", "WHILE"),
			Token::DELETE => write!(f, "{}", "DELETE"),
			Token::RETURN => write!(f, "{}", "RETURN"),
			Token::COLON => write!(f, "{}", "COLON"),
			Token::SEMICOLON => write!(f, "{}", "SEMICOLON"),
			Token::DOT => write!(f, "{}", "DOT"),
			Token::COMMA => write!(f, "{}", "COMMA"),
			Token::ASSIGN => write!(f, "{}", "ASSIGN"),
			Token::GT => write!(f, "{}", "GT"),
			Token::LT => write!(f, "{}", "LT"),
			Token::LE => write!(f, "{}", "LE"),
			Token::GE => write!(f, "{}", "GE"),
			Token::EQ => write!(f, "{}", "EQ"),
			Token::NE => write!(f, "{}", "NE"),
			Token::AND => write!(f, "{}", "AND"),
			Token::OR => write!(f, "{}", "OR"),
			Token::PLUS => write!(f, "{}", "PLUS"),
			Token::MINUS => write!(f, "{}", "MINUS"),
			Token::STAR => write!(f, "{}", "STAR"),
			Token::SLASH => write!(f, "{}", "SLASH"),
			Token::BANG => write!(f, "{}", "BANG"),
			Token::LPAREN => write!(f, "{}", "LPAREN"),
			Token::RPAREN => write!(f, "{}", "RPAREN"),
			Token::LBRACE => write!(f, "{}", "LBRACE"),
			Token::RBRACE => write!(f, "{}", "RBRACE"),
		}
	}
}

// println!/format!/write! don't seem to like to print Vec[Token], so we do it manually
#[allow(dead_code)]
pub fn print_tokenvec(tokens:&[Token]) {
	for token in tokens.iter() {
		print!("-> {}",token);
	}
	println!("");
}

#[allow(dead_code)]
pub fn tokenize_file(filename:&str) -> Result<Vec<Token>,String> {
	println!("Parsing file {}", filename);
	let mut source_text:&str = &(fs::read_to_string(filename).expect("Something went wrong reading the file"));
	tokenize_string(&mut source_text)
}

#[allow(dead_code)]
pub fn tokenize_string(source_text:&str) -> Result<Vec<Token>,String> {
	let mut tokens = Vec::<Token>::new();

	// Regexes for matching identifiers, numbers, and whitespace
	let re_id:Regex = Regex::new("^[a-zA-Z][A-Za-z0-9_]*").unwrap();
	let re_num:Regex = Regex::new("^[0-9]+").unwrap();
    let re_ws:Regex = Regex::new("^[ \t]+").unwrap();
    let re_nl:Regex = Regex::new("^\n").unwrap();
    let re_comment:Regex = Regex::new("#[^\n]*").unwrap(); // Comments are to the end of the line

	// Make a working copy of the input file
	let all_chars:&str = source_text.clone();
    // println!("Before removing comments, the input is : {}", all_chars);
    let mut chars:&str = &re_comment.replace_all(all_chars,"");
    // println!("After removing comments, the input is : {}", chars);

	// Reserved words
	let reserved = [ 
		("struct", Token::STRUCT), 
		("int", Token::INT), 
		("bool", Token::BOOL), 
		("void", Token::VOID),
		("null", Token::NULL), 
		("true", Token::TRUE), 
		("false", Token::FALSE), 
		("fun", Token::FUN),
		("print", Token::PRINT),
		("endl", Token::ENDL),
		("new", Token::NEW),
		("read", Token::READ),
		("if", Token::IF), 
		("then", Token::THEN), 
		("else", Token::ELSE), 
		("while", Token::WHILE), 
		("delete", Token::DELETE), 
		("return", Token::RETURN), 
		// ("var", Token::VAR), 
		("<=", Token::LE),
		(">=", Token::GE),
		("==", Token::EQ),
		("!=", Token::NE),
		("&&", Token::AND),
		("||", Token::OR),
		("{", Token::LBRACE), 
		("}", Token::RBRACE), 
		("(", Token::LPAREN), 
		(")", Token::RPAREN), 
		(":", Token::COLON), 
		(";", Token::SEMICOLON),
		(".", Token::DOT), 
		(",", Token::COMMA),
		("=", Token::ASSIGN),
		("+", Token::PLUS),
		("-", Token::MINUS),
		("*", Token::STAR),
		("/", Token::SLASH),
		("!", Token::BANG),
		("<", Token::LT),
		(">", Token::GT),

	];

    // Consume the input text until it's all gone
    let mut line_num = 1;
	'outer: while chars.len() > 0 {
		// print!("The token-stream is now : ");
		// print_tokenvec(&tokens);

		// Scan for fixed-length reserved words
		for (s,tok) in reserved.iter() {
			if chars.starts_with(s) {
				tokens.push(tok.clone());
				chars = &chars[s.len()..];
				continue 'outer;
			}
		}
		// Scan for variable-length/variable-content tokens (whitespace, numbers, identifiers)
		if let Some(re_match) = re_ws.find(chars) {  chars = &chars[(re_match.end()-re_match.start())..]; continue; }
		if let Some(re_match) = re_nl.find(chars) { line_num += 1; chars = &chars[(re_match.end()-re_match.start())..]; continue; }
		if let Some(re_match) = re_id.find(chars) { tokens.push(Token::ID(re_match.as_str().to_string())); chars = &chars[(re_match.end()-re_match.start())..]; continue; }
		if let Some(re_match) = re_num.find(chars) { tokens.push(Token::NUM(re_match.as_str().parse::<u64>().unwrap())); chars = &chars[(re_match.end()-re_match.start())..]; continue; }
		println!("Unknown character : {}",&chars[0..1]);
		chars = &chars[1..];
	}
	Ok(tokens)
}

#[cfg(test)]
// mod tests {

   #[test]
   fn relational_equality_operators() {
	  assert_eq!(tokenize_string("=="), Ok([Token::EQ].to_vec()));
	  assert_eq!(tokenize_string(">="), Ok([Token::GE].to_vec()));
	  assert_eq!(tokenize_string("=>"), Ok([Token::ASSIGN, Token::GT].to_vec()));
   }
// }