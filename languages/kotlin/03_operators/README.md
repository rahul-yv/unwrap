# Operators

Kotlin has the usual arithmetic, comparison, and logical operators, plus a few distinctive ones: `..` (range), `in`/`!in` (membership), `?:` (Elvis, a default for `null`), and operator overloading (defining `plus`, `times`, etc. lets custom types use `+`, `*`). `==` is structural equality by default (calls `.equals()`); `===` is reference equality.

## Example

```kotlin
val sum = 3 + 4
val remainder = 10 % 3

val inRange = 5 in 1..10          // true — range membership
val notInRange = 15 !in 1..10     // true

val a = true; val b = false
val and = a && b
val or = a || b

val x: Int? = null
val y = x ?: -1                    // Elvis: -1 since x is null

data class Point(val x: Int, val y: Int) {
	operator fun plus(other: Point) = Point(x + other.x, y + other.y)
}
val p = Point(1, 2) + Point(3, 4)   // Point(4, 6) via operator overloading
```

See [`example.kt`](./example.kt) for the full runnable file.

## Common mistakes

1. **Confusing `..` (inclusive range) with `until` (exclusive range).** `1..5` includes `5`; `1 until 5` doesn't. Off-by-one errors follow from mixing them up, especially when translating a loop bound from another language.
2. **Overloading an operator in a way that surprises readers** — `+` should mean "combine two things of the same conceptual kind," not something unrelated; operator overloading is powerful but should match the operator's expected meaning.
3. **Using `==` when reference equality (`===`) was actually intended**, or vice versa — since `==` is the common case in Kotlin (unlike Java), reaching for `===` should be a deliberate choice, not a habit carried over from another language.
4. **Forgetting `&&`/`||` short-circuit but bitwise `and`/`or` (used on `Boolean` or integer types) don't** — `a() && b()` skips calling `b()` if `a()` is `false`; the infix functions `and`/`or` always evaluate both sides.

## Exercise

Write a function `fun clamp(value: Int, min: Int, max: Int): Int` that returns `value` clamped to the `[min, max]` range, using `in` to check membership.

Try it yourself first, then check [`solutions/exercise_1.kt`](./solutions/exercise_1.kt).

## Interview questions

1. **What's the difference between `1..5` and `1 until 5`?** — `1..5` is an inclusive range (`1, 2, 3, 4, 5`); `1 until 5` is exclusive of the upper bound (`1, 2, 3, 4`) — useful for zero-based indexing where you want `0 until list.size`.
2. **How does operator overloading work in Kotlin, and what determines which operator a function overloads?** — A function marked `operator` with a specific conventional name (`plus`, `minus`, `times`, `compareTo`, `get`, etc.) lets instances of that type use the corresponding symbol (`+`, `-`, `*`, `<`, `[]`); the compiler maps the symbol to a call of that named function, so `a + b` becomes `a.plus(b)`.

---
← [Previous: Data Types](../02_datatypes/README.md) | [Next: Conditionals →](../04_conditions/README.md)
