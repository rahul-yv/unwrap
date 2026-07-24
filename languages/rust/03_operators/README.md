# Operators

Rust has no ternary operator — `if` is an *expression* that evaluates to a value, so `if`/`else` fills that role directly. There's no `++`/`--` either (Rust considers them a source of subtle bugs in C-family languages). Range operators (`0..5` exclusive, `0..=5` inclusive) are used pervasively for iteration and slicing.

## Example

```rust
let score = 85;

// if is an expression: this replaces the ternary operator
let label = if score >= 60 { "pass" } else { "fail" };

let q = 7 / 2;      // 3 — integer division truncates toward zero
let r = 7 % 2;       // 1

for i in 0..3 {       // 0, 1, 2 — exclusive range
	println!("{}", i);
}
for i in 0..=3 {      // 0, 1, 2, 3 — inclusive range
	println!("{}", i);
}
```

See [`example.rs`](./example.rs) for the full runnable file.

## Common mistakes

1. **Looking for `++`/`--`.** Rust doesn't have them; use `x += 1` / `x -= 1` explicitly — a deliberate omission since `++`/`--` are a common source of order-of-evaluation bugs in other languages.
2. **Confusing `0..5` (exclusive, doesn't include 5) with `0..=5` (inclusive, includes 5).** An easy off-by-one if the wrong range form is used for the intended loop bound.
3. **Forgetting `if` as an expression requires both branches to produce the same type**, and requires an explicit `else` when the value is actually used — `let x = if cond { 1 };` (no `else`) is a compile error if the result is bound to something, since the "no else" case would have no value to produce.
4. **Not knowing about `?` for error propagation** and writing verbose manual `match`/`if let` chains instead — covered in depth in `09_errors`, but it's one of Rust's most distinctive operators and worth knowing exists early.

## Exercise

Write `fn clamp(value: i32, low: i32, high: i32) -> i32` restricting `value` to `[low, high]`, using `i32::max`/`i32::min` (or the standalone `std::cmp::max`/`min`).

Try it yourself first, then check [`solutions/exercise_1.rs`](./solutions/exercise_1.rs).

## Interview questions

1. **Why does Rust use `if` as an expression instead of a separate ternary operator?** — Consistency: Rust treats most constructs (`if`, `match`, blocks) as expressions that produce a value, so a dedicated ternary syntax would just be a redundant special case of something `if` already does.
2. **What's the difference between `0..5` and `0..=5`?** — `0..5` is a half-open range (`0, 1, 2, 3, 4` — excludes the end), `0..=5` is inclusive (`0, 1, 2, 3, 4, 5` — includes the end); mixing them up is an easy off-by-one source.

---
← [Previous: Data Types](../02_datatypes/README.md) | [Next: Conditionals →](../04_conditions/README.md)
