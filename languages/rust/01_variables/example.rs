const MAX_RETRIES: u32 = 3;

fn main() {
    let age = 25;
    let mut count = 0;
    count += 1;
    assert_eq!(age, 25);
    assert_eq!(count, 1);

    let spaces = "   ";
    let spaces = spaces.len(); // shadowing: same name, new binding, new type
    assert_eq!(spaces, 3);

    assert_eq!(MAX_RETRIES, 3);

    let mut x = 5;
    assert_eq!(x, 5);
    x = 6; // mutation: same variable, same type
    assert_eq!(x, 6);

    println!("ok");
}
