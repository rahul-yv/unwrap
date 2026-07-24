# Mini Project: Word Frequency Counter

The same small tool as the Python track's mini project, in JavaScript — reads a text file and reports the most common words, combining files/I/O (`10_files`), collections (`07_collections`), error handling (`09_errors`), and functions (`06_functions`).

## What it does

`topWords(filePath, n)`:
1. Reads the file (`fs/promises`).
2. Normalizes words (lowercase, strips punctuation) with a regex.
3. Counts occurrences with a `Map`.
4. Returns the `n` most common words as `[word, count]` pairs, sorted descending by count.
5. Throws a clear error if the file doesn't exist, rather than letting a raw `ENOENT` propagate unexplained.

See [`example.js`](./example.js) for the full implementation.

## Design notes

- Word splitting uses `text.toLowerCase().match(/[a-z']+/g)` — good enough for plain text, not a real tokenizer.
- `topWords` takes a `filePath`, not raw text, keeping file-reading separate from counting — `countWords(text)` is exported separately and is trivially testable without touching the filesystem.

## Exercise

Extend the counter into `topWordsExcluding(filePath, n, stopwords)`, accepting a `Set` of stopwords (e.g. `new Set(["the", "a", "and"])`) to exclude from the count.

Try it yourself first, then check [`solutions/exercise_1.js`](./solutions/exercise_1.js).

---
← [Previous: Security](../16_security/README.md) | [Next: Interview Prep →](../18_interview/README.md)
