# Conditionals

Go's `if` doesn't require parentheses around the condition but does require braces, even for a single statement. `if` supports an initializer statement scoped to the `if`/`else` chain — the idiomatic way to check an error alongside using a value. `switch` doesn't fall through by default (the opposite of C/JavaScript) and can switch on no expression at all, acting as a cleaner `if`/`else if` chain.

## Example

```go
score := 85

if score >= 90 {
	fmt.Println("A")
} else if score >= 80 {
	fmt.Println("B")
} else {
	fmt.Println("C")
}

// if with an initializer, scoped to the if/else chain
if grade, ok := lookupGrade(score); ok {
	fmt.Println(grade)
}

switch {
case score >= 90:
	fmt.Println("A")
case score >= 80:
	fmt.Println("B")
default:
	fmt.Println("C")
}
```

See [`example.go`](./example.go) for the full runnable file.

## Common mistakes

1. **Expecting `switch` to fall through by default.** Unlike C/JavaScript, Go's `switch` cases don't fall through unless you explicitly write `fallthrough` — each case implicitly breaks after its body.
2. **Omitting braces for a single-statement `if`, expecting it to compile like C.** Go always requires `{ }` around the body, even for one statement — there's no brace-less single-line `if`.
3. **Using a variable declared in an `if`'s initializer outside the `if`/`else` block.** `if x := compute(); x > 0 { ... }` scopes `x` to the `if` and its `else` branches only — it doesn't exist after the block ends.
4. **Writing a long `if`/`else if` chain on a single value** instead of a tag-less `switch`, which reads more clearly for that specific pattern of "check several conditions on one thing in order."

## Exercise

Write `grade(score int) string` returning `"A"` for `score >= 90`, `"B"` for `>= 80`, `"C"` for `>= 70`, `"F"` otherwise, using a tag-less `switch`.

Try it yourself first, then check [`solutions/exercise_1.go`](./solutions/exercise_1.go).

## Interview questions

1. **Does Go's `switch` fall through between cases by default?** — No — the opposite of C/JavaScript; each case implicitly breaks, and you must write `fallthrough` explicitly to continue into the next case.
2. **What does an `if` statement's initializer clause do, and why is it idiomatic in Go?** — `if err := doSomething(); err != nil { ... }` scopes `err` to just the `if`/`else` block, keeping error-handling variables from leaking into the surrounding scope — a very common Go pattern given how pervasive explicit error returns are.

---
← [Previous: Operators](../03_operators/README.md) | [Next: Loops →](../05_loops/README.md)
