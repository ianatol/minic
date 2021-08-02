
pub mod cfg_builder;
mod cfg_pruner;
mod cfg_visitor;
pub mod code_generator;
pub mod arm_generator;

pub struct UniqueNameFactory {
    count: u32,
    base: String,
}

impl UniqueNameFactory {
    fn new(base:String) -> UniqueNameFactory {
        UniqueNameFactory {
            count: 0,
            base,
        }
    }

    fn next(&mut self) -> String {
        self.count += 1;
        // Generate a name like <func_name>_v<number>
        format!("{}{}",self.base,self.count)
    }
}


