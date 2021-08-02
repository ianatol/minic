use std::rc::Rc;

// A context manager (i.e. nested symbol tables) with each table as a vector

// Use an enum that describes all of the types associated with the identifiers. 
// In other words, our tuples are going to be (String,_what_?)
use super::ast::Datatype;


#[derive(Clone,Debug)]
pub struct Context {
    head : Option<Rc<(String,Datatype,Context)>>,
}

impl Context {
    pub fn new() -> Context { Context{ head:None }}

    pub fn new_with_parent(parent:&Context) -> Context {
        match &parent.head {
            None => Context::new(),
            Some(rctuple) => Context{ head:Some(Rc::clone(rctuple)) },
        }
    }

    pub fn get_var_type(&self, id:&str) -> Result<Datatype,String> {
        // println!("get_var_type: Looking for {}",id);
        match &self.head {
            None => Err(format!("Variable {} not found",id)),
            Some(rctuple) => {
                println!(" Checking against {}:{}",rctuple.0,rctuple.1);
                if *rctuple.0 == *id {
                    println!("  It's a match. Returning {}", rctuple.1);
                    Ok(Datatype::clone(&rctuple.1))
                } else {
                    (rctuple.2).get_var_type(id)
                }
            }
        }
    }

    pub fn insert(&mut self, id:String, id_type:&Datatype) {
        match &self.head {
            None => self.head = Some(Rc::new((id,id_type.clone(),Context { head: None }))),
            Some(inner_rc) => self.head = Some(Rc::new((id,id_type.clone(), Context { head: Some(Rc::clone(&inner_rc))}))),
        }
    }

}

impl ToString for Context {
    fn to_string(&self) -> String {
        match &self.head {
            None => String::new(),
            Some(rctuple) => {
                let id:String = String::clone(&rctuple.0);
                let typename = rctuple.1.get_name();
                let mut rest:String = rctuple.2.to_string();
                if rest.len() > 0 {
                rest.push_str(", ");
                }
                rest.push_str(&id);
                rest.push_str(":");
                rest.push_str(&typename);
                rest
            }
        }
    }
}

#[test]
fn context_list_lookup_x() {
    let mut c = super::context_list::Context::new();
    c.insert(String::from("x"), &Datatype::Int);
    assert_eq!(c.get_var_type("x"), Ok(Datatype::Int));
}

#[test]
fn context_list_lookup_missing() {
    let mut c = super::context_list::Context::new();
    c.insert(String::from("x"), &Datatype::Int);
    assert_eq!(c.get_var_type("y"), Err(String::from("Variable y not found")));
}

#[test]
fn context_list_lookup_shadowed() {
    let mut c1 = super::context_list::Context::new();
    c1.insert(String::from("x"), &Datatype::Int);
    let mut c2 = super::context_list::Context::new_with_parent(&c1);
    c2.insert(String::from("x"), &Datatype::Bool);
    assert_eq!(c2.get_var_type("x"), Ok(Datatype::Bool));
}