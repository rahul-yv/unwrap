# Files and I/O

`os` and `io` provide low-level file access; `os.ReadFile`/`os.WriteFile` cover the common "whole file at once" case in one call. For line-by-line streaming, `bufio.Scanner` wraps a reader and avoids loading a large file into memory at once. `defer file.Close()` right after a successful `os.Open` is the idiomatic way to guarantee cleanup.

## Example

```go
err := os.WriteFile("notes.txt", []byte("line one\nline two\n"), 0644)

file, err := os.Open("notes.txt")
if err != nil {
	// handle error
}
defer file.Close()   // runs when the enclosing function returns, however it returns

scanner := bufio.NewScanner(file)
for scanner.Scan() {
	line := scanner.Text()
	fmt.Println(line)
}
```

See [`example.go`](./example.go) for the full runnable file.

## Common mistakes

1. **Forgetting `defer file.Close()` right after checking the `Open` error.** Skipping it (or closing manually at the end of a long function) risks leaking the file handle if an early `return` happens somewhere in between — `defer` right after the open guarantees cleanup regardless of how the function exits.
2. **Checking `scanner.Err()` never**, missing a read error that stopped the scan early — `Scan()` returns `false` both at EOF and on an error; check `scanner.Err()` after the loop to distinguish them.
3. **Loading an entire large file with `os.ReadFile`** when the task only needs to process it line by line — `bufio.Scanner` streams instead of holding the whole file in memory.
4. **Not checking the error from `os.WriteFile`/`file.Close()`.** A `Close()` on a written file can fail (e.g. a deferred write flush failing) — ignoring that return value can silently lose data in rare cases.

## Exercise

Write `countLines(path string) (int, error)` returning the number of lines in a text file, using `bufio.Scanner`.

Try it yourself first, then check [`solutions/exercise_1.go`](./solutions/exercise_1.go).

## Interview questions

1. **Why put `defer file.Close()` immediately after the `Open` call instead of at the end of the function?** — Guarantees the file is closed on every exit path (early return, panic) between the open and the function's end — deferring right after acquiring the resource is the idiomatic Go pattern for this class of cleanup.
2. **How does `bufio.Scanner` avoid loading a whole file into memory?** — It reads and buffers data incrementally as `Scan()` is called, handing back one token (line, by default) at a time, rather than reading the entire file up front like `os.ReadFile` does.

---
← [Previous: Error Handling](../09_errors/README.md) | [Next: Modules and Packages →](../11_modules_packages/README.md)
