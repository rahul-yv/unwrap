# Mini Project: Word Frequency Counter

The same tool as the other tracks' mini project, in C# — reads a text file and reports the most common words, combining files/I/O (`10_files`), collections (`07_collections`), error handling (`09_errors`), and functions (`06_functions`). Pure BCL, no external package needed.

## What it does

`List<(string Word, int Count)> TopWords(string path, int n)`:
1. Reads the file (`File.ReadAllText`), letting a missing file throw `FileNotFoundException` naturally rather than swallowing it.
2. Normalizes words (lowercase, strips punctuation) — a manual character scan, since regex would work too but this keeps the same "no dependency needed" shape as the other tracks.
3. Counts occurrences with a `Dictionary<string, int>`.
4. Returns the `n` most common words as a `List<(string, int)>`, sorted by count descending (via LINQ's `OrderByDescending`).

See [`example.cs`](./example.cs) for the full implementation.

## Design notes

- `Dictionary<string, int> CountWords(string text)` is a separate, testable-without-the-filesystem function from `TopWords`, same separation as the other language tracks.
- Word splitting is a hand-rolled character scan (`char.IsLetter` plus manual buffering) rather than `Regex.Matches`, keeping the same "letters and apostrophes" pattern used elsewhere without pulling in more than the essentials.

## Exercise

Extend the counter into `List<(string Word, int Count)> TopWordsExcluding(string path, int n, IReadOnlySet<string> stopwords)`.

Try it yourself first, then check [`solutions/exercise_1.cs`](./solutions/exercise_1.cs).

---
← [Previous: Security](../16_security/README.md) | [Next: Interview Prep →](../18_interview/README.md)
