enum Shape {
    Circle(f64),
    Square(f64),
}

fn area(shape: &Shape) -> f64 {
    match shape {
        Shape::Circle(radius) => std::f64::consts::PI * radius * radius,
        Shape::Square(side) => side * side,
    }
}

fn main() {
    let circle = Shape::Circle(2.0);
    let square = Shape::Square(3.0);

    assert!((area(&circle) - std::f64::consts::PI * 4.0).abs() < 1e-9);
    assert_eq!(area(&square), 9.0);

    let maybe_number: Option<i32> = Some(5);
    let mut found = None;
    if let Some(n) = maybe_number {
        found = Some(n);
    }
    assert_eq!(found, Some(5));

    let nothing: Option<i32> = None;
    let mut ran_else = false;
    if let Some(_) = nothing {
        // does not run
    } else {
        ran_else = true;
    }
    assert!(ran_else);

    // match as an expression
    let score = 85;
    let grade = match score {
        90..=100 => "A",
        80..=89 => "B",
        70..=79 => "C",
        _ => "F",
    };
    assert_eq!(grade, "B");

    println!("ok");
}
