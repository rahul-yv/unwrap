# Mini Project: Word Frequency Counter

The same tool as the other tracks' mini project, in PHP — reads a text file and reports the most common words, combining files/I/O (`10_files`), collections (`07_collections`), error handling (`09_errors`), and functions (`06_functions`). Pure standard library, no external package needed.

## What it does

`function topWords(string $path, int $n): array`:
1. Reads the file (`file_get_contents()`), returning `false` on failure — checked explicitly and converted into a thrown exception rather than silently propagating `false`.
2. Normalizes words (lowercase, strips punctuation) via a regex (`preg_match_all`) — PHP's PCRE support makes this simpler than the manual character-scan approach used in stdlib-only languages without regex.
3. Counts occurrences with an associative array.
4. Returns the `n` most common words as an associative array (word => count), sorted by count descending.

See [`example.php`](./example.php) for the full implementation.

## Design notes

- `function countWords(string $text): array` is a separate, testable-without-the-filesystem function from `topWords`, same separation as the other language tracks.
- Word splitting uses `preg_match_all('/[a-z\']+/', ...)` — PHP's built-in PCRE support means a regex is the natural, idiomatic choice here, unlike languages without stdlib regex that fall back to a manual character scan.

## Exercise

Extend the counter into `function topWordsExcluding(string $path, int $n, array $stopwords): array`.

Try it yourself first, then check [`solutions/exercise_1.php`](./solutions/exercise_1.php).

---
← [Previous: Security](../16_security/README.md) | [Next: Interview Prep →](../18_interview/README.md)
