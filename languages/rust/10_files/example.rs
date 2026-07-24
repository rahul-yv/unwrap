use std::fs;
use std::io::{BufRead, BufReader};

fn main() -> std::io::Result<()> {
    let path = std::env::temp_dir().join(format!("unwrap-rust-notes-{}.txt", std::process::id()));

    fs::write(&path, "line one\nline two\n")?;

    let content = fs::read_to_string(&path)?;
    assert_eq!(content, "line one\nline two\n");

    let file = fs::File::open(&path)?;
    let reader = BufReader::new(file);
    let mut lines = Vec::new();
    for line in reader.lines() {
        lines.push(line?);
    }
    assert_eq!(lines, vec!["line one".to_string(), "line two".to_string()]);

    let missing = std::env::temp_dir().join("unwrap-rust-definitely-missing.txt");
    let result = fs::read_to_string(&missing);
    assert!(result.is_err());

    fs::remove_file(&path)?;
    assert!(!path.exists());

    println!("ok");
    Ok(())
}
