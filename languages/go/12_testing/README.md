# Testing

Go's testing support is built into the toolchain: no external framework needed. A file named `xxx_test.go` alongside the code it tests, containing `func TestXxx(t *testing.T)` functions, is picked up automatically by `go test`. `t.Errorf` records a failure and continues the test; `t.Fatalf` records a failure and stops that test immediately.

## Example

```go
// example.go
package main

func Add(a, b int) int {
	return a + b
}
```

```go
// example_test.go
package main

import "testing"

func TestAddPositive(t *testing.T) {
	if got := Add(2, 3); got != 5 {
		t.Errorf("Add(2, 3) = %d, want 5", got)
	}
}
```

Run with `go test ./...`. See [`example.go`](./example.go) and [`example_test.go`](./example_test.go) for the full runnable files.

## Common mistakes

1. **Using `t.Fatalf` when the test should keep checking other conditions**, or `t.Errorf` when a failed precondition means the rest of the test can't meaningfully continue — `Fatalf` stops immediately (via `runtime.Goexit`), `Errorf` marks failure but keeps running, letting later checks in the same test still report.
2. **Not using table-driven tests for multiple similar cases**, instead copy-pasting near-identical test functions — Go's idiom is a slice of `{input, want}` structs looped with `t.Run(name, func(t *testing.T) {...})` for named subtests.
3. **Forgetting `go test` only picks up files ending in `_test.go`** — a typo like `example_tests.go` (extra `s`) is silently ignored, and the "tests" never actually run.
4. **Testing unexported behavior from a different package** — test files in the same directory can access unexported (lowercase) identifiers because they share the package; a test in a different package only sees exported names, same visibility rule as regular code.

## Exercise

Write a test file with a `TestAdd` function (table-driven, using `t.Run` for named subtests) checking `Add(0, 0) == 0` and `Add(-1, 1) == 0`.

Try it yourself first, then check [`solutions/exercise_1_test.go`](./solutions/exercise_1_test.go).

## Interview questions

1. **What's the difference between `t.Errorf` and `t.Fatalf`?** — Both mark the test as failed; `t.Errorf` lets the test function continue running (useful for reporting multiple independent failures in one run), while `t.Fatalf` stops the current test function immediately.
2. **What is a table-driven test, and why is it idiomatic in Go?** — A slice of test cases (input + expected output) iterated in a loop, usually with `t.Run` for named subtests — avoids duplicating near-identical test function bodies and gives each case an individually reportable name/result.

---
← [Previous: Modules and Packages](../11_modules_packages/README.md) | Next: Networking (coming soon)
