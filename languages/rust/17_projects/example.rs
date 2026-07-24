use std::collections::HashMap;
use std::fs;

fn count_words(text: &str) -> HashMap<String, i32> {
    let mut counts = HashMap::new();
    let mut current = String::new();

    for c in text.to_lowercase().chars() {
        if c.is_alphabetic() || c == '\'' {
            current.push(c);
        } else if !current.is_empty() {
            *counts.entry(current.clone()).or_insert(0) += 1;
            current.clear();
        }
    }
    if !current.is_empty() {
        *counts.entry(current).or_insert(0) += 1;
    }

    counts
}

fn top_words(path: &str, n: usize) -> std::io::Result<Vec<(String, i32)>> {
    let content = fs::read_to_string(path)?;
    let counts = count_words(&content);

    let mut entries: Vec<(String, i32)> = counts.into_iter().collect();
    entries.sort_by(|a, b| b.1.cmp(&a.1));
    entries.truncate(n);
    Ok(entries)
}

fn main() {
    let counts = count_words("The cat sat. The cat ran!");
    assert_eq!(counts.get("the"), Some(&2));
    assert_eq!(counts.get("cat"), Some(&2));

    let path = std::env::temp_dir().join(format!("unwrap-rust-story-{}.txt", std::process::id()));
    let path_str = path.to_str().unwrap();
    fs::write(&path, "dog dog cat bird dog cat").unwrap();

    let top = top_words(path_str, 2).unwrap();
    assert_eq!(top, vec![("dog".to_string(), 3), ("cat".to_string(), 2)]);

    let missing = std::env::temp_dir().join("unwrap-rust-missing.txt");
    let result = top_words(missing.to_str().unwrap(), 2);
    assert!(result.is_err());

    fs::remove_file(&path).unwrap();

    println!("ok");
}
