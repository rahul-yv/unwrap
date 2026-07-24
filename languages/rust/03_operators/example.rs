fn main() {
    let score = 85;

    let label = if score >= 60 { "pass" } else { "fail" };
    assert_eq!(label, "pass");

    let q = 7 / 2;
    let r = 7 % 2;
    assert_eq!(q, 3);
    assert_eq!(r, 1);

    let exclusive: Vec<i32> = (0..3).collect();
    assert_eq!(exclusive, vec![0, 1, 2]);

    let inclusive: Vec<i32> = (0..=3).collect();
    assert_eq!(inclusive, vec![0, 1, 2, 3]);

    // if as an expression, both branches must produce the same type
    let category = if score >= 90 {
        "A"
    } else if score >= 80 {
        "B"
    } else {
        "C"
    };
    assert_eq!(category, "B");

    println!("ok");
}
