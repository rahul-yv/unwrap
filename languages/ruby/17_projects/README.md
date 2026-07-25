# Mini Project: Word Frequency Counter

The same tool as the other tracks' mini project, in Ruby — reads a text file and reports the most common words, combining files/I/O (`10_files`), collections (`07_collections`), error handling (`09_errors`), and functions (`06_functions`). Pure standard library, no external gem needed.

## What it does

`def top_words(path, n)`:
1. Reads the file (`File.read`), letting `Errno::ENOENT` propagate naturally if the file is missing rather than swallowing it.
2. Normalizes and extracts words with `.scan(/[a-z']+/)` on the downcased text — Ruby's built-in regex support makes this a one-liner, unlike stdlib-only languages without regex.
3. Counts occurrences with `Hash.new(0)` (a hash with a default value of `0`, so `counts[word] += 1` works without a separate existence check) via `.tally` or manual counting.
4. Returns the `n` most common words as an array of `[word, count]` pairs, sorted by count descending.

See [`example.rb`](./example.rb) for the full implementation.

## Design notes

- `def count_words(text)` is a separate, testable-without-the-filesystem method from `top_words`, same separation as the other language tracks.
- `.tally` (added in Ruby 2.7) is `Enumerable`'s built-in "count occurrences" method — `words.tally` returns exactly the `{word => count}` hash this project needs, in one call, without a manual accumulator loop.

## Exercise

Extend the counter into `def top_words_excluding(path, n, stopwords)`.

Try it yourself first, then check [`solutions/exercise_1.rb`](./solutions/exercise_1.rb).

---
← [Previous: Security](../16_security/README.md) | [Next: Interview Prep →](../18_interview/README.md)
