# Conditionals

`if`/`else` is an **expression** in Kotlin, not just a statement — it evaluates to a value, so `val x = if (cond) a else b` replaces the ternary operator many languages have separately. `when` is Kotlin's pattern-matching switch: it can match values, ranges, types (with smart-casting), or arbitrary boolean conditions, and — like `if` — can be used as an expression.

## Example

```kotlin
val age = 20
val category = if (age < 13) "child" else if (age < 20) "teen" else "adult"

val x = 5
val description = when {
	x < 0 -> "negative"
	x == 0 -> "zero"
	x % 2 == 0 -> "positive even"
	else -> "positive odd"
}

fun describe(value: Any): String = when (value) {
	is Int -> "an Int: $value"          // smart-cast: value is Int inside this branch
	is String -> "a String of length ${value.length}"
	null -> "null"
	else -> "something else"
}
```

See [`example.kt`](./example.kt) for the full runnable file.

## Common mistakes

1. **Forgetting `when` used as an expression must be exhaustive.** If `when` is used as a statement (its result is discarded), no `else` is required; if used as an expression (assigned to a value or returned), the compiler requires an `else` branch (or, for a `when` over a `sealed class`, covering all subtypes) so every possible input produces a value.
2. **Writing nested `if`/`else if` chains where a `when` block would be clearer** — `when` without a subject (as in the `description` example) reads as a cleaner sequence of independent conditions than a long `if`/`else if` chain.
3. **Not taking advantage of `when`'s smart-casting with `is`.** Inside a `when (value) { is String -> ... }` branch, `value` is automatically cast to `String` for that branch — no separate `as String` cast needed, unlike a manual `instanceof`-then-cast pattern.
4. **Comparing floating-point values for exact equality in a condition** (`if (x == 0.3)`) — the same rounding-error trap as any language; compare against a small tolerance instead when the value comes from computation rather than a literal.

## Exercise

Write a function `fun grade(score: Int): String` returning `"A"` for 90+, `"B"` for 80-89, `"C"` for 70-79, and `"F"` otherwise, using `when` with range conditions.

Try it yourself first, then check [`solutions/exercise_1.kt`](./solutions/exercise_1.kt).

## Interview questions

1. **Why does `if`/`else` being an expression matter in Kotlin?** — It lets `if` directly produce a value assigned to a `val`/`var` or returned from a function (`val x = if (cond) a else b`), avoiding a separate ternary operator and avoiding the common "declare a var, then assign it in each branch" pattern other languages need.
2. **What does it mean for a `when` expression to be exhaustive, and when is that enforced?** — Exhaustive means every possible input value is handled by some branch. It's enforced by the compiler only when `when` is used as an expression (its value is used) — a `when` used purely as a statement doesn't need to cover every case since there's no missing return value to worry about.

---
← [Previous: Operators](../03_operators/README.md) | [Next: Loops →](../05_loops/README.md)
