# Files and I/O

Kotlin's standard library adds concise extension functions on top of Java's `java.io.File` — `readText()`, `writeText()`, `readLines()`, `forEachLine` — replacing multi-line `BufferedReader`/`FileWriter` boilerplate with single calls. `use { }` (Kotlin's equivalent of Java's try-with-resources) closes a `Closeable` resource automatically, even if an exception is thrown.

## Example

```kotlin
import java.io.File

val file = File.createTempFile("unwrap", ".txt")
file.writeText("line one\nline two\n")

val content = file.readText()
val lines = file.readLines()               // ["line one", "line two"]

file.appendText("line three\n")

file.bufferedReader().use { reader ->       // use{} closes the reader automatically
	reader.forEachLine { line -> /* process line */ }
}

file.delete()
```

See [`example.kt`](./example.kt) for the full runnable file.

## Common mistakes

1. **Opening a stream/reader without `use { }` and forgetting to close it.** An unclosed file handle leaks a resource; `use { }` guarantees `close()` is called even if the block throws, the same guarantee Java's try-with-resources gives.
2. **Reading an entire large file into memory with `readText()`/`readLines()`** when the file could be huge — `forEachLine` (or a `Sequence` via `useLines`) processes line by line without holding the whole file in memory at once.
3. **Not handling a missing file.** `File(path).readText()` throws `FileNotFoundException` if the file doesn't exist; check `file.exists()` first, or catch the exception, depending on whether "missing" is an expected case.
4. **Forgetting `writeText()` overwrites the file** rather than appending — use `appendText()` to add to existing content instead of replacing it.

## Exercise

Write a function `fun countLines(path: String): Int` that returns the number of lines in the file at `path`, using `forEachLine` (not reading the whole file into a list first).

Try it yourself first, then check [`solutions/exercise_1.kt`](./solutions/exercise_1.kt).

## Interview questions

1. **What does `use { }` do, and why does it matter for file I/O?** — It's Kotlin's equivalent of Java's try-with-resources: it calls `close()` on the `Closeable` receiver when the block finishes, whether normally or via an exception, so a file handle or stream is never left open due to a forgotten `close()` call or an early return/exception.
2. **When would you use `forEachLine`/`useLines` instead of `readLines()`?** — `readLines()` reads the entire file into a `List<String>` in memory before returning; `forEachLine`/`useLines` process the file line by line as a stream, never holding more than one line (plus buffering) in memory at once — important for files too large to comfortably fit in memory, or when processing can stop early.

---
← [Previous: Error Handling](../09_errors/README.md) | [Next: Modules and Packages →](../11_modules_packages/README.md)
