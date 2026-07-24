# Data Types

Rust has explicit-width integers (`i8`...`i128`, `u8`...`u128`, `isize`/`usize` for pointer-sized), `f32`/`f64`, `bool`, `char` (a 4-byte Unicode scalar value, not a byte), and `&str`/`String` for text — `&str` is a borrowed, immutable view into UTF-8 bytes; `String` is an owned, growable, heap-allocated string. Integer overflow panics in debug builds and wraps in release builds by default — different behavior per build profile, which surprises people coming from languages with one consistent behavior.

## Example

```rust
let n: i32 = 10;               // 32-bit signed, the default integer type
let big: i64 = 10_000_000_000;
let pi: f64 = 3.14159;          // f64 is the default float type
let c: char = 'A';               // a Unicode scalar value

let borrowed: &str = "hello";      // borrowed string slice
let owned: String = String::from("hello");  // owned, heap-allocated

let combined = owned + " world";    // String + &str, consumes `owned`
```

See [`example.rs`](./example.rs) for the full runnable file.

## Common mistakes

1. **Confusing `&str` and `String`.** `&str` is a borrowed view (can't outlive what it points to, can't grow); `String` owns its data. A function parameter taking `&str` accepts both a literal and a `&String` (via deref coercion), which is why `&str` is the idiomatic choice for read-only string parameters.
2. **Assuming integer overflow always panics.** It panics in debug builds (`cargo build`) but silently wraps around in release builds (`cargo build --release`) by default — a genuinely different behavior per build profile that catches people off guard; use `checked_add`/`wrapping_add`/`saturating_add` when the behavior needs to be explicit and consistent.
3. **Treating `char` like a byte.** A Rust `char` is always 4 bytes (a full Unicode scalar value), not a single byte of UTF-8 — indexing a `String` by byte position and expecting a `char` doesn't work directly; use `.chars()` to iterate by character.
4. **Using `String` everywhere by default** instead of `&str` for parameters that only need to read the string — needlessly forces callers to allocate/own a `String` even when a borrowed view would do.

## Exercise

Write `fn count_chars(s: &str) -> usize` returning the number of Unicode characters (not bytes) in `s`.

Try it yourself first, then check [`solutions/exercise_1.rs`](./solutions/exercise_1.rs).

## Interview questions

1. **Why does Rust have both `&str` and `String`?** — They serve different roles: `&str` is a lightweight, borrowed view (no allocation, can't grow) ideal for reading; `String` owns its heap-allocated buffer and can grow — the split lets function signatures express "I just need to read this" (`&str`) vs "I need to own/modify this" (`String`).
2. **What happens on integer overflow in Rust, and why does it differ between debug and release builds?** — Debug builds panic on overflow (safety during development); release builds wrap around by default for performance (skipping the overflow check) — code that needs guaranteed behavior either way should use the explicit `checked_*`/`wrapping_*`/`saturating_*` methods instead of relying on the build profile.

---
← [Previous: Variables](../01_variables/README.md) | [Next: Operators →](../03_operators/README.md)
