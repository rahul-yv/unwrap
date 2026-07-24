# Functions

Rust functions declare parameter and return types explicitly (no inference for signatures, only for local variables). The last expression in a function body (no semicolon) is its implicit return value — `return` is only needed for an early exit. Closures (`|x| x + 1`) capture their environment and come in three flavors depending on how they use what they capture: `Fn` (borrows), `FnMut` (mutably borrows), `FnOnce` (takes ownership, callable once).

## Example

```rust
fn add(a: i32, b: i32) -> i32 {
	a + b   // no semicolon: this is the return value
}

fn make_adder(n: i32) -> impl Fn(i32) -> i32 {
	move |x| x + n   // `move` takes ownership of `n` into the closure
}

let add_five = make_adder(5);
assert_eq!(add_five(3), 8);

fn takes_ownership(s: String) {
	println!("{}", s);
}   // s is dropped here

fn borrows(s: &String) {
	println!("{}", s);
}   // nothing is dropped; the caller still owns it
```

See [`example.rs`](./example.rs) for the full runnable file.

## Common mistakes

1. **Adding a semicolon to what was meant to be the return expression.** `fn add(a: i32, b: i32) -> i32 { a + b; }` is a compile error — the trailing `;` turns the expression into a statement producing `()`, which doesn't match the declared `i32` return type.
2. **Passing an owned value (like `String`) to a function that only needs to read it**, moving it and making it unusable in the caller afterward — take `&str`/`&T` (a borrow) when the function doesn't need ownership.
3. **Trying to use a value after passing it by value to a function that takes ownership.** Once moved, the original binding is no longer valid — the compiler catches this ("value used after move") at compile time, not as a runtime null-pointer-style bug.
4. **Not knowing which closure trait (`Fn`/`FnMut`/`FnOnce`) a given closure needs** — a closure that only reads captured variables implements all three; one that mutates a captured variable needs at least `FnMut`; one that consumes a captured variable (like moving it out) is `FnOnce` only.

## Exercise

Write a function `make_counter() -> impl FnMut() -> i32` returning a closure; each call to the returned closure returns an incrementing count starting at 1.

Try it yourself first, then check [`solutions/exercise_1.rs`](./solutions/exercise_1.rs).

## Interview questions

1. **Why is a semicolon significant at the end of the last line in a function body?** — Without one, the last expression's value is the function's return value; with one, it becomes a statement evaluating to `()`, which is a type mismatch against any non-`()` declared return type — this is a common first stumbling block for new Rust developers.
2. **What's the difference between `Fn`, `FnMut`, and `FnOnce`?** — They describe how a closure interacts with what it captures: `Fn` only borrows (callable repeatedly, shared access), `FnMut` mutably borrows (callable repeatedly, exclusive access needed), `FnOnce` consumes captured values by moving them out (callable only once). Every closure implements at least `FnOnce`; whether it also implements `FnMut`/`Fn` depends on what its body actually does.

---
← [Previous: Loops](../05_loops/README.md) | Next: Collections (coming soon)
