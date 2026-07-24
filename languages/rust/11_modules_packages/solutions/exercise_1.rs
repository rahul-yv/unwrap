mod mypackage {
    pub fn greet(name: &str) -> String {
        format!("Hello, {}!", name)
    }
}

fn example_usage() -> String {
    mypackage::greet("World")
}

fn main() {
    assert_eq!(example_usage(), "Hello, World!");
    println!("ok");
}
