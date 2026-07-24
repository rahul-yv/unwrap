# Mini Project: Word Frequency Counter

The same tool as the Python and JavaScript tracks' mini project, in TypeScript — reads a text file and reports the most common words, now with types describing the data flowing through each step.

## What it does

`topWords(filePath: string, n: number): Promise<Array<[string, number]>>`:
1. Reads the file (`fs/promises`), typed as `string`.
2. Normalizes words with a regex, typed as `string[]`.
3. Counts occurrences with a `Map<string, number>`.
4. Returns the `n` most common words as typed `[string, number]` tuples, sorted descending by count.
5. Throws a typed `Error` if the file doesn't exist.

See [`example.ts`](./example.ts) for the full implementation.

## Design notes

- `countWords(text: string): Map<string, number>` is exported separately from `topWords`, so it's testable without touching the filesystem — same separation of concerns as the Python/JavaScript versions.
- The `[string, number]` tuple return type (rather than a looser `(string | number)[]`) means callers get `entry[0]` typed as `string` and `entry[1]` typed as `number` individually, without a cast.

## Exercise

Extend the counter into `topWordsExcluding(filePath: string, n: number, stopwords: Set<string>): Promise<Array<[string, number]>>`.

Try it yourself first, then check [`solutions/exercise_1.ts`](./solutions/exercise_1.ts).

---
← [Previous: Security](../16_security/README.md) | [Next: Interview Prep →](../18_interview/README.md)

