fn clamp(value: i32, low: i32, high: i32) -> i32 {
    value.max(low).min(high)
}

fn main() {
    assert_eq!(clamp(5, 0, 10), 5);
    assert_eq!(clamp(-5, 0, 10), 0);
    assert_eq!(clamp(15, 0, 10), 10);
    println!("ok");
}
