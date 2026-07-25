# Mini Project: Word Frequency Counter

The same tool as the other tracks' mini project, in Kotlin — reads a text file and reports the most common words, combining files/I/O (`10_files`), collections (`07_collections`), error handling (`09_errors`), and functions (`06_functions`). Pure stdlib, no external package needed.

## What it does

`fun topWords(path: String, n: Int): List<Pair<String, Int>>`:
1. Reads the file (`File(path).readText()`), letting a missing file throw `FileNotFoundException` naturally rather than swallowing it.
2. Normalizes words (lowercase, strips punctuation) — a manual character scan, since regex would work too but this keeps the same "no dependency needed" shape as the other tracks.
3. Counts occurrences with a `MutableMap<String, Int>`.
4. Returns the `n` most common words as a `List<Pair<String, Int>>`, sorted by count descending.

See [`example.kt`](./example.kt) for the full implementation.

## Design notes

- `fun countWords(text: String): Map<String, Int>` is a separate, testable-without-the-filesystem function from `topWords`, same separation as the other language tracks.
- Word splitting is a hand-rolled character scan (`Char.isLetter()` plus manual buffering) rather than `Regex.findAll`, keeping the same "letters and apostrophes" pattern used elsewhere without pulling in more than the essentials.

## Exercise

Extend the counter into `fun topWordsExcluding(path: String, n: Int, stopwords: Set<String>): List<Pair<String, Int>>`.

Try it yourself first, then check [`solutions/exercise_1.kt`](./solutions/exercise_1.kt).

---
← [Previous: Security](../16_security/README.md) | [Next: Interview Prep →](../18_interview/README.md)
