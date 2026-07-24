use std::collections::HashMap;

fn word_counts(words: &[&str]) -> HashMap<String, i32> {
    let mut counts = HashMap::new();
    for &word in words {
        *counts.entry(word.to_string()).or_insert(0) += 1;
    }
    counts
}

fn main() {
    let result = word_counts(&["a", "b", "a"]);
    assert_eq!(result.get("a"), Some(&2));
    assert_eq!(result.get("b"), Some(&1));
    println!("ok");
}
