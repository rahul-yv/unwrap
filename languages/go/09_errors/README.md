# Error Handling

Go treats errors as ordinary values, not exceptions — a function that can fail returns `(result, error)`, and the caller checks `if err != nil` explicitly. `panic`/`recover` exist for truly exceptional, unrecoverable situations (a programming bug, not an expected failure mode) and are rarely used for normal control flow. `errors.New`/`fmt.Errorf` create errors; `%w` wraps one error inside another while preserving the chain for `errors.Is`/`errors.As`.

## Example

```go
var ErrNotFound = errors.New("not found")

func findUser(id int) (string, error) {
	if id != 1 {
		return "", fmt.Errorf("findUser(%d): %w", id, ErrNotFound)  // wraps ErrNotFound
	}
	return "Ada", nil
}

name, err := findUser(2)
if errors.Is(err, ErrNotFound) {
	// handle the "not found" case specifically, even though the message was wrapped
}
```

See [`example.go`](./example.go) for the full runnable file.

## Common mistakes

1. **Ignoring an error return with `_`** (`result, _ := riskyOp()`) — Go doesn't force you to handle errors the way exceptions force a `catch` somewhere; silently discarding one is easy and a common source of bugs.
2. **Comparing wrapped errors with `==` instead of `errors.Is`.** `fmt.Errorf("...: %w", ErrNotFound)` produces a *new* error value; `err == ErrNotFound` is `false` even though it wraps `ErrNotFound` — `errors.Is` walks the wrap chain correctly.
3. **Using `panic` for ordinary, expected failure conditions** (like "file not found" or "invalid input") — that's what error returns are for; `panic` is reserved for programmer errors and truly unrecoverable states, and unhandled panics crash the program.
4. **Recovering from a panic and silently swallowing it** without logging or re-evaluating whether the program is still in a valid state — `recover()` stops the crash, but the code that panicked may have left things half-done.

## Exercise

Write `safeDivide(a, b float64) (float64, error)` returning an error (not panicking) when `b == 0`, using `errors.New`.

Try it yourself first, then check [`solutions/exercise_1.go`](./solutions/exercise_1.go).

## Interview questions

1. **Why does Go prefer explicit `(result, error)` returns over exceptions?** — Makes every failure point visible in the code (`if err != nil` at each fallible call), trading verbosity for an error-handling path that's impossible to silently skip past by accident, unlike an uncaught exception propagating invisibly.
2. **What's the difference between `errors.Is` and a plain `==` comparison?** — `errors.Is` unwraps a chain of wrapped errors (created with `%w`) looking for a match at any level; `==` only compares the exact error value, which fails once an error has been wrapped in a new one.

---
← [Previous: OOP](../08_oop/README.md) | [Next: Files and I/O →](../10_files/README.md)
