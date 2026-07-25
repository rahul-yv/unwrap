# Files and I/O

Ruby's `File` class provides both convenience class methods (`File.read`, `File.write`) for whole-file operations and instance-based streaming (`File.open`/`.each_line`/`.close`) for line-by-line processing. `File.open` with a block automatically closes the file when the block ends, even if an exception is raised — Ruby's version of try-with-resources/RAII for file handles.

## Example

```ruby
path = File.join(Dir.tmpdir, "unwrap.txt")

File.write(path, "line one\nline two\n")

content = File.read(path)
lines = File.readlines(path, chomp: true)   # ["line one", "line two"]

File.write(path, "line three\n", mode: "a")   # "a": append instead of overwrite

File.open(path) do |file|                     # block form: closes automatically
  file.each_line { |line| }
end

File.delete(path)
```

See [`example.rb`](./example.rb) for the full runnable file.

## Common mistakes

1. **Opening a file without the block form and forgetting to close it.** `f = File.open(path); ...; f.close` requires remembering the `close` call on every exit path, including exceptions; `File.open(path) { |f| ... }` guarantees the file is closed automatically when the block ends, whether normally or via an exception — always prefer it.
2. **Reading an entire large file into memory with `File.read`/`File.readlines`** when the file could be huge — `File.open(path) { |f| f.each_line { |line| ... } }` processes line by line without holding the whole file in memory at once.
3. **Not handling a missing file.** `File.read` raises `Errno::ENOENT` if the file doesn't exist; either rescue it or check `File.exist?` first, depending on whether "missing" is an expected case.
4. **Forgetting `File.write` overwrites by default** — the `mode: "a"` option is required to append rather than replace existing content.

## Exercise

Write a method `def count_lines(path)` that returns the number of lines in the file at `path`, using `File.open` and `.each_line` (not reading the whole file into an array first).

Try it yourself first, then check [`solutions/exercise_1.rb`](./solutions/exercise_1.rb).

## Interview questions

1. **Why does `File.open` with a block guarantee the file gets closed, even if an exception is raised inside the block?** — `File.open`'s block form wraps the block execution so that `close` is called in an `ensure`-equivalent, regardless of whether the block completes normally, returns early, or an exception propagates out of it — the same underlying pattern as `ensure` in `begin`/`rescue`, applied automatically by the method itself so callers don't have to write it.
2. **When would you use `File.open`/`.each_line` instead of `File.read`/`File.readlines`?** — `File.read`/`File.readlines` load the entire file into memory (as a string or array of lines) before returning — simple, but memory use scales with file size. `.each_line` streams the file line by line, holding only the current line (plus buffering) in memory at once — necessary for files too large to comfortably load entirely, or when processing might stop early.

---
← [Previous: Error Handling](../09_errors/README.md) | [Next: Modules and Packages →](../11_modules_packages/README.md)
