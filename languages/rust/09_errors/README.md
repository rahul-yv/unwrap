# Error Handling

Rust has no exceptions. Recoverable errors are `Result<T, E>` (`Ok(value)` or `Err(error)`); the absence of a value is `Option<T>` (`Some(value)` or `None`) — not a special "error," just "nothing here." The `?` operator propagates an `Err`/`None` up to the caller in one character, replacing verbose manual matching. `panic!` is reserved for unrecoverable bugs — it unwinds (or aborts) the program, not something you catch and handle as normal control flow.

## Example

```rust
fn divide(a: f64, b: f64) -> Result<f64, String> {
	if b == 0.0 {
		return Err("division by zero".to_string());
	}
	Ok(a / b)
}

fn compute() -> Result<f64, String> {
	let result = divide(10.0, 2.0)?;   // propagates Err automatically, or unwraps Ok
	Ok(result * 2.0)
}

match divide(10.0, 0.0) {
	Ok(value) => println!("{}", value),
	Err(e) => println!("error: {}", e),
}
```

See [`example.rs`](./example.rs) for the full runnable file.

## Common mistakes

1. **Calling `.unwrap()`/`.expect()` outside of tests or genuinely "this can never fail" situations.** Both panic on `Err`/`None` — fine for a quick script or when a failure truly is a bug, but production code that can encounter real failures should handle `Result`/`Option` explicitly (`match`, `?`, `.unwrap_or`, etc.).
2. **Using `panic!` for expected, recoverable failure conditions** (like "file not found" or "invalid user input") — that's what `Result` is for; `panic!` should signal a genuine bug or truly unrecoverable state.
3. **Forgetting `?` requires the function's return type to be compatible with the error being propagated** (or convertible via `From`) — mixing error types across a call chain without a conversion is a common early compile error.
4. **Ignoring a `Result` entirely** by not doing anything with it — the compiler warns (`unused_result` on `#[must_use]` types like `Result`) rather than silently discarding a possible failure, though it's still possible to explicitly ignore one with `let _ = ...` when genuinely intentional.

## Exercise

Write `fn safe_divide(a: f64, b: f64) -> Option<f64>` returning `Some(a / b)`, or `None` if `b == 0.0`.

Try it yourself first, then check [`solutions/exercise_1.rs`](./solutions/exercise_1.rs).

## Interview questions

1. **Why does Rust use `Result`/`Option` instead of exceptions?** — Makes the possibility of failure/absence part of the function's type signature, visible at every call site and checked by the compiler — a caller can't accidentally "forget" to consider the error case the way an uncaught exception can silently propagate in exception-based languages.
2. **What does the `?` operator actually do?** — On `Err(e)` (or `None`), it returns early from the current function with that `Err`/`None` (converting the error type via `From` if needed); on `Ok(v)` (or `Some(v)`), it unwraps to `v` and execution continues — equivalent to a `match` with an early return in the error arm, in one character.

---
← [Previous: OOP](../08_oop/README.md) | [Next: Files and I/O →](../10_files/README.md)
