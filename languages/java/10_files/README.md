# Files and I/O

`java.nio.file.Files` (modern, since Java 7) is the preferred API for most file operations — simpler than the older `java.io.File`/streams for common cases like reading a whole file or all its lines. `Files.readString`/`Files.writeString` (Java 11+) cover the common "whole file as text" case in one call; `Files.lines` streams a file line by line for larger files.

## Example

```java
Path path = Path.of("notes.txt");
Files.writeString(path, "line one\nline two\n");

String content = Files.readString(path);
List<String> lines = Files.readAllLines(path);

try (Stream<String> stream = Files.lines(path)) {   // streaming, doesn't load it all into a List
	long count = stream.count();
}

Files.deleteIfExists(path);
```

See [`Example.java`](./Example.java) for the full runnable file.

## Common mistakes

1. **Using the older `FileReader`/`BufferedReader` boilerplate for simple whole-file reads** when `Files.readString`/`Files.readAllLines` does it in one line — the older streams API is still needed for genuinely large files or fine-grained control, but it's unnecessary ceremony for the common case.
2. **Forgetting `Files.lines` returns a `Stream` that must be closed** (it holds an open file handle) — always use it inside try-with-resources, unlike `Files.readAllLines` which reads everything and closes the file before returning.
3. **Not catching/declaring `IOException`.** Most `Files` methods declare `throws IOException` (a checked exception) — every caller must handle or propagate it, unlike languages where file errors are unchecked by default.
4. **Assuming a relative path resolves against the source file's location.** It resolves against the JVM's current working directory at runtime, which may not be where the `.java` file lives — use an absolute path or a path derived from a known base directory when location matters.

## Exercise

Write `long countLines(Path path) throws IOException` returning the number of lines in the file, using `Files.lines` inside try-with-resources (not `Files.readAllLines`, to practice the streaming form).

Try it yourself first, then check [`solutions/Exercise1.java`](./solutions/Exercise1.java).

## Interview questions

1. **Why must `Files.lines`'s result be used inside try-with-resources?** — It returns a lazily-evaluated `Stream` backed by an open file handle; unlike `Files.readAllLines` (which reads everything eagerly and closes the file immediately), the stream needs an explicit close to release that handle once you're done consuming it.
2. **Why does `IOException` being checked matter for API design?** — It forces every caller in the chain to either handle the error or explicitly declare that it can propagate, making I/O failure a visible part of a method's contract rather than an invisible possibility — the tradeoff other languages avoid with unchecked I/O errors.

---
← [Previous: Error Handling](../09_errors/README.md) | [Next: Modules and Packages →](../11_modules_packages/README.md)
