# Mini Project: Word Frequency Counter

The same tool as the other tracks' mini project, in Rust — reads a text file and reports the most common words, combining files/I/O (`10_files`), collections (`07_collections`), error handling (`09_errors`), and functions (`06_functions`). Pure stdlib, no external crate needed.

## What it does

`top_words(path: &str, n: usize) -> std::io::Result<Vec<(String, i32)>>`:
1. Reads the file (`fs::read_to_string`).
2. Normalizes words (lowercase, strips punctuation) — a simple manual scan, since regex isn't in stdlib.
3. Counts occurrences with a `HashMap<String, i32>`.
4. Returns the `n` most common words as a sorted `Vec<(String, i32)>`.
5. Propagates a real `io::Error` (via `?`) if the file doesn't exist.

See [`example.rs`](./example.rs) for the full implementation.

## Design notes

- `count_words(text: &str) -> HashMap<String, i32>` is a separate, testable-without-the-filesystem function from `top_words`, same separation as the other language tracks.
- Word splitting here is a hand-rolled character scan rather than a regex crate — `regex` isn't in stdlib, and for this simple "letters and apostrophes" pattern, `char::is_alphabetic` plus manual buffering is enough without pulling in a dependency.

## Exercise

Extend the counter into `top_words_excluding(path: &str, n: usize, stopwords: &[&str]) -> std::io::Result<Vec<(String, i32)>>`.

Try it yourself first, then check [`solutions/exercise_1.rs`](./solutions/exercise_1.rs).

---
← [Previous: Security](../16_security/README.md) | [Next: Interview Prep →](../18_interview/README.md)

