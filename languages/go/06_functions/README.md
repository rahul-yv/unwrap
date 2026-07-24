# Functions

Go functions support multiple return values (used pervasively for the `(result, error)` pattern), named return values, variadic parameters, and closures. Functions are values — they can be assigned, passed, and returned like any other type.

## Example

```go
func divide(a, b float64) (float64, error) {
	if b == 0 {
		return 0, errors.New("division by zero")
	}
	return a / b, nil
}

func sum(nums ...int) int {   // variadic: accepts any number of ints
	total := 0
	for _, n := range nums {
		total += n
	}
	return total
}

func makeCounter() func() int {
	count := 0
	return func() int {        // closure: remembers `count` across calls
		count++
		return count
	}
}
```

See [`example.go`](./example.go) for the full runnable file.

## Common mistakes

1. **Ignoring the error return value.** `result, _ := riskyOperation()` silently discards a failure signal — Go's convention is to check `if err != nil` immediately after a call that can fail, not to assume it succeeded.
2. **Forgetting variadic parameters must come last**, and that a slice passed to a variadic parameter needs the `...` spread syntax: `sum(numbers...)`, not `sum(numbers)` (which is a type error for a `[]int` against `...int`).
3. **Returning a pointer to a local variable and worrying it's a dangling pointer** (a C/C++ habit) — Go's escape analysis automatically moves the variable to the heap if it outlives the function, so this is always safe in Go, unlike in C.
4. **Naming return values and then also using an explicit `return value`** inconsistently — named returns support a bare `return` that returns their current values, which is convenient but can obscure what's actually being returned if overused in a long function.

## Exercise

Write `makeCounter() func() int` returning a closure; each call to the returned function returns an incrementing count starting at 1.

Try it yourself first, then check [`solutions/exercise_1.go`](./solutions/exercise_1.go).

## Interview questions

1. **Why does Go favor `(result, error)` returns over exceptions?** — Makes error handling explicit and visible at every call site rather than an invisible control-flow path; the language designers consider this more honest about where failures can occur, at the cost of more verbose call sites (`if err != nil` everywhere).
2. **Is it safe to return a pointer to a local variable in Go?** — Yes — Go's compiler performs escape analysis and allocates the variable on the heap instead of the stack if it needs to outlive the function call, unlike C/C++ where this would be a dangling-pointer bug.

---
← [Previous: Loops](../05_loops/README.md) | Next: Collections (coming soon)
