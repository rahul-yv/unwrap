use std::collections::HashMap;
use std::fs;

fn top_words_excluding(
    path: &str,
    n: usize,
    stopwords: &[&str],
) -> std::io::Result<Vec<(String, i32)>> {
    let content = fs::read_to_string(path)?;
    let mut counts: HashMap<String, i32> = HashMap::new();
    let mut current = String::new();

    let flush = |word: &mut String, counts: &mut HashMap<String, i32>| {
        if !word.is_empty() {
            if !stopwords.contains(&word.as_str()) {
                *counts.entry(word.clone()).or_insert(0) += 1;
            }
            word.clear();
        }
    };

    for c in content.to_lowercase().chars() {
        if c.is_alphabetic() || c == '\'' {
            current.push(c);
        } else {
            flush(&mut current, &mut counts);
        }
    }
    flush(&mut current, &mut counts);

    let mut entries: Vec<(String, i32)> = counts.into_iter().collect();
    entries.sort_by(|a, b| b.1.cmp(&a.1));
    entries.truncate(n);
    Ok(entries)
}

fn main() {
    let path = std::env::temp_dir().join(format!("unwrap-rust-stop-{}.txt", std::process::id()));
    fs::write(&path, "the cat the dog the dog bird").unwrap();

    let result = top_words_excluding(path.to_str().unwrap(), 2, &["the"]).unwrap();
    assert_eq!(result, vec![("dog".to_string(), 2), ("cat".to_string(), 1)]);

    fs::remove_file(&path).unwrap();
    println!("ok");
}
