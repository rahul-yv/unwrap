# Data Types

Swift's basic types are `Int`, `Double`, `Float`, `Bool`, `Character`, and `String`. Like Kotlin, Swift builds **null safety** (called "optionals" here) directly into the type system: every type is non-optional by default (`String`), and wrapping it in `Optional` (written `String?`) explicitly allows the absence of a value — the compiler forces you to unwrap an optional before using it.

## Example

```swift
let i: Int = 42
let d: Double = 3.14
let flag: Bool = true
let letter: Character = "A"
let text: String = "hello"

let name: String? = nil                    // explicitly optional
let length = name?.count ?? 0               // optional chaining + nil-coalescing: 0 if name is nil

if let unwrapped = name {                   // optional binding
	// only runs if name is non-nil
} else {
	// name was nil
}

let big: Int64 = 10_000_000_000
let ratio = 3 / 2                            // 1 — integer division
let exact = 3.0 / 2                          // 1.5 — floating-point division
```

See [`example.swift`](./example.swift) for the full runnable file.

## Common mistakes

1. **Force-unwrapping (`name!`) without checking first.** `name!.count` crashes immediately if `name` is `nil` — it bypasses the compiler's safety check rather than handling the case. Prefer `if let`, `guard let`, or `??` for a default.
2. **Forgetting integer division truncates.** `3 / 2` is `1`, not `1.5`, when both operands are `Int` — convert at least one operand to `Double` for a fractional result.
3. **Using implicitly unwrapped optionals (`String!`) as a substitute for proper optional handling** rather than for their intended narrow use (properties that are guaranteed set before first use, like some UIKit outlets) — it defers the crash risk of force-unwrapping rather than removing it.
4. **Comparing `String`s with `==` and assuming it's identity comparison** — in Swift, `==` on `String` (and most value types) is structural equality by default; identity comparison (`===`) only applies to class instances (reference types).

## Exercise

Write a function `func safeLength(_ s: String?) -> Int` that returns the string's length, or `0` if it's `nil`, using optional chaining and nil-coalescing.

Try it yourself first, then check [`solutions/exercise_1.swift`](./solutions/exercise_1.swift).

## Interview questions

1. **How do Swift optionals work, and what does force-unwrapping do?** — Every type is non-optional unless wrapped as `Optional<T>` (`T?`); the compiler statically prevents using an optional value without first unwrapping it (via `if let`, `guard let`, optional chaining `?.`, or nil-coalescing `??`). Force-unwrapping (`!`) bypasses this, asserting the value isn't `nil` and crashing the program immediately if it is — it should be rare, used only when `nil` genuinely can't occur at that point.
2. **What's the difference between `==` and `===` in Swift?** — `==` (via the `Equatable` protocol) compares values structurally — two separately created instances with equal contents are `==`. `===` compares reference identity and only applies to class instances (reference types) — it checks whether two variables refer to the exact same object in memory, not whether their contents are equal.

---
← [Previous: Variables](../01_variables/README.md) | [Next: Operators →](../03_operators/README.md)
