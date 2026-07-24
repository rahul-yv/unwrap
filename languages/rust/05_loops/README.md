# Loops

Rust has `loop` (infinite, exits via `break` — and uniquely, `break value` can make the loop itself evaluate to a value), `while`, and `for` (iterator-based only — there's no C-style three-clause `for`). Ranges (`0..n`) combined with `for` cover the classic counting loop.

## Example

```rust
for i in 0..3 {
	println!("{}", i);            // 0, 1, 2
}

for item in ["a", "b", "c"] {
	println!("{}", item);          // iterates values directly
}

let mut n = 0;
while n < 3 {
	n += 1;
}

let mut counter = 0;
let result = loop {
	counter += 1;
	if counter == 5 {
		break counter * 2;          // loop evaluates to this value
	}
};
assert_eq!(result, 10);
```

See [`example.rs`](./example.rs) for the full runnable file.

## Common mistakes

1. **Looking for a C-style `for (i = 0; i < n; i++)`.** It doesn't exist — use `for i in 0..n`, which is both more concise and impossible to get an off-by-one wrong on the loop mechanics (only on the range bounds themselves).
2. **Forgetting `loop` can return a value via `break value`.** Missing this leads to reimplementing the same pattern with a mutable variable set before breaking, when `let result = loop { ... break x; };` does it directly.
3. **Iterating a `Vec` by value in a `for` loop when only reading is needed**, which moves (consumes) the vector — `for item in &vec` (or `.iter()`) borrows instead, leaving the original usable afterward.
4. **Using indices to iterate a collection** (`for i in 0..vec.len() { vec[i] ... }`) when `for item in &vec` avoids both the indexing overhead and the possibility of an out-of-bounds index.

## Exercise

Write `fn first_even(numbers: &[i32]) -> Option<i32>` returning the first even number, or `None` if there isn't one, using a `for` loop over `numbers`.

Try it yourself first, then check [`solutions/exercise_1.rs`](./solutions/exercise_1.rs).

## Interview questions

1. **Why doesn't Rust have a C-style three-clause `for` loop?** — The language designers favor `for`-over-an-iterator as strictly safer (no manual index bookkeeping, no off-by-one on the loop condition itself) and just as expressive via ranges (`0..n`) for the counting case.
2. **What does `break value` let you do that a plain `break` doesn't?** — Lets a `loop` (used as an expression) produce a result directly from the point where it exits, avoiding a separate mutable variable set right before breaking just to carry the result out.

---
← [Previous: Conditionals](../04_conditions/README.md) | [Next: Functions →](../06_functions/README.md)
