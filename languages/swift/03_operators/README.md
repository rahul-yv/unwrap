# Operators

Swift has the usual arithmetic, comparison, and logical operators, plus ranges (`...` closed, `..<` half-open), nil-coalescing (`??`), and operator overloading via the `+`/`==`/etc. operator functions or `static func` on a type. Arithmetic operators trap on overflow by default (`Int.max + 1` crashes) — dedicated overflow operators (`&+`, `&-`, `&*`) opt into wraparound behavior explicitly when that's actually wanted.

## Example

```swift
let sum = 3 + 4
let remainder = 10 % 3

let inRange = (1...10).contains(5)      // true — closed range membership
let notInRange = !(1...10).contains(15) // true

let a = true, b = false
let and = a && b
let or = a || b

let x: Int? = nil
let y = x ?? -1                          // nil-coalescing: -1 since x is nil

struct Point: Equatable {
	let x: Int
	let y: Int
	static func + (lhs: Point, rhs: Point) -> Point {
		Point(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
	}
}
let p = Point(x: 1, y: 2) + Point(x: 3, y: 4)   // Point(x: 4, y: 6) via operator overloading
```

See [`example.swift`](./example.swift) for the full runnable file.

## Common mistakes

1. **Confusing `...` (closed range) with `..<` (half-open range).** `1...5` includes `5`; `1..<5` doesn't. Off-by-one errors follow from mixing them up, especially when indexing an array (`0..<array.count` is the common zero-based idiom).
2. **Not knowing arithmetic traps on overflow by default.** `Int.max + 1` crashes the program rather than silently wrapping, unlike C/C++/Rust's release-mode behavior — this is intentional (catching bugs early), but surprising if coming from a language where overflow wraps silently; use `&+`/`&-`/`&*` when wraparound is genuinely the intended behavior.
3. **Overloading an operator in a way that surprises readers** — `+` should mean "combine two things of the same conceptual kind," not something unrelated.
4. **Forgetting `&&`/`||` short-circuit but bitwise `&`/`|` don't** — `a() && b()` skips calling `b()` if `a()` is `false`; `&`/`|` on `Bool` always evaluate both sides.

## Exercise

Write a function `func clamp(_ value: Int, min: Int, max: Int) -> Int` that returns `value` clamped to the `[min, max]` range, using a closed range's `.contains`.

Try it yourself first, then check [`solutions/exercise_1.swift`](./solutions/exercise_1.swift).

## Interview questions

1. **What's the difference between `1...5` and `1..<5`?** — `1...5` is a closed range, inclusive of both bounds (`1, 2, 3, 4, 5`); `1..<5` is a half-open range, exclusive of the upper bound (`1, 2, 3, 4`) — the standard choice for zero-based array indexing (`0..<array.count`).
2. **Why does Swift trap on integer overflow by default, and how do you opt out?** — Silent overflow is a common source of hard-to-find bugs (an unexpectedly wrapped value used later as if it were correct); trapping crashes immediately at the point of overflow, making the bug obvious and located precisely. The overflow operators (`&+`, `&-`, `&*`) opt into explicit wraparound behavior for the rare cases (like hash computation) where that's actually the intended semantics.

---
← [Previous: Data Types](../02_datatypes/README.md) | [Next: Conditionals →](../04_conditions/README.md)
