# Files and I/O

Dart's `dart:io` `File` class provides both `async` (`readAsString`, `writeAsString`) and synchronous (`readAsStringSync`, `writeAsStringSync`) variants for whole-file operations, plus streaming (`openRead`) for large files. The synchronous variants are simpler for scripts and small files; the async variants avoid blocking the event loop in a server or UI application.

## Example

```dart
import "dart:io";

final file = File("${Directory.systemTemp.path}/unwrap.txt");

file.writeAsStringSync("line one\nline two\n");

final content = file.readAsStringSync();
final lines = file.readAsLinesSync();   // ["line one", "line two"]

file.writeAsStringSync("line three\n", mode: FileMode.append);

int lineCount = 0;
for (final _ in file.readAsLinesSync()) {
	lineCount++;
}

file.deleteSync();
```

See [`example.dart`](./example.dart) for the full runnable file.

## Common mistakes

1. **Using the synchronous `File` API (`readAsStringSync`) in a server or Flutter UI context.** Blocking I/O calls freeze the event loop (or the UI thread in Flutter) while waiting — the async variants (`await file.readAsString()`) are required in those contexts to keep the app responsive; the sync API is fine for one-off scripts and command-line tools where blocking briefly doesn't matter.
2. **Reading an entire large file into memory with `readAsStringSync`/`readAsLinesSync`** when the file could be huge — `file.openRead()` returns a `Stream<List<int>>` that can be processed incrementally without holding the whole file in memory at once.
3. **Not handling a missing file.** `readAsStringSync()` throws a `PathNotFoundException`/`FileSystemException` if the file doesn't exist; either catch it or check `file.existsSync()` first, depending on whether "missing" is an expected case.
4. **Forgetting `writeAsStringSync` overwrites by default** — `mode: FileMode.append` is required to add to existing content rather than replacing it.

## Exercise

Write a function `int countLines(String path)` that returns the number of lines in the file at `path`, using `File(path).readAsLinesSync().length` or an equivalent streaming approach.

Try it yourself first, then check [`solutions/exercise_1.dart`](./solutions/exercise_1.dart).

## Interview questions

1. **Why does `dart:io`'s `File` class provide both sync and async variants of the same operations?** — The sync variants (`readAsStringSync`) block the calling isolate until the I/O completes — fine for short scripts where nothing else needs to run concurrently. The async variants (`readAsString`, returning a `Future`) don't block Dart's single-threaded event loop while waiting on I/O, letting other work (handling other requests, redrawing a UI) proceed — essential in servers and Flutter apps, where blocking the event loop would freeze the whole application.
2. **When would you use `file.openRead()` instead of `readAsStringSync`?** — `readAsStringSync`/`readAsLinesSync` load the entire file into memory before returning. `openRead()` returns a `Stream` that yields chunks of the file incrementally as they're read, letting you process a file far larger than available memory (or start processing before the whole file has even finished being read) without ever holding the complete contents at once.

---
← [Previous: Error Handling](../09_errors/README.md) | [Next: Modules and Packages →](../11_modules_packages/README.md)
