# Conditionals

Swift has `if`/`else` (statement, not an expression — unlike Kotlin/Rust, so a ternary-like assignment still needs the `cond ? a : b` operator), and `switch`, which is exhaustive by default and supports pattern matching on values, ranges, tuples, and enum cases with associated values. `guard` inverts the usual `if` shape for early exit: it requires the condition to hold to continue, otherwise the `else` branch must exit the current scope (`return`, `break`, `continue`, or `throw`).

## Example

```swift
let age = 20
let category = age < 13 ? "child" : (age < 20 ? "teen" : "adult")   // ternary, chained

let x = 5
let description: String
switch x {
case ..<0: description = "negative"
case 0: description = "zero"
case let n where n % 2 == 0: description = "positive even"
default: description = "positive odd"
}

func describe(_ value: Any) -> String {
	switch value {
	case let i as Int: return "an Int: \(i)"
	case let s as String: return "a String of length \(s.count)"
	default: return "something else"
	}
}

func firstPositive(_ numbers: [Int]) -> Int {
	guard let found = numbers.first(where: { $0 > 0 }) else {
		return -1   // guard's else must exit the current scope
	}
	return found
}
```

See [`example.swift`](./example.swift) for the full runnable file.

## Common mistakes

1. **Forgetting `switch` requires exhaustiveness — every possible value must be covered**, either explicitly (all enum cases) or via `default`. Missing a case (with no `default`) is a compile error, catching gaps immediately rather than at runtime — but it does mean a `default` (or, for an `Int`, an unreachable-seeming case) is often required even when logically "all cases are covered" isn't obvious to the compiler.
2. **Not using `guard` for early-exit validation**, instead nesting the "happy path" inside an `if let` — `guard let x = optional else { return }` keeps the main logic at the top level of the function, unindented, while `if let x = optional { ... rest of function ... }` pushes everything into a deeper nesting level.
3. **Writing nested ternaries that are hard to read** — a chain like `age < 13 ? "child" : (age < 20 ? "teen" : "adult")` is fine for two branches but degrades quickly; a `switch` is clearer once there are more than two or three cases.
4. **Comparing floating-point values for exact equality in a condition** (`if x == 0.3`) — the same rounding-error trap as any language; compare against a small tolerance instead when the value comes from computation rather than a literal.

## Exercise

Write a function `func grade(_ score: Int) -> String` returning `"A"` for 90+, `"B"` for 80-89, `"C"` for 70-79, and `"F"` otherwise, using `switch` with range patterns.

Try it yourself first, then check [`solutions/exercise_1.swift`](./solutions/exercise_1.swift).

## Interview questions

1. **Why must a Swift `switch` be exhaustive, and how does that help catch bugs?** — The compiler requires every possible value of the switched-on type to be handled (via explicit cases or `default`); if a new enum case is added later, every `switch` over that enum that doesn't already have a `default` becomes a compile error at the exact site missing the new case, rather than silently falling through unnoticed at runtime.
2. **What's the difference between `if let` and `guard let`, and when do you use each?** — Both unwrap an optional and bind it to a name, but `if let` scopes the unwrapped value to the `if` block's body — the "happy path" gets nested inside it. `guard let` requires the condition to hold to continue past that point in the current scope; its `else` branch must exit (`return`/`break`/`continue`/`throw`), so the unwrapped value stays available for the rest of the function unindented — commonly used for early-exit validation at the top of a function.

---
← [Previous: Operators](../03_operators/README.md) | [Next: Loops →](../05_loops/README.md)
