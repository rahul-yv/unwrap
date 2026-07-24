fn count_chars(s: &str) -> usize {
    s.chars().count()
}

fn main() {
    assert_eq!(count_chars("héllo"), 5);
    assert_eq!(count_chars("hello"), 5);
    println!("ok");
}
