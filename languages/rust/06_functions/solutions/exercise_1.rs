fn make_counter() -> impl FnMut() -> i32 {
    let mut count = 0;
    move || {
        count += 1;
        count
    }
}

fn main() {
    let mut counter = make_counter();
    assert_eq!(counter(), 1);
    assert_eq!(counter(), 2);
    assert_eq!(counter(), 3);

    let mut other = make_counter();
    assert_eq!(other(), 1); // independent state

    println!("ok");
}
