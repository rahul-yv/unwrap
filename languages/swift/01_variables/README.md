# Variables

Swift is statically typed with type inference: `let` declares a constant (single-assignment), `var` declares a mutable variable — prefer `let` by default, reaching for `var` only when reassignment is actually needed. Types are usually inferred from the initializer but can be written explicitly (`let age: Int = 25`).

## Example

```swift
let age = 25              // inferred as Int, cannot be reassigned
var name = "Ada"          // inferred as String, can be reassigned
name = "Grace"

let maxRetries: Int = 3   // explicit type annotation

var point = (x: 3, y: 4)  // a tuple with named elements
```

See [`example.swift`](./example.swift) for the full runnable file.

## Common mistakes

1. **Defaulting to `var` out of habit.** Swift's convention is `let` first — an immutable binding is easier to reason about and lets the compiler optimize more aggressively; only switch to `var` when the value genuinely needs to change.
2. **Confusing `let` with deep immutability for reference types.** `let array = NSMutableArray()` prevents reassigning `array` to a different object, but its *contents* can still change through its own mutating methods — `let` on a value type (like Swift's native `Array`) is different: it does prevent mutation, since value types copy on assignment.
3. **Forgetting Swift's native collections (`Array`, `Dictionary`, `Set`) are value types, not reference types.** `let numbers = [1, 2, 3]` truly can't have its elements changed — unlike Java/Kotlin/C# collections, which are reference types where `let`/`val`/`readonly` only prevents rebinding the variable, not mutating the collection.
4. **Not using an explicit type annotation when the inferred type would be surprising** — e.g. an integer literal assigned where a `Double` was intended infers `Int`; write the type explicitly when the literal's inferred type matters.

## Exercise

Write a function `func swap(_ a: Int, _ b: Int) -> (Int, Int)` that returns `(b, a)`.

Try it yourself first, then check [`solutions/exercise_1.swift`](./solutions/exercise_1.swift).

## Interview questions

1. **What's the difference between `let` and `var`?** — `let` creates a constant (single assignment); `var` creates a mutable variable. For value types (structs, enums, and Swift's native collections), `let` genuinely prevents any mutation of the value; for reference types (classes), `let` only prevents rebinding the reference — the object it points to can still be mutated through its own methods if those methods don't require the reference itself to change.
2. **Why does it matter that Swift's `Array`/`Dictionary`/`Set` are value types?** — Assigning or passing one copies it (Swift uses copy-on-write internally so this is cheap until an actual mutation happens), so two variables holding "the same" array are truly independent — mutating one never affects the other. This differs from most other mainstream languages, where collections are reference types and assignment shares the same underlying object.

---
← Previous: (start) | [Next: Data Types →](../02_datatypes/README.md)
