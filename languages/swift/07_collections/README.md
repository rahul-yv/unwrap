# Collections

Swift's core collections — `Array`, `Dictionary`, `Set` — are all **value types**: assigning or passing one copies it (Swift uses copy-on-write internally, so the copy is cheap until an actual mutation happens). Mutability is controlled by `let`/`var` on the variable itself, not by a separate mutable/immutable type as in Kotlin. Higher-order functions (`map`, `filter`, `reduce`) work the same way as most modern languages.

## Example

```swift
let numbers = [1, 2, 3, 4, 5]         // immutable Array (let)
var mutable = [1, 2, 3]
mutable.append(4)

let doubled = numbers.map { $0 * 2 }          // [2, 4, 6, 8, 10]
let evens = numbers.filter { $0 % 2 == 0 }    // [2, 4]
let total = numbers.reduce(0, +)               // 15

let ages = ["Ada": 36, "Grace": 85]
let adaAge = ages["Ada"]                       // 36 (Optional — nil if key missing)

let lazyResult = numbers.lazy
	.map { $0 * 2 }
	.filter { $0 > 4 }
	.first                                       // 6 — stops at the first match, no intermediate arrays
```

See [`example.swift`](./example.swift) for the full runnable file.

## Common mistakes

1. **Assuming a `let` array/dictionary means the elements themselves are `let`.** For value types, `let numbers = [1, 2, 3]` prevents both reassignment *and* mutation (`numbers.append(4)` is a compile error) — a stronger guarantee than Kotlin's read-only `List` view, since there's no separate mutable reference that could still change it elsewhere.
2. **Chaining many `map`/`filter` calls on a large `Array` where `.lazy` would avoid building an intermediate array at every step.** Each eager operation allocates a full new array; `.lazy` operations only run item-by-item as a terminal access (like `.first`) pulls values through.
3. **Using `dict["key"]` and assuming it always returns a value.** It returns `Value?` — `nil` if the key is absent — not a crash; use `dict["key", default: someDefault]` for a fallback, or optional binding/nil-coalescing.
4. **Forgetting `Set` has no defined iteration order** — unlike `Array`, iterating a `Set` doesn't guarantee elements come out in insertion (or any particular) order; sort explicitly if order matters for output.

## Exercise

Write a function `func wordLengths(_ words: [String]) -> [String: Int]` that returns a dictionary from each word to its length.

Try it yourself first, then check [`solutions/exercise_1.swift`](./solutions/exercise_1.swift).

## Interview questions

1. **Why does it matter that `Array`/`Dictionary`/`Set` are value types in Swift?** — Assignment and function parameter passing copy the collection (with copy-on-write making this cheap until an actual mutation occurs), so two variables holding "the same" collection are truly independent — mutating one never affects the other. This differs from most mainstream languages (Java, Kotlin, C#, JS), where collections are reference types and assignment shares the same underlying object.
2. **When does `.lazy` outperform eager collection operations for a chain of transformations?** — Eager operations (`.map`, `.filter` on a plain `Array`) fully process the input and allocate a new array at every step in a chain. `.lazy` operations are deferred: nothing runs until a terminal access (like `.first` or iterating with `for`) pulls elements through the whole chain one at a time — avoiding intermediate allocations, which matters most for long chains or when a terminal operation can short-circuit.

---
← [Previous: Functions](../06_functions/README.md) | [Next: OOP →](../08_oop/README.md)
