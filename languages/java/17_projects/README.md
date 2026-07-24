# Mini Project: Word Frequency Counter

The same tool as the other tracks' mini project, in Java — reads a text file and reports the most common words, combining files/I/O (`10_files`), collections (`07_collections`), error handling (`09_errors`), and functions (`06_functions`).

## What it does

`topWords(Path path, int n)`:
1. Reads the file (`Files.readString`).
2. Normalizes words (lowercase, strips punctuation) with a regex.
3. Counts occurrences with a `Map<String, Integer>`.
4. Returns the `n` most common words as a `List<Map.Entry<String, Integer>>`, sorted descending by count.
5. Throws a clear `IOException`-derived message if the file doesn't exist (via the checked exception JDBC/files APIs already surface).

See [`Example.java`](./Example.java) for the full implementation.

## Design notes

- `countWords(String text)` is a separate, testable-without-the-filesystem method from `topWords`, same separation as the other language tracks.
- Uses the `Stream` API (`entrySet().stream().sorted(...).limit(n)`) for the ranking step — idiomatic modern Java for this kind of transform-and-limit pipeline.

## Exercise

Extend the counter into `topWordsExcluding(Path path, int n, Set<String> stopwords)`.

Try it yourself first, then check [`solutions/Exercise1.java`](./solutions/Exercise1.java).

---
← [Previous: Security](../16_security/README.md) | [Next: Interview Prep →](../18_interview/README.md)
