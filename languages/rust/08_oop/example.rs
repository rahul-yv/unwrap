trait Speaker {
    fn speak(&self) -> String;
}

struct Dog {
    name: String,
}

impl Dog {
    fn new(name: &str) -> Self {
        Dog {
            name: name.to_string(),
        }
    }
}

impl Speaker for Dog {
    fn speak(&self) -> String {
        format!("{} says Woof", self.name)
    }
}

#[derive(PartialEq, Debug)]
struct Point {
    x: i32,
    y: i32,
}

fn main() {
    let dog = Dog::new("Rex");
    assert_eq!(dog.speak(), "Rex says Woof");

    let speakers: Vec<Box<dyn Speaker>> = vec![Box::new(Dog::new("Rex")), Box::new(Dog::new("Fido"))];
    let messages: Vec<String> = speakers.iter().map(|s| s.speak()).collect();
    assert_eq!(messages, vec!["Rex says Woof", "Fido says Woof"]);

    let p1 = Point { x: 3, y: 4 };
    let p2 = Point { x: 3, y: 4 };
    assert_eq!(p1, p2); // derived PartialEq compares by field value

    println!("ok");
}
