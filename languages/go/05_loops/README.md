# Loops

Go has exactly one loop keyword — `for` — that covers every loop shape other languages split across `for`/`while`/`do-while`: the classic three-clause form, a condition-only form (equivalent to `while`), an infinite form, and `for...range` for iterating collections.

## Example

```go
for i := 0; i < 3; i++ {
	fmt.Println(i)          // classic three-clause form
}

n := 0
for n < 3 {                  // condition-only form, equivalent to `while`
	n++
}

for {                         // infinite loop
	break                     // must break/return explicitly to exit
}

for i, v := range []string{"a", "b", "c"} {
	fmt.Println(i, v)         // index, value
}

for i := range 5 {             // range over an int (Go 1.22+): 0, 1, 2, 3, 4
	fmt.Println(i)
}
```

See [`example.go`](./example.go) for the full runnable file.

## Common mistakes

1. **Looking for a `while` or `do-while` keyword.** There isn't one — `for condition { }` is the `while` equivalent, and there's no direct `do-while`; simulate it with `for { ...; if !condition { break } }`.
2. **Capturing the loop variable in a goroutine closure, expecting each to see its own value** — before Go 1.22, `for _, v := range items { go func() { use(v) } () }` shared one `v` across all goroutines (same class of bug as JavaScript's `var` in closures); Go 1.22+ gives each iteration its own `v`, but older code (or code targeting an older Go version) needs to shadow it explicitly (`v := v`) inside the loop body.
3. **Modifying a slice while ranging over it** and expecting the range to reflect the changes — `range` evaluates the slice's length once at the start; appending during iteration doesn't extend the loop, and removing elements shifts indices under you.
4. **Using the range value for large structs when only the index is needed**, copying each element unnecessarily — `for i := range items` (index only) avoids the copy when you don't need the value itself.

## Exercise

Write `sum(numbers []int) int` that adds up all the numbers using a `for...range` loop.

Try it yourself first, then check [`solutions/exercise_1.go`](./solutions/exercise_1.go).

## Interview questions

1. **Why does Go have only one loop keyword instead of `for`/`while`/`do-while`?** — A deliberate simplicity choice: `for` in its different forms (three-clause, condition-only, infinite, range) covers every case, so the language doesn't need multiple keywords for the same underlying construct.
2. **What changed about loop variable capture in Go 1.22?** — Before 1.22, all iterations of a `for` loop shared the same loop variable instance, so closures created inside the loop (e.g. in goroutines) captured the final value, not each iteration's value; Go 1.22 made each iteration get its own fresh variable, matching the intuitive expectation (and JavaScript's `let` behavior).

---
← [Previous: Conditionals](../04_conditions/README.md) | [Next: Functions →](../06_functions/README.md)
