# Data Types

Kotlin's basic types are `Int`, `Long`, `Short`, `Byte`, `Double`, `Float`, `Boolean`, `Char`, and `String`. The defining feature of Kotlin's type system is **null safety**: every type is non-nullable by default (`String`), and a `?` suffix (`String?`) opts a type into allowing `null` — the compiler then forces you to handle the `null` case before using the value, catching a huge class of `NullPointerException`s at compile time.

## Example

```kotlin
val i: Int = 42
val d: Double = 3.14
val flag: Boolean = true
val letter: Char = 'A'
val text: String = "hello"

val name: String? = null            // explicitly nullable
val length = name?.length ?: 0      // safe call + Elvis operator: 0 if name is null

val big: Long = 10_000_000_000L
val ratio = 3 / 2                    // 1 — integer division
val exact = 3.0 / 2                  // 1.5 — floating-point division
```

See [`example.kt`](./example.kt) for the full runnable file.

## Common mistakes

1. **Using `!!` to force-unwrap a nullable without checking it first.** `name!!.length` throws `NullPointerException` immediately if `name` is `null` — it silences the compiler's safety check rather than handling the case. Prefer `?.`, `?:`, or an explicit `if (name != null)` check.
2. **Forgetting integer division truncates.** `3 / 2` is `1`, not `1.5`, when both operands are `Int` — make at least one operand a `Double` (or use `.toDouble()`) for a fractional result.
3. **Treating `Int` and `Long` as interchangeable without a suffix.** A literal like `10000000000` overflows `Int` at compile time; large literals need the `L` suffix (`10_000_000_000L`) to be typed as `Long`.
4. **Comparing `String`s (or any type) with `==` and assuming it's reference equality.** In Kotlin, `==` calls `.equals()` (structural equality) by default — the opposite of Java's `==`; use `===` for reference equality if that's actually what's needed.

## Exercise

Write a function `fun safeLength(s: String?): Int` that returns the string's length, or `0` if it's `null`, using the safe-call and Elvis operators.

Try it yourself first, then check [`solutions/exercise_1.kt`](./solutions/exercise_1.kt).

## Interview questions

1. **How does Kotlin's null safety work, and what does `!!` do?** — Every type is non-nullable unless suffixed with `?`; the compiler statically prevents using a nullable value without first checking or safely accessing it (`?.`, `?:`, smart-cast after an `if` check). `!!` bypasses this, asserting the value isn't `null` and throwing `NullPointerException` immediately if it is — it should be rare, used only when you're certain and want a loud failure rather than a silent one.
2. **What's the difference between `==` and `===` in Kotlin?** — `==` calls `.equals()` (structural/value equality, the usual choice); `===` checks reference equality (same object identity) — the reverse of Java, where `==` is reference equality for objects.

---
← [Previous: Variables](../01_variables/README.md) | [Next: Operators →](../03_operators/README.md)
