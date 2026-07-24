fn add(a: i32, b: i32) -> i32 {
    a + b
}

fn make_adder(n: i32) -> impl Fn(i32) -> i32 {
    move |x| x + n
}

fn takes_ownership(s: String) -> usize {
    s.len()
}

fn borrows(s: &String) -> usize {
    s.len()
}

fn main() {
    assert_eq!(add(2, 3), 5);

    let add_five = make_adder(5);
    assert_eq!(add_five(3), 8);
    assert_eq!(add_five(10), 15); // Fn closures can be called repeatedly

    let owned = String::from("hello");
    let borrowed_len = borrows(&owned);
    assert_eq!(borrowed_len, 5);
    assert_eq!(owned.len(), 5); // still usable: only borrowed

    let moved = String::from("world");
    let moved_len = takes_ownership(moved);
    assert_eq!(moved_len, 5);
    // moved.len() here would be a compile error: value used after move

    // FnMut: captures and mutates a variable across calls
    let mut count = 0;
    let mut increment = || {
        count += 1;
        count
    };
    assert_eq!(increment(), 1);
    assert_eq!(increment(), 2);

    println!("ok");
}
