# Loops

Swift has `for-in` (iterating over any `Sequence`, including ranges and `stride`) and `while`/`repeat-while` — no C-style `for (;;)` loop (removed in Swift 3). Ranges (`0..<5`, `0...5`, `stride(from:to:by:)`) cover that need. Labeled `break`/`continue` (`outer: for ... { break outer }`) let a nested loop control an outer one.

## Example

```swift
for i in 0..<5 {
	// 0, 1, 2, 3, 4
}

for i in stride(from: 5, through: 1, by: -2) {
	// 5, 3, 1
}

let items = ["a", "b", "c"]
for (index, value) in items.enumerated() {
	// (0, "a"), (1, "b"), (2, "c")
}

var count = 0
while count < 3 {
	count += 1
}

outer: for i in 0..<3 {
	for j in 0..<3 {
		if j == 1 { continue outer }   // labeled continue: skip to the next i
	}
}
```

See [`example.swift`](./example.swift) for the full runnable file.

## Common mistakes

1. **Reaching for an index-based loop when `.enumerated()` or a `for item in collection` loop is clearer.** Swift idioms favor iterating over elements directly (or `.enumerated()` when the index is genuinely needed) over manual indexing.
2. **Forgetting `stride`'s `by:` sign must match the direction** (`stride(from: 5, through: 1, by: -2)` needs a negative step going downward) — a positive step with a descending range produces an empty sequence, not a runtime error, which can silently skip a loop entirely.
3. **Using an unlabeled `break`/`continue` inside nested loops and expecting it to affect the outer loop.** An unlabeled `break`/`continue` only affects the innermost enclosing loop — a label is needed to affect an outer loop from inside a nested one.
4. **Off-by-one errors from confusing `..<` (half-open) and `...` (closed)**, especially when translating a bound like "loop `n` times" — `0..<n` gives exactly `n` iterations; `0...n` gives `n + 1`.

## Exercise

Write a function `func sumEvens(_ n: Int) -> Int` that returns the sum of all even numbers from `0` to `n` inclusive, using `stride(from:through:by:)`.

Try it yourself first, then check [`solutions/exercise_1.swift`](./solutions/exercise_1.swift).

## Interview questions

1. **Why doesn't Swift have a C-style `for (int i = 0; i < n; i++)` loop?** — It was removed in Swift 3 in favor of ranges and `stride`, which express the same iteration patterns declaratively (and are themselves `Sequence`s, so `for-in` covers them) without the error-prone manual increment/condition bookkeeping the three-part loop required.
2. **What does a labeled break/continue do, and when is it needed?** — By default, `break`/`continue` affects only the innermost loop it's directly inside. A label (`outer: for ... { ... }`) lets `break outer`/`continue outer` from a nested loop affect the labeled outer loop instead — needed when a nested loop needs to abort or skip the outer iteration based on something found inside it.

---
← [Previous: Conditionals](../04_conditions/README.md) | [Next: Functions →](../06_functions/README.md)
