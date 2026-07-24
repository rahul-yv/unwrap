# Variables

Go is statically typed with type inference: `x := 5` infers `int`; `var x int = 5` is the explicit form, used mainly at package level or when you want a specific type the right-hand side wouldn't infer (e.g. `var x int64 = 5`). Every declared variable must be used, or the compiler refuses to build — unlike most languages, this is a hard compile error, not a lint warning.

## Example

```go
package main

import "fmt"

func main() {
	age := 25          // short declaration, type inferred as int
	var name string = "Ada"
	age = age + 1

	var count int // zero value: 0 (Go has no "undefined" — every type has a zero value)

	a, b := 1, 2 // multiple assignment
	a, b = b, a  // swap, no temp variable needed

	fmt.Println(age, name, count, a, b)
}
```

See [`example.go`](./example.go) for the full runnable file.

## Common mistakes

1. **Declaring a variable and never using it.** `x := 5` followed by never referencing `x` is a compile error (`declared and not used`), not a warning — Go enforces this to keep code free of dead variables. (Unused *imports* are the same: a hard compile error.)
2. **Assuming an uninitialized variable is `nil`/`undefined` for all types.** Every type has a zero value: `0` for numbers, `""` for strings, `false` for bools, `nil` only for pointers/slices/maps/channels/interfaces/functions. `var count int` is `0`, not some "unset" sentinel.
3. **Using `:=` when the variable already exists in the same scope**, expecting reassignment — `:=` declares a *new* variable; in the same scope with the same name it's a redeclaration error, but in a *new* scope (e.g. inside an `if`) it silently shadows the outer variable instead of reassigning it.
4. **Confusing `var x int` (declaration with zero value) with `x := 0` (short declaration with explicit value)** — functionally similar for simple cases, but `:=` requires being inside a function (not valid at package level) and can't be used to just declare a type without a value.

## Exercise

Write a function `swap(a, b int) (int, int)` that returns `b, a` using Go's multiple-return-value swap idiom, not a temporary variable.

Try it yourself first, then check [`solutions/exercise_1.go`](./solutions/exercise_1.go).

## Interview questions

1. **What is a "zero value" in Go, and why does the language have this concept instead of `null`/`undefined`?** — Every type has a default value assigned automatically when a variable is declared without an initializer (`0`, `""`, `false`, `nil` for reference-like types); this avoids an entire class of "uninitialized variable" bugs since a variable is always in a valid, usable state.
2. **Why does Go make unused variables and imports a compile error?** — A deliberate language design choice to keep codebases free of dead code and stale imports, catching mistakes (like a leftover debug variable or a half-finished refactor) at compile time rather than letting them accumulate silently.

---
← Previous: (start) | [Next: Data Types →](../02_datatypes/README.md)
