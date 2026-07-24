fn main() {
    let n: i32 = 10;
    let big: i64 = 10_000_000_000;
    let pi: f64 = 3.14159;
    let c: char = 'A';
    assert_eq!(n, 10);
    assert_eq!(big, 10_000_000_000);
    assert!((pi - 3.14159).abs() < 1e-9);
    assert_eq!(c, 'A');

    let borrowed: &str = "hello";
    let owned: String = String::from("hello");
    assert_eq!(borrowed, owned);

    let combined = owned + " world";
    assert_eq!(combined, "hello world");

    // char is a 4-byte Unicode scalar value, not a byte
    let word = "héllo";
    assert_eq!(word.len(), 6); // byte length: é is 2 bytes in UTF-8
    assert_eq!(word.chars().count(), 5); // character count

    // integer overflow panics in debug builds
    let max: u8 = u8::MAX;
    let result = max.checked_add(1);
    assert_eq!(result, None); // checked_add returns None instead of panicking or wrapping

    let wrapped = max.wrapping_add(1);
    assert_eq!(wrapped, 0); // wrapping_add explicitly wraps

    println!("ok");
}
