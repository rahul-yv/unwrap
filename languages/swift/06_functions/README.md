# Functions

Swift functions have distinctive parameter labels: each parameter can have both an external (call-site) label and an internal (body) name, defaulting to the same word, with `_` suppressing the external label. Default parameter values, closures (`{ (x: Int) -> Int in x + 1 }`), and trailing closure syntax round it out. A closure can capture and mutate variables from its enclosing scope, same as Kotlin/JS.

## Example

```swift
func greet(_ name: String, greeting: String = "Hello") -> String {
	"\(greeting), \(name)!"
}

greet("Ada")                          // "Hello, Ada!" — `_` suppresses the label for name
greet("Ada", greeting: "Hi")          // "Hi, Ada!" — greeting keeps its label

let addFive: (Int) -> Int = { x in x + 5 }
addFive(3)                             // 8

func makeAdder(_ n: Int) -> (Int) -> Int {
	{ x in x + n }                      // closure over n
}
let addTen = makeAdder(10)
addTen(5)                              // 15

func makeCounter() -> () -> Int {
	var count = 0
	return {
		count += 1
		return count
	}
}
```

See [`example.swift`](./example.swift) for the full runnable file.

## Common mistakes

1. **Forgetting a parameter has two names — external and internal — and mixing them up.** `func greet(_ name: String, greeting: String)`: at the call site, `name` has no label (due to `_`) but `greeting` does; inside the function body, both are referred to by their internal name (`name`, `greeting`) regardless of the external label.
2. **Not using trailing closure syntax where it reads more naturally.** `numbers.map({ $0 * 2 })` works, but `numbers.map { $0 * 2 }` (moving the closure outside the parentheses when it's the last argument) is the idiomatic Swift style.
3. **Mixing many default parameters where a clearer API (or splitting into separate functions) would help** — a function with several defaulted parameters called positionally is hard to read; Swift's required external labels mitigate this more than some languages, but it's still worth watching.
4. **Forgetting closures capture variables by reference, not by value**, so a closure that outlives the scope it was created in still sees later mutations to captured `var`s made elsewhere (or, for a returned closure, retains and can mutate its own private captured state — the mechanism behind `makeCounter`).

## Exercise

Write a function `func makeCounter() -> () -> Int` returning a closure; each call to the returned closure returns an incrementing count starting at 1 (use a closure over a local `var`).

Try it yourself first, then check [`solutions/exercise_1.swift`](./solutions/exercise_1.swift).

## Interview questions

1. **What are external and internal parameter names in Swift, and why does the language have both?** — The external name is what a caller writes at the call site (`greet(_:greeting:)`); the internal name is what the function body uses to refer to the parameter. Having both lets call sites read like natural language (`insert(_:at:)` reads as "insert x at y") while the function body can use whatever internal name is clearest, independent of the call-site phrasing.
2. **What does it mean for a closure to "capture" a variable, and what's a practical use?** — The closure keeps a live reference to the variable from its enclosing scope, so it can read (and, if it's a `var`, mutate) that variable even after the enclosing function has returned — the captured storage stays alive as long as something references the closure. A counter closure (`makeCounter`) is the classic example: the returned closure carries its own private mutable state via the captured variable.

---
← [Previous: Loops](../05_loops/README.md) | [Next: Collections →](../07_collections/README.md)
