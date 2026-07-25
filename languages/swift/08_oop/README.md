# Object-Oriented Programming

Swift has both `struct` (value type) and `class` (reference type) — a deliberate two-tier system, unlike languages with only classes. Structs are preferred by default (Swift's own standard library types — `Array`, `String`, `Int` — are all structs); reach for a class when reference semantics (shared, mutable identity) or inheritance is actually needed. `protocol` defines a contract types can conform to (similar to an interface, but structs can conform too, not just classes) — Swift favors protocol-oriented composition over class inheritance for most code. `enum` supports associated values, making it suitable for modeling a closed set of variants, each possibly carrying different data.

## Example

```swift
protocol Greetable {
	var name: String { get }
	func greet() -> String
}

struct Person: Greetable {
	let name: String
	func greet() -> String { "Hello, \(name)!" }
}

struct Point: Equatable {
	var x: Int
	var y: Int
}

let p1 = Point(x: 1, y: 2)
var p2 = p1                  // a full copy — p2 is independent of p1 (value semantics)
p2.y = 3
// p1 is still Point(x: 1, y: 2)

enum Shape {
	case circle(radius: Double)
	case square(side: Double)
}

func area(_ shape: Shape) -> Double {
	switch shape {
	case .circle(let radius): return Double.pi * radius * radius
	case .square(let side): return side * side
	}
}
```

See [`example.swift`](./example.swift) for the full runnable file.

## Common mistakes

1. **Reaching for `class` by default out of habit from other languages.** Swift's guidance is to prefer `struct` unless you specifically need reference semantics (shared mutable state, identity comparison) or class-only features (inheritance, deinitializers) — most modeling problems are better served by value types.
2. **Forgetting a `struct`'s properties are copied on assignment**, so mutating a copy never affects the original — a common surprise coming from reference-type-only languages, where `p2 = p1; p2.y = 3` would also change `p1`.
3. **Not using `enum` with associated values for a closed set of variants that carry different data**, reaching instead for a class hierarchy with a "type" field or several optional properties — `enum` with a `switch` gives compiler-enforced exhaustiveness that a class hierarchy or optional-heavy struct doesn't.
4. **Trying to mutate a `struct`'s properties in a method without marking it `mutating`.** Struct methods are non-mutating by default (since Swift can't assume the underlying value type will get a new binding); a method that reassigns `self` or a property needs the `mutating` keyword.

## Exercise

Write an `enum Shape` with cases `circle(radius: Double)` and `rectangle(width: Double, height: Double)`, and a function `func perimeter(_ shape: Shape) -> Double` covering both with `switch`.

Try it yourself first, then check [`solutions/exercise_1.swift`](./solutions/exercise_1.swift).

## Interview questions

1. **When should you use a `struct` versus a `class` in Swift?** — Prefer `struct` by default: value semantics (copy on assignment, no shared mutable state) make code easier to reason about and are what Swift's own standard library types use. Use `class` when you need reference semantics (multiple owners sharing and observing the same mutable instance), inheritance, or a deinitializer — situations where identity, not just equal content, matters.
2. **Why does `enum` with associated values suit modeling a closed set of variants better than a class hierarchy?** — Each case can carry exactly the data relevant to that variant (no unused optional properties inherited by every case), and a `switch` over the enum is checked for exhaustiveness by the compiler — adding a new case forces every non-`default` `switch` handling that enum to be updated, catching gaps at compile time rather than as a runtime surprise.

---
← [Previous: Collections](../07_collections/README.md) | [Next: Error Handling →](../09_errors/README.md)
