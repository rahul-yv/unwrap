# Mini Project: Word Frequency Counter

The same tool as the other tracks' mini project, in Swift — reads a text file and reports the most common words, combining files/I/O (`10_files`), collections (`07_collections`), error handling (`09_errors`), and functions (`06_functions`). Pure Foundation, no external package needed.

## What it does

`func topWords(path: String, n: Int) throws -> [(word: String, count: Int)]`:
1. Reads the file (`String(contentsOfFile:encoding:)`), letting it throw naturally if the file is missing rather than swallowing the error.
2. Normalizes words (lowercase, strips punctuation) — a manual character scan, since regex would work too but this keeps the same "no dependency needed" shape as the other tracks.
3. Counts occurrences with a `[String: Int]` dictionary.
4. Returns the `n` most common words as an array of tuples, sorted by count descending.

See [`example.swift`](./example.swift) for the full implementation.

## Design notes

- `func countWords(_ text: String) -> [String: Int]` is a separate, testable-without-the-filesystem function from `topWords`, same separation as the other language tracks.
- Word splitting is a hand-rolled character scan (`Character.isLetter` plus manual buffering) rather than `NSRegularExpression`, keeping the same "letters and apostrophes" pattern used elsewhere without pulling in more than the essentials.

## Exercise

Extend the counter into `func topWordsExcluding(path: String, n: Int, stopwords: Set<String>) throws -> [(word: String, count: Int)]`.

Try it yourself first, then check [`solutions/exercise_1.swift`](./solutions/exercise_1.swift).

---
← [Previous: Security](../16_security/README.md) | [Next: Interview Prep →](../18_interview/README.md)
