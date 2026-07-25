# Files and I/O

C#'s `System.IO` namespace handles files. `File` provides one-call helpers for the common cases: `File.WriteAllText`/`ReadAllText`, `File.ReadAllLines`, `File.ReadLines` (lazy/streaming). For streaming, `StreamReader`/`StreamWriter` wrap a file and are `IDisposable`, so a `using` statement guarantees they're flushed and closed. Async variants (`ReadAllTextAsync`, etc.) exist for non-blocking I/O.

## Example

```csharp
using System.IO;

File.WriteAllText("notes.txt", "line one\nline two\n");

string content = File.ReadAllText("notes.txt");
string[] lines = File.ReadAllLines("notes.txt");

// File.ReadLines is lazy — streams line by line without loading the whole file
foreach (string line in File.ReadLines("notes.txt")) {
	Console.WriteLine(line);
}

// StreamReader with a using declaration: disposed (closed) automatically
using var reader = new StreamReader("notes.txt");
string? first = reader.ReadLine();
```

See [`example.cs`](./example.cs) for the full runnable file.

## Common mistakes

1. **Using `File.ReadAllLines` (loads everything into an array) when `File.ReadLines` (lazy streaming) is enough** for large files — `ReadAllLines` holds the whole file in memory; `ReadLines` yields lines one at a time.
2. **Not disposing a `StreamReader`/`StreamWriter`.** These hold an OS file handle; without disposal (via `using` or explicit `.Dispose()`), the file stays open and buffered writes may not be flushed — `using` handles both automatically.
3. **Not handling the exceptions file operations can throw** — `FileNotFoundException`, `UnauthorizedAccessException`, `IOException` — file I/O routinely fails (missing file, permissions, disk full); wrap it in `try`/`catch` (or check `File.Exists` first, accepting the small race window).
4. **Blocking on synchronous file I/O in an async context** (like a web request handler) where the `...Async` variants would free the thread — fine for scripts and CLIs, but worth knowing the async methods exist for scalable server code.

## Exercise

Write `int CountLines(string path)` returning the number of lines in the file, or `-1` if it doesn't exist (use `File.Exists` and `File.ReadLines`).

Try it yourself first, then check [`solutions/exercise_1.cs`](./solutions/exercise_1.cs).

## Interview questions

1. **What's the difference between `File.ReadAllLines` and `File.ReadLines`?** — `ReadAllLines` reads the entire file into a `string[]` up front (simple, but holds it all in memory); `ReadLines` returns a lazily-enumerated `IEnumerable<string>` that reads and yields one line at a time as you iterate — more memory-efficient for large files and allows short-circuiting (e.g. stop after finding a match without reading the rest).
2. **Why wrap a `StreamReader`/`StreamWriter` in a `using` statement?** — They implement `IDisposable` and hold an OS file handle (plus a write buffer); the `using` guarantees `Dispose()` runs at scope exit — flushing any buffered data and releasing the handle — even if an exception occurs, avoiding leaked handles and lost writes.

---
← [Previous: Error Handling](../09_errors/README.md) | [Next: Modules and Packages →](../11_modules_packages/README.md)
