fn swap(a: i32, b: i32) -> (i32, i32) {
    (b, a)
}

fn main() {
    assert_eq!(swap(1, 2), (2, 1));
    println!("ok");
}
