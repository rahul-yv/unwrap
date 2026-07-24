# Mini Project: Word Frequency Counter

The same tool as the Python, JavaScript, and TypeScript tracks' mini project, in Go — reads a text file and reports the most common words, combining files/I/O (`10_files`), collections (`07_collections`), error handling (`09_errors`), and functions (`06_functions`).

## What it does

`topWords(path string, n int) ([]WordCount, error)`:
1. Reads the file (`os.ReadFile`).
2. Normalizes words (lowercase, strips punctuation) with `regexp`.
3. Counts occurrences with a `map[string]int`.
4. Returns the `n` most common words as a sorted `[]WordCount`.
5. Returns a wrapped error if the file doesn't exist, rather than a bare `os` error with no context.

See [`example.go`](./example.go) for the full implementation.

## Design notes

- `countWords(text string) map[string]int` is a separate function from `topWords`, so the counting logic is testable without touching the filesystem — same separation as the other language tracks.
- `WordCount` is a small named struct (`{Word string; Count int}`) rather than returning `[][2]any` or similar — Go favors a named type over an untyped tuple-like structure for a return value with meaning attached to each field.

## Exercise

Extend the counter into `topWordsExcluding(path string, n int, stopwords map[string]bool) ([]WordCount, error)`.

Try it yourself first, then check [`solutions/exercise_1.go`](./solutions/exercise_1.go).

---
← [Previous: Security](../16_security/README.md) | [Next: Interview Prep →](../18_interview/README.md)
