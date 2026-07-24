# Files and I/O

`std::fs` covers file operations; `fs::read_to_string`/`fs::write` handle the common "whole file as text" case in one call, both returning `io::Result<T>` (a `Result` with `io::Error`). For line-by-line reading of larger files, wrap a `File` in a `BufReader` and use `.lines()`.

## Example

```rust
use std::fs;
use std::io::{BufRead, BufReader};

fs::write("notes.txt", "line one\nline two\n")?;

let content = fs::read_to_string("notes.txt")?;

let file = std::fs::File::open("notes.txt")?;
let reader = BufReader::new(file);
for line in reader.lines() {
	let line = line?;   // each line is itself an io::Result<String>
	println!("{}", line);
}

fs::remove_file("notes.txt")?;
```

See [`example.rs`](./example.rs) for the full runnable file.

## Common mistakes

1. **Reading a large file entirely with `fs::read_to_string`** when the task only needs to process it line by line — `BufReader::lines()` streams instead of holding the whole file in memory.
2. **Forgetting each line from `BufReader::lines()` is itself a `Result<String, io::Error>`**, not a plain `String` — a read error partway through the file surfaces per-line, and needs its own `?`/handling, not just the file-open step's.
3. **Not propagating `io::Error` with `?` and instead unwrapping everywhere**, turning every I/O hiccup (a very normal occurrence — missing files, permission errors) into a panic instead of a handleable `Result`.
4. **Assuming a relative path resolves relative to the source file.** Like most compiled languages, it resolves against the process's current working directory at runtime, not where the `.rs` file lives.

## Exercise

Write `fn count_lines(path: &str) -> std::io::Result<usize>` returning the number of lines in the file, using `BufReader::lines()`.

Try it yourself first, then check [`solutions/exercise_1.rs`](./solutions/exercise_1.rs).

## Interview questions

1. **Why does `BufReader::lines()` yield `Result<String, io::Error>` per line instead of just `String`?** — Each line read is itself a fallible I/O operation; wrapping it in `Result` lets a read error at any point in the stream be reported precisely, rather than only detecting failure once at the start.
2. **What's the benefit of `BufReader` over reading a `File` directly?** — `BufReader` reduces the number of actual system calls by reading larger chunks into an internal buffer and serving smaller reads (like line-by-line) from that buffer — reading a `File` directly one line at a time without buffering would make a syscall per read, which is much slower.

---
← [Previous: Error Handling](../09_errors/README.md) | [Next: Modules and Packages →](../11_modules_packages/README.md)

