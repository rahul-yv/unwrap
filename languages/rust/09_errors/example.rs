fn divide(a: f64, b: f64) -> Result<f64, String> {
    if b == 0.0 {
        return Err("division by zero".to_string());
    }
    Ok(a / b)
}

fn compute() -> Result<f64, String> {
    let result = divide(10.0, 2.0)?;
    Ok(result * 2.0)
}

fn compute_failing() -> Result<f64, String> {
    let result = divide(10.0, 0.0)?; // propagates the Err immediately
    Ok(result * 2.0)
}

fn main() {
    assert_eq!(divide(10.0, 2.0), Ok(5.0));
    assert_eq!(divide(10.0, 0.0), Err("division by zero".to_string()));

    assert_eq!(compute(), Ok(10.0));
    assert_eq!(compute_failing(), Err("division by zero".to_string()));

    match divide(10.0, 0.0) {
        Ok(_) => panic!("expected an error"),
        Err(e) => assert_eq!(e, "division by zero"),
    }

    let maybe: Option<i32> = None;
    assert_eq!(maybe.unwrap_or(0), 0);

    println!("ok");
}
