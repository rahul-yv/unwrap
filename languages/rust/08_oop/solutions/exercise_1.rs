#[derive(PartialEq)]
struct Rectangle {
    width: f64,
    height: f64,
}

impl Rectangle {
    fn area(&self) -> f64 {
        self.width * self.height
    }
}

fn main() {
    let r = Rectangle {
        width: 3.0,
        height: 4.0,
    };
    assert_eq!(r.area(), 12.0);

    let r2 = Rectangle {
        width: 3.0,
        height: 4.0,
    };
    assert!(r == r2);

    println!("ok");
}
