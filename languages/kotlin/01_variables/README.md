# Variables

Kotlin is statically typed with type inference: `val` declares a read-only (single-assignment) reference, `var` declares a mutable one — prefer `val` by default, reaching for `var` only when reassignment is actually needed. Types are usually inferred from the initializer but can be written explicitly (`val age: Int = 25`). Kotlin has no primitive/boxed-type split visible in source — `Int`, `Boolean`, etc. are all regular types, compiled to JVM primitives where possible.

## Example

```kotlin
val age = 25              // inferred as Int, cannot be reassigned
var name = "Ada"          // inferred as String, can be reassigned
name = "Grace"

val maxRetries: Int = 3   // explicit type annotation

val point = intArrayOf(3, 4)   // a primitive int array
```

See [`example.kt`](./example.kt) for the full runnable file.

## Common mistakes

1. **Defaulting to `var` out of habit.** Kotlin's convention is `val` first — an immutable reference is easier to reason about and is the idiomatic default; only switch to `var` when the variable genuinely needs to change.
2. **Confusing `val` with deep immutability.** `val list = mutableListOf(1, 2, 3)` prevents reassigning `list` to a different object, but the list's *contents* can still change (`list.add(4)` is fine) — use `listOf` (a read-only `List`) if the contents shouldn't change either.
3. **Using `Array<Int>` (boxed) where `IntArray` (primitive) would do.** `Array<Int>` boxes every element as an `Integer` object on the JVM; `IntArray` (and its `Long`/`Double`/etc. counterparts) stores unboxed primitives, avoiding the overhead for large numeric collections.
4. **Not using an explicit type annotation when the inferred type would be surprising** — e.g. `val x = 1.0f` infers `Float`, not the more commonly expected `Double`; write the type explicitly when the literal's inferred type matters.

## Exercise

Write a function `fun swap(a: Int, b: Int): Pair<Int, Int>` that returns `(b, a)`.

Try it yourself first, then check [`solutions/exercise_1.kt`](./solutions/exercise_1.kt).

## Interview questions

1. **What's the difference between `val` and `var`?** — `val` creates a read-only reference (single assignment, like Java's `final` local variable); `var` creates a mutable one. Neither implies the referenced object itself is immutable — a `val` pointing to a `MutableList` still allows mutating the list's contents.
2. **Does Kotlin have primitive types the way Java does?** — Not visibly in source — `Int`, `Boolean`, `Double`, etc. are ordinary types with member functions, and the compiler represents them as JVM primitives when possible (avoiding boxing) and falls back to the boxed wrapper only when a nullable type or generic type parameter requires it.

---
← Previous: (start) | [Next: Data Types →](../02_datatypes/README.md)
