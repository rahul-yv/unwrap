# Files and I/O

Swift's `String` type has built-in file I/O initializers/methods (`String(contentsOfFile:encoding:)`, `.write(toFile:atomically:encoding:)`), and `FileManager` handles file-system operations (checking existence, deleting, listing directories). Both throw on failure — following the `throws`/`try` pattern from the previous topic — rather than returning a sentinel or crashing.

## Example

```swift
import Foundation

let path = NSTemporaryDirectory() + "unwrap.txt"

try "line one\nline two\n".write(toFile: path, atomically: true, encoding: .utf8)

let content = try String(contentsOfFile: path, encoding: .utf8)
let lines = content.split(separator: "\n").map(String.init)   // ["line one", "line two"]

let existing = try String(contentsOfFile: path, encoding: .utf8)
try (existing + "line three\n").write(toFile: path, atomically: true, encoding: .utf8)

try FileManager.default.removeItem(atPath: path)
```

See [`example.swift`](./example.swift) for the full runnable file.

## Common mistakes

1. **Forgetting file I/O calls throw, and not using `try`/`do-catch`.** A missing file, permissions issue, or encoding mismatch surfaces as a thrown error, not a crash or a silent empty result — always handle or explicitly propagate it.
2. **Reading an entire large file into memory with `String(contentsOfFile:)`** when the file could be huge — `FileHandle`/`InputStream` process data incrementally without holding the whole file in memory at once, at the cost of more manual bookkeeping.
3. **Forgetting `write(toFile:atomically:encoding:)` overwrites the file** rather than appending — there's no built-in "append" convenience on `String`; appending means reading the existing content, concatenating, and writing the whole thing back (as in the example), or using a lower-level `FileHandle` for true incremental appends.
4. **Not checking `FileManager.default.fileExists(atPath:)` before an operation that assumes the file is there**, when "missing" is an expected, common case rather than an exceptional one — catching the resulting error works, but an existence check up front can be clearer when that's the natural flow.

## Exercise

Write a function `func countLines(_ path: String) throws -> Int` that returns the number of lines in the file at `path`.

Try it yourself first, then check [`solutions/exercise_1.swift`](./solutions/exercise_1.swift).

## Interview questions

1. **Why do Swift's file I/O functions use `throws` instead of returning `nil`/a sentinel on failure?** — A file operation can fail for several distinct reasons (missing file, permissions, encoding mismatch, disk error) — `throws` lets the specific reason propagate as a typed error, which `catch` can inspect, rather than collapsing every failure into a single `nil`/empty result that loses that information.
2. **How would you process a very large file without loading it entirely into memory?** — Use `FileHandle` or `InputStream` to read in fixed-size chunks (or line by line via a buffered read loop), processing each chunk before reading the next, rather than `String(contentsOfFile:)`, which loads the complete file into memory as a single `String` before any processing can begin.

---
← [Previous: Error Handling](../09_errors/README.md) | [Next: Modules and Packages →](../11_modules_packages/README.md)
