
use std::fmt;
use super::lexer::Token;

#[derive(Debug)]
pub struct AST {
	pub types: Vec<TypeDeclaration>,
	pub declarations: Vec<Decl>,
	pub functions: Vec<Function>,
}

#[derive(Debug)]
pub struct Function {
    pub id: String,
    pub parms: Vec<Decl>,
    pub decls: Vec<Decl>,
    pub return_type: Datatype,
    pub stmts: Vec<Statement>,
}

impl std::fmt::Display for Function {
	fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
		write!(f, "Function:  id:{} - parms:{} - returns:{} - statements:{}", self.id, self.parms.len(), self.return_type, self.stmts.len())
	}
}

#[derive(Debug,Clone)]
pub enum Statement {
    Block{stmts:Vec<Statement>},
    Assignment{lvalue:Lvalue, expr:Expression},
    Print{expr:Expression, endl:bool},
    If{guard:Expression, then_:Box<Statement>, else_:Box<Statement> }, // then_/else_ should always be Statement::Block
    While{guard:Expression, block:Box<Statement>}, // block should always be Statement::Block
    Delete{expr:Expression},
    Return{expr:Expression},
    Call{id:String, args:Vec<Expression>},
}

impl std::fmt::Display for Statement {
	fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
		match self {
			Statement::Block{stmts} => write!(f, "Block with {} statements",stmts.len()),
         Statement::Assignment{lvalue,expr} => write!(f, "Assignment {}={}", lvalue, expr),
         Statement::Print{expr, endl} => write!(f, "Print {} endl={}", expr, endl),
         Statement::If{guard, then_, else_} => write!(f, "If {} then {} else {}", guard, then_, else_),
         Statement::While{guard, block} => write!(f, "While {} do {}", guard, block),
         Statement::Delete{expr} => write!(f, "Delete {}", expr),
         Statement::Return{expr} => write!(f, "Return {}", expr),
         Statement::Call{id, args} => write!(f, "Function call {} with {} args", id, args.len()),
		}
	}
}

#[derive(Debug,Clone)]
pub enum Lvalue {
   Base{id:String},
   Dotted{lvalue:Box<Lvalue>, id:String}
}

impl std::fmt::Display for Lvalue {
	fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
      match self {
         Lvalue::Base{id} => write!(f, "{}", id),
         Lvalue::Dotted{lvalue,id} => write!(f,"{}.{}",lvalue,id),
      }
	}
}


#[derive(Debug,Clone)]
pub enum Expression {
   True,
   False,
   VoidExp,
   Null,
   Int(u64),
   Var {id:String},
   Unary {oper: Token, expr: Box<Expression>},
   Binary {oper: Token, left: Box<Expression>, right: Box<Expression>},
   New {id:String},
   Dot {expr: Box<Expression>, id:String},
   Inv {id:String, args:Vec<Expression> },
   Read,
}

impl PartialEq for Expression {
   fn eq(&self, other: &Self) -> bool {
      match (self,other) {
         // TODO: Might want to compare contexts. If we do (and if we impl PartialEq for
         // Context, then we can probably let Rust derive PartialEq for us)
         (Expression::True,Expression::True) => true,
         (Expression::False,Expression::False) => true,
         (Expression::VoidExp,Expression::VoidExp) => true,
         (Expression::Null,Expression::Null) => true,
         (Expression::Int(val1),Expression::Int(val2)) => val1==val2,
         (Expression::Var{id:id1},Expression::Var{id:id2}) => id1==id2,
         (Expression::Unary{oper:oper1, expr:expr1},Expression::Unary{oper:oper2, expr:expr2}) => (oper1==oper2) && (expr1==expr2),
         (Expression::Binary{oper:o1,left:l1,right:r1},Expression::Binary{oper:o2,left:l2,right:r2}) => (o1==o2) && (l1==l2) && (r1==r2),
         (Expression::New{id:id1},Expression::New{id:id2}) => id1==id2,
         (Expression::Dot{expr:expr1,id:id1},Expression::Dot{expr:expr2,id:id2}) => (expr1==expr2) && (id1==id2),
         (Expression::Inv{id:id1,args:args1},Expression::Inv{id:id2,args:args2}) => (id1==id2) && (args1==args2),
         (Expression::Read,Expression::Read) => true,
         // Anything else, the variants don't match
         _ => false,
      }
   }
}

impl fmt::Display for Expression {
   fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
      match self {
         Expression::True => write!(f, "Expression::True"),
         Expression::False  => write!(f, "Expression::True"),
         Expression::VoidExp => write!(f, "Expression::Void"),
         Expression::Null => write!(f, "Expression::Null"),
         Expression::Int (val) => write!(f, "Expression::Int({})",val),
         Expression::Var {id} => write!(f, "Expression::Var({})",id),
         Expression::Unary {oper,expr} => write!(f, "Expression::Unary({} {})",oper, expr),
         Expression::Binary {oper,left,right} => write!(f, "Expression::Binary({},{},{})",left,oper,right),
         Expression::New {id} => write!(f, "Expression::New({})",id),
         Expression::Dot {expr,id} => write!(f, "Expression::Dot({}.{})",expr,id),
         Expression::Inv {id,args} => write!(f, "Expression::Inv({}({} args))",id,args.len()),
         Expression::Read => write!(f, "Expression::Read"),
      }
   }
}

#[derive(Eq,Debug,Clone)]
pub enum Datatype {
   Void,
   Null,
   Bool,
   Int,
   SmallInt,
   Structure{id:String},
   Ref(Box<Datatype>),
}

impl PartialEq for Datatype {
   fn eq(&self, other: &Self) -> bool {
      match (self,other) {
         (Datatype::Void,Datatype::Void) => true,
         (Datatype::Bool,Datatype::Bool) => true,
         (Datatype::Int,Datatype::Int) => true,
         (Datatype::SmallInt, Datatype::SmallInt) => true,
         // Null types match any structure
         (Datatype::Null,Datatype::Structure{id:_}) => true,
         (Datatype::Structure{id:_},Datatype::Null) => true,
         // Structs must be of the same name
         (Datatype::Structure{id:id1},Datatype::Structure{id:id2}) => id1==id2,
         // References must point to equivalent datatypes
         (Datatype::Ref(inner1),Datatype::Ref(inner2)) => inner1==inner2,
         (Datatype::Null,Datatype::Ref(inner2)) => true,
         (Datatype::Ref(inner1),Datatype::Null) => true,
         
         // Any other combo is not equal
         (_,_) => false,
      }
   }
}

impl fmt::Display for Datatype {
   fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
      write!(f, "{}", self.get_name())
   }
}

impl Datatype {
   pub fn get_name(&self) -> String {
      match self {
        Datatype::Void => String::from("Void"),
        Datatype::Null => String::from("Null"),
        Datatype::Bool => String::from("Bool"),
        Datatype::Int => String::from("Int"),
        Datatype::SmallInt => String::from("SmallInt"),
        Datatype::Structure{id} => format!("Struct {}", id),
        Datatype::Ref(inner) => format!("Pointer to {}",inner),
      }   
   }

   pub fn get_id_of_referenced_struct(&self) -> String {
      match self {
         Datatype::Ref(inner) => {
            match &**inner {
               Datatype::Structure{id} => id.clone(),
               _ => panic!("Tried to get the structure id of {}, which isn't a structure", self)
            }  
         }
         _ => panic!("Tried to get what's pointed to by {}, which isn't a pointer", self),
      }
   }
}

#[derive(Debug,Clone)]
pub struct Decl { // i.e. "int count"
   pub id: String,
   pub datatype: Datatype,
}

#[derive(Debug,Clone)]
pub struct TypeDeclaration {  // i.e. structs
   pub id: String,
   pub decls: Vec<Decl>,
}
