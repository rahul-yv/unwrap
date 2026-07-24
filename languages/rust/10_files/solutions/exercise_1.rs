use std::fs;
use std::io::{BufRead, BufReader};

fn count_lines(path: &str) -> std::io::Result<usize> {
    let file = fs::File::open(path)?;
    let reader = BufReader::new(file);
    let mut count = 0;
    for line in reader.lines() {
        line?;
        count += 1;
    }
    Ok(count)
}

fn main() -> std::io::Result<()> {
    let path = std::env::temp_dir().join(format!("unwrap-rust-count-{}.txt", std::process::id()));
    fs::write(&path, "a\nb\nc\n")?;

    assert_eq!(count_lines(path.to_str().unwrap())?, 3);

    fs::remove_file(&path)?;
    println!("ok");
    Ok(())
}
