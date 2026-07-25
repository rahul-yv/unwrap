# Mini Project: Word Frequency Counter

The same tool as the other tracks' mini project, in Dart — reads a text file and reports the most common words, combining files/I/O (`10_files`), collections (`07_collections`), error handling (`09_errors`), and functions (`06_functions`). Pure SDK, no external package needed.

## What it does

`List<MapEntry<String, int>> topWords(String path, int n)`:
1. Reads the file (`File(path).readAsStringSync()`), letting `PathNotFoundException` propagate naturally if the file is missing rather than swallowing it.
2. Normalizes and extracts words with `RegExp` on the lowercased text — Dart's built-in regex support (`dart:core`'s `RegExp`) makes this concise.
3. Counts occurrences with a `Map<String, int>`.
4. Returns the `n` most common words as a list of `MapEntry`, sorted by count descending.

See [`example.dart`](./example.dart) for the full implementation.

## Design notes

- `Map<String, int> countWords(String text)` is a separate, testable-without-the-filesystem function from `topWords`, same separation as the other language tracks.
- Word splitting uses `RegExp(r"[a-z']+").allMatches(...)`, matching sequences of letters and apostrophes — the same "letters and apostrophes" normalization pattern used across the other tracks.

## Exercise

Extend the counter into `List<MapEntry<String, int>> topWordsExcluding(String path, int n, Set<String> stopwords)`.

Try it yourself first, then check [`solutions/exercise_1.dart`](./solutions/exercise_1.dart).

---
← [Previous: Security](../16_security/README.md) | [Next: Interview Prep →](../18_interview/README.md)
