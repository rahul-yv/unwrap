# Files and I/O

PHP has straightforward file functions built in: `file_get_contents()`/`file_put_contents()` for whole-file reads/writes, and `fopen()`/`fgets()`/`fclose()` for streaming line-by-line access. Most of these return `false` on failure rather than throwing — PHP's file I/O predates its exception system, so checking return values (or wrapping calls to convert warnings into exceptions) matters more here than in most other topics.

## Example

```php
<?php
$path = tempnam(sys_get_temp_dir(), "unwrap");

file_put_contents($path, "line one\nline two\n");

$content = file_get_contents($path);
$lines = file($path, FILE_IGNORE_NEW_LINES);   // ["line one", "line two"]

file_put_contents($path, "line three\n", FILE_APPEND);

$handle = fopen($path, "r");
while (($line = fgets($handle)) !== false) {
	// process $line
}
fclose($handle);

unlink($path);
```

See [`example.php`](./example.php) for the full runnable file.

## Common mistakes

1. **Not checking `file_get_contents()`/`fopen()`'s return value for `false`.** Both return `false` (with a warning, not an exception) on failure — a missing file, permissions issue, etc. — silently treating `false` as valid content produces confusing downstream errors instead of a clear failure at the source.
2. **Reading an entire large file into memory with `file_get_contents()`/`file()`** when the file could be huge — `fopen()`/`fgets()` (or `SplFileObject` for an object-oriented iterator) process line by line without holding the whole file in memory at once.
3. **Forgetting `file_put_contents()` overwrites by default** — the `FILE_APPEND` flag is required to add to existing content instead of replacing it.
4. **Not calling `fclose()` after `fopen()`** (or relying on the script ending to release it) — for short scripts this is harmless since PHP cleans up on exit, but in long-running processes or loops opening many files, leaked file handles accumulate.

## Exercise

Write a function `function countLines(string $path): int` that returns the number of lines in the file at `$path`, using `fopen`/`fgets` (not reading the whole file into an array first).

Try it yourself first, then check [`solutions/exercise_1.php`](./solutions/exercise_1.php).

## Interview questions

1. **Why does checking PHP's file I/O return values matter more than in languages with exceptions for I/O errors?** — Functions like `file_get_contents()` and `fopen()` predate PHP's exception system and signal failure by returning `false` plus emitting a warning (not throwing), rather than throwing a catchable error. Code that doesn't explicitly check for `false` will silently propagate it as if it were valid data, producing a confusing failure far from the actual cause — unlike languages where a failed I/O call throws immediately at the source.
2. **When would you use `fopen`/`fgets` instead of `file_get_contents`/`file()`?** — `file_get_contents`/`file()` read the entire file into memory (as a string or array of lines) before returning — simple, but memory use scales with file size. `fopen`/`fgets` stream the file line by line, holding only the current line (plus buffering) in memory at once — necessary for files too large to comfortably load entirely, or when processing might stop early.

---
← [Previous: Error Handling](../09_errors/README.md) | [Next: Modules and Packages →](../11_modules_packages/README.md)
