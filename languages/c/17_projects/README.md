# Mini Project: Word Frequency Counter

The same tool as the other tracks' mini project, in C — reads a text file and counts word occurrences. In C this exposes the manual work the other languages hide: there's no built-in string-splitting, no growable hash map, no dictionary. This version keeps it dependency-free by using a small fixed-capacity array of `{word, count}` structs with a linear scan — a deliberate simplification appropriate for a teaching example, with the tradeoffs called out below.

## What it does

`int count_words(const char *text, WordCount *entries, int max_entries)`:
1. Scans the text character by character, accumulating letters into a word buffer (lowercased), treating anything else as a separator.
2. For each completed word, looks it up in the `entries` array (linear scan) and increments its count, or adds a new entry.
3. Returns the number of distinct words found (capped at `max_entries`).

See [`example.c`](./example.c) for the full implementation.

## Design notes

- Uses a fixed-capacity `WordCount entries[]` with linear lookup — O(n·m) for n words and m distinct words. Fine for a small teaching example; a real implementation would use a hash table (which C doesn't provide, so you'd build or import one — see how much `07_collections` and this project have to do by hand that other languages give for free).
- Word length and distinct-word count are bounded by fixed buffer sizes, with explicit bounds checks — no dynamic growth, keeping the memory management trivial and the focus on the counting logic.
- Reading the file into a buffer and the counting logic are kept separate, so `count_words` is testable on an in-memory string without touching the filesystem — the same separation as the other language tracks.

## Exercise

Add `int most_frequent(const WordCount *entries, int count)` returning the index of the entry with the highest count (first one wins ties), or `-1` if `count` is 0.

Try it yourself first, then check [`solutions/exercise_1.c`](./solutions/exercise_1.c).

---
← [Previous: Security](../16_security/README.md) | [Next: Interview Prep →](../18_interview/README.md)
