# Loops

Kotlin has `for` (iterating over anything `Iterable`, including ranges) and `while`/`do-while` — there's no C-style `for (int i = 0; ...)` loop; ranges (`0..9`, `0 until 10`, `9 downTo 0`, `0..10 step 2`) cover that need. Labeled breaks/continues (`outer@ for (...) { ... break@outer }`) let you control an outer loop from a nested one.

## Example

```kotlin
for (i in 0 until 5) {
	// 0, 1, 2, 3, 4
}

for (i in 5 downTo 1 step 2) {
	// 5, 3, 1
}

val items = listOf("a", "b", "c")
for ((index, value) in items.withIndex()) {
	// (0, "a"), (1, "b"), (2, "c")
}

var count = 0
while (count < 3) {
	count++
}

outer@ for (i in 0 until 3) {
	for (j in 0 until 3) {
		if (j == 1) continue@outer   // labeled continue: skip to the next i
	}
}
```

See [`example.kt`](./example.kt) for the full runnable file.

## Common mistakes

1. **Reaching for an index-based loop when `withIndex()` or a `for (item in collection)` loop is clearer.** Kotlin idioms favor iterating over elements directly (or `withIndex()` when the index is genuinely needed) over C-style manual indexing.
2. **Forgetting `step` must be positive, even in a `downTo` loop.** `5 downTo 1 step -2` is a runtime error — the step's sign is implied by `downTo` vs `..`/`until`; always write a positive step value.
3. **Using an unlabeled `break`/`continue` inside nested loops and expecting it to affect the outer loop.** An unlabeled `break`/`continue` only affects the innermost enclosing loop — a labeled one (`outer@`, `break@outer`) is needed to affect an outer loop from inside a nested one.
4. **Off-by-one errors from confusing `..` (inclusive) and `until` (exclusive)**, especially when translating a bound like "loop `n` times" — `0 until n` gives exactly `n` iterations; `0..n` gives `n + 1`.

## Exercise

Write a function `fun sumEvens(n: Int): Int` that returns the sum of all even numbers from `0` to `n` inclusive, using a range with `step`.

Try it yourself first, then check [`solutions/exercise_1.kt`](./solutions/exercise_1.kt).

## Interview questions

1. **Why doesn't Kotlin have a C-style `for (int i = 0; i < n; i++)` loop?** — Ranges (`0 until n`, `0..n`, `n downTo 0`, with an optional `step`) express the same iteration patterns declaratively and are themselves `Iterable`, so `for (i in range)` covers what the three-part C-style loop does, without the error-prone manual increment/condition bookkeeping.
2. **What does a labeled break/continue do, and when is it needed?** — By default, `break`/`continue` affects only the innermost loop it's directly inside. A label (`outer@ for (...) { ... }`) lets `break@outer`/`continue@outer` from a nested loop affect the labeled outer loop instead — needed when a nested loop needs to abort or skip the outer iteration based on something found inside it.

---
← [Previous: Conditionals](../04_conditions/README.md) | [Next: Functions →](../06_functions/README.md)
