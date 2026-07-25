# Mini Project: Word Frequency Counter

The same tool as the other tracks' mini project, in C++ — and a striking contrast with the C version: what took ~75 lines of manual buffer management and a hand-rolled struct array in C is a dozen lines here, because the STL (`std::unordered_map`, `std::string`, streams) provides the containers and string handling directly.

## What it does

`std::unordered_map<std::string, int> count_words(const std::string& text)`:
1. Reads whitespace-delimited tokens from the text (via a `std::istringstream`).
2. Normalizes each (lowercase, strips non-alphabetic characters).
3. Counts occurrences in an `unordered_map`.

Plus `top_words(...)` that reads a file, counts, and returns the `n` most frequent as a sorted `std::vector<std::pair<std::string, int>>`.

See [`example.cpp`](./example.cpp) for the full implementation.

## Design notes

- `count_words` takes a `std::string` (in-memory text), keeping it testable without touching the filesystem — the file reading lives separately in `top_words`, the same separation as the other tracks.
- The ranking step uses `std::sort` with a comparator on the map entries copied into a `std::vector` — idiomatic STL, no manual sorting.
- Normalization strips non-alphabetic characters with `std::isalpha` and lowercases with `std::tolower` — no manual character-classification loop like C needed.

## Exercise

Add `std::optional<std::pair<std::string, int>> most_frequent(const std::unordered_map<std::string, int>& counts)` returning the most frequent word and its count, or `std::nullopt` if the map is empty.

Try it yourself first, then check [`solutions/exercise_1.cpp`](./solutions/exercise_1.cpp).

---
← [Previous: Security](../16_security/README.md) | [Next: Interview Prep →](../18_interview/README.md)
