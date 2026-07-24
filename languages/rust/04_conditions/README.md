# Conditionals

`match` is Rust's signature conditional: it compares a value against a series of patterns and is **exhaustive** — the compiler refuses to build unless every possible case is handled (or a `_` catch-all is present). This eliminates an entire class of "forgot a case" bugs that a plain `if`/`else if` chain doesn't catch. `if let` is a lighter-weight form for matching just one pattern.

## Example

```rust
enum Shape {
	Circle(f64),
	Square(f64),
}

fn area(shape: &Shape) -> f64 {
	match shape {
		Shape::Circle(radius) => std::f64::consts::PI * radius * radius,
		Shape::Square(side) => side * side,
		// no catch-all needed: every Shape variant is covered
	}
}

let maybe_number: Option<i32> = Some(5);
if let Some(n) = maybe_number {
	println!("got {}", n);   // only runs if it's Some
}
```

See [`example.rs`](./example.rs) for the full runnable file.

## Common mistakes

1. **Adding a new enum variant without updating every `match` on it** — the compiler catches this immediately (a "non-exhaustive match" error) rather than letting a new case fall through silently, unlike a plain `if`/`else if` chain or a `switch` in a language that allows non-exhaustive cases.
2. **Using a catch-all `_` pattern too eagerly**, silencing the exhaustiveness check that's the whole point of `match` — if you actually want every case handled explicitly (so a new variant forces you to reconsider), skip the catch-all.
3. **Reaching for a full `match` when `if let` says the same thing more concisely** for "do something only if this one pattern matches, otherwise do nothing" — `match` shines when multiple patterns matter; `if let` is the idiomatic choice for just one.
4. **Forgetting `match` arms must all return the same type** when used as an expression (same rule as `if`/`else`) — a common way this surfaces is one arm ending with `;` (making it `()`) while others return a value.

## Exercise

Define an `enum TrafficLight { Red, Yellow, Green }` and write `fn action(light: &TrafficLight) -> &str` returning `"stop"`, `"slow down"`, `"go"` respectively, using `match`.

Try it yourself first, then check [`solutions/exercise_1.rs`](./solutions/exercise_1.rs).

## Interview questions

1. **Why does `match`'s exhaustiveness checking matter for maintainability?** — Adding a new variant to an `enum` forces the compiler to point at every `match` that needs updating for the new case, turning a "forgot to handle the new case" bug into a compile error caught immediately, rather than a runtime gap discovered later.
2. **When would you use `if let` instead of `match`?** — When only one pattern actually matters and everything else should be ignored (or has a trivial default) — `if let Some(x) = maybe_value { ... }` is more concise than a full `match` with a `_ => {}` arm.

---
← [Previous: Operators](../03_operators/README.md) | [Next: Loops →](../05_loops/README.md)
