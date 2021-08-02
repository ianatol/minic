
use std::collections::HashSet;

#[derive(Clone,Debug)]
pub struct InterferenceGraph {
    pub edges:HashSet<InterferenceEdge>,
    pub nodes:HashSet<String>
}

impl std::fmt::Display for InterferenceGraph {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        for edge in &self.edges {
            write!(f, "{}, ", edge);
        }
        Ok(())
    }
}

impl InterferenceGraph {
    pub fn new() -> Self {
        InterferenceGraph {
            edges:HashSet::new(),
            nodes:HashSet::new()
        }
    }

    pub fn add_node(&mut self, node:&str) {
        self.nodes.insert(node.to_string());
    }

    pub fn add_edge(&mut self, node1:&str, node2:&str) {
        if ! self.nodes.contains(node1) {
            panic!("Can't add an edge between {} and {} because {0} doesn't exist", node1, node2);
        }        
        if ! self.nodes.contains(node2) {
            panic!("Can't add an edge between {} and {} because {0} doesn't exist", node1, node2);
        }        
        let edge = InterferenceEdge::new(node1,node2);
        // println!("New edge : {:?}", edge);
        // println!("Graph before : {}", self);
        self.edges.insert(edge);
        // println!("Graph after : {}", self);
    }

    // Removes all edges involving node_id and returns them
    pub fn remove_node_and_edges(&mut self, node_id:&str) -> HashSet<InterferenceEdge> {
        let mut new_edges:HashSet<InterferenceEdge> = self.edges.clone();
        new_edges.retain(|edge| ! edge.contains_node(node_id));
        let removed_edges:HashSet<InterferenceEdge> = self.edges.difference(&new_edges).cloned().collect();
        self.edges = new_edges;
        self.nodes.remove(node_id);
        removed_edges
    }

    pub fn all_nodes(&self) -> HashSet<String> {
        self.nodes.clone()
    }

    pub fn get_unconstrained_nodes(&self, colors:usize) -> HashSet<String> {
        let mut nodes:HashSet<String> = HashSet::new();
        for node_id in &self.all_nodes() {
            if self.get_edge_count(node_id) < colors {
                nodes.insert(node_id.clone());
            }
        }
        nodes
    }

    pub fn get_nodes_connected_to(&self, node_id:&str) -> HashSet<String> {
        let mut connected:HashSet<String> = HashSet::new();
        for edge in &self.edges {
            if edge.node1 == node_id {
                connected.insert(edge.node2.clone());
            }
            if edge.node2 == node_id {
                connected.insert(edge.node1.clone());
            }
        }
        connected        
    }

    pub fn get_edge_count(&self, node_id:&str) -> usize {
        self.get_nodes_connected_to(node_id).len()
    }
}

#[derive(Clone,Debug,Eq,Hash)]
pub struct InterferenceEdge {
    pub node1:String,
    pub node2:String
}

impl InterferenceEdge {
    fn new(node1:&str, node2:&str) -> Self {
        if node1 == node2 {
            panic!("Please don't add an edge from {} to itself", node1);
        }
        if node1 < node2 {
            InterferenceEdge{
                node1:node1.to_string(),
                node2:node2.to_string(),
            }
        } else {
            InterferenceEdge{
                node1:node2.to_string(),
                node2:node1.to_string(),
            }
        }        
    }

    fn contains_node(&self, node_id:&str) -> bool {
        self.node1 == node_id || self.node2 == node_id
    }
}

impl PartialEq for InterferenceEdge {
    fn eq(&self, other: &Self) -> bool {
        ( self.node1 == other.node1 && self.node2 == other.node2 ) ||
        ( self.node1 == other.node2 && self.node2 == other.node1 )
    }
}

impl std::fmt::Display for InterferenceEdge {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(f, "({}, {})", self.node1, self.node2)
    }
}
