# Collections

Kotlin's collections come in read-only and mutable pairs: `List`/`MutableList`, `Set`/`MutableSet`, `Map`/`MutableMap` — the read-only interfaces simply don't expose mutating methods (the underlying object may still be mutable elsewhere, but the read-only view can't change it). `Sequence` gives lazy, chainable operations (like Java's `Stream`) for large or expensive pipelines, versus `List`'s eager operations that build an intermediate collection at every step.

## Example

```kotlin
val numbers = listOf(1, 2, 3, 4, 5)          // read-only List
val mutable = mutableListOf(1, 2, 3)
mutable.add(4)

val doubled = numbers.map { it * 2 }          // [2, 4, 6, 8, 10] — eager, builds a new List
val evens = numbers.filter { it % 2 == 0 }    // [2, 4]
val total = numbers.fold(0) { acc, n -> acc + n }   // 15

val ages = mapOf("Ada" to 36, "Grace" to 85)
val adaAge = ages["Ada"]                      // 36 (nullable — null if key missing)

val lazyResult = numbers.asSequence()
	.map { it * 2 }
	.filter { it > 4 }
	.first()                                   // 6 — stops at the first match, no intermediate lists
```

See [`example.kt`](./example.kt) for the full runnable file.

## Common mistakes

1. **Assuming a `List` (read-only interface) means the underlying collection can never change.** `listOf(...)` returns a genuinely immutable snapshot, but a `List`-typed reference to a `MutableList` (e.g. a function parameter typed `List<T>` receiving a `MutableList<T>` argument) can still be mutated through the original mutable reference elsewhere — the read-only *view* just can't do it itself.
2. **Chaining many `map`/`filter` calls on a large `List` where `.asSequence()` would avoid building an intermediate list at every step.** Each eager operation on a `List` allocates a full new list; `Sequence` operations are lazy and only run item-by-item as the final terminal operation (`.toList()`, `.first()`, etc.) pulls values through.
3. **Using `map["key"]` and assuming it always returns a value.** It returns `T?` — `null` if the key is absent — not an exception; use `.getValue(key)` (throws if missing) or `?:` for a default if a non-null result is needed.
4. **Reaching for a mutable collection when a read-only one would communicate intent better** — expose `List`/`Map`/`Set` in public APIs even when the backing implementation is mutable internally, so callers can't accidentally rely on being able to mutate it.

## Exercise

Write a function `fun wordLengths(words: List<String>): Map<String, Int>` that returns a map from each word to its length.

Try it yourself first, then check [`solutions/exercise_1.kt`](./solutions/exercise_1.kt).

## Interview questions

1. **What's the difference between `List` and `MutableList` in Kotlin?** — `List` is a read-only interface (no `add`/`remove`/`set`); `MutableList` extends it with mutating methods. This is a compile-time view distinction, not a runtime immutability guarantee — the object behind a `List` reference could still be a `MutableList` mutated through a different reference that holds the mutable type.
2. **When does `Sequence` outperform `List` for a chain of transformations?** — `List` operations are eager: each `.map`/`.filter` in a chain fully processes the input and allocates a new list before the next operation runs. `Sequence` operations are lazy: nothing runs until a terminal operation is called, and then each element flows through the whole chain one at a time — avoiding intermediate allocations, which matters most for long chains or large/expensive-to-produce collections, especially when a terminal operation like `.first()` can short-circuit.

---
← [Previous: Functions](../06_functions/README.md) | [Next: OOP →](../08_oop/README.md)
