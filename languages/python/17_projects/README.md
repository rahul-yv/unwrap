# Mini Project: Word Frequency Counter

A small CLI tool that reads a text file and reports the most common words — combining files/I/O (`10_files`), collections (`07_collections`), error handling (`09_errors`), and functions (`06_functions`) into one program.

## What it does

Given a text file, `top_words(path, n)`:
1. Reads the file (streaming, not loading unnecessarily).
2. Normalizes words (lowercase, strips punctuation).
3. Counts occurrences with `collections.Counter`.
4. Returns the `n` most common words with their counts.
5. Raises a clear `FileNotFoundError`-derived message if the path doesn't exist, rather than an unhandled traceback.

See [`example.py`](./example.py) for the full implementation.

## Design notes

- Word splitting uses `re.findall(r"[a-z']+", text.lower())` — a simple approach that's good enough for plain text; a real NLP tool would use a proper tokenizer for edge cases (contractions, hyphenation, unicode).
- The function takes a `path`, not raw text, to keep the file-reading concern separate from the counting logic — this also makes the counting logic trivially testable without touching the filesystem (see `test_word_frequency.py`).

## Exercise

Extend `top_words` into `top_words_excluding(path, n, stopwords)` that also accepts a set of stopwords (e.g. `{"the", "a", "and"}`) to exclude from the count, so common filler words don't dominate the results.

Try it yourself first, then check [`solutions/exercise_1.py`](./solutions/exercise_1.py).

---
← [Previous: Security](../16_security/README.md) | [Next: Interview Prep →](../18_interview/README.md)
