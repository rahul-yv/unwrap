# Testing

Rust's testing support is built into the toolchain: no external framework needed. A function annotated `#[test]` inside a `#[cfg(test)] mod tests { ... }` block is a test case, run with `cargo test` (or `rustc --test` directly, without Cargo). `#[cfg(test)]` means the test module is compiled only when testing — it doesn't bloat the normal binary.

## Example

```rust
pub fn add(a: i32, b: i32) -> i32 {
	a + b
}

#[cfg(test)]
mod tests {
	use super::*;   // bring the parent module's items into scope

	#[test]
	fn adds_positive_numbers() {
		assert_eq!(add(2, 3), 5);
	}

	#[test]
	fn adds_negative_numbers() {
		assert_eq!(add(-2, -3), -5);
	}
}
```

Run with `rustc --test example.rs -o example_test && ./example_test`. See [`example.rs`](./example.rs) for the full file (both the code under test and its tests, in one file — the idiomatic Rust convention for unit tests).

## Common mistakes

1. **Forgetting `#[cfg(test)]` on the tests module.** Without it, the test module (and anything it uses, like the `test` crate features) compiles into the normal binary too — `#[cfg(test)]` ensures test code and its dependencies only exist during test builds.
2. **Forgetting `use super::*;`** inside the `tests` module, then being unable to reference the parent module's functions — the `tests` module is a genuinely separate module and needs its own explicit import of what it wants to test.
3. **One `#[test]` function covering many unrelated behaviors.** If it fails, you can't tell which assertion broke without reading the panic message closely — one behavior per `#[test]` function, named for what it checks.
4. **Not testing edge cases** — empty input, zero, negative numbers — only the happy path misses the bugs that actually show up in production.

## Exercise

Given `example.rs`'s `add(a: i32, b: i32) -> i32`, write `#[test]` functions checking `add(0, 0) == 0` and `add(-1, 1) == 0`.

Try it yourself first, then check [`solutions/exercise_1.rs`](./solutions/exercise_1.rs).

## Interview questions

1. **Why put tests in the same file as the code under test, inside a `#[cfg(test)]` module?** — It's Rust's idiomatic convention for unit tests: keeps tests close to what they verify, and `#[cfg(test)]` guarantees the test code (and its imports) never ships in the release binary, at zero runtime cost.
2. **What does `use super::*;` do inside a `tests` module?** — Imports everything from the parent module (where `tests` is nested) into scope, so test functions can call the functions/types being tested without repeating a full path.

---
← [Previous: Modules and Packages](../11_modules_packages/README.md) | Next: Networking (coming soon)
