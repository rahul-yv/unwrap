# Collections

`Vec<T>` (growable array), `HashMap<K, V>` (no order guarantee), and `HashSet<T>` are the workhorse collections. Rust's iterator methods (`.map()`, `.filter()`, `.collect()`) are lazy and chain into pipelines, similar to streams in other languages, but resolved entirely at compile time with no runtime overhead ("zero-cost abstractions").

## Example

```rust
let nums = vec![1, 2, 3, 4, 5];
let squares: Vec<i32> = nums.iter().map(|n| n * n).collect();
let evens: Vec<&i32> = nums.iter().filter(|&&n| n % 2 == 0).collect();

use std::collections::HashMap;
let mut scores: HashMap<String, i32> = HashMap::new();
scores.insert(String::from("a"), 1);
let value = scores.get("a");            // Some(&1)
let missing = scores.get("z");           // None
let with_default = *scores.get("z").unwrap_or(&0);  // 0
```

See [`example.rs`](./example.rs) for the full runnable file.

## Common mistakes

1. **Calling `.unwrap()` on `HashMap::get`'s result without checking for `None` first.** `.get()` returns `Option<&V>` — a missing key isn't an error, it's `None`; `.unwrap()` on `None` panics. Use `.get(key).unwrap_or(&default)`, pattern matching, or `if let Some(v) = ...`.
2. **Forgetting `.iter()` borrows while `.into_iter()` consumes.** `for x in &vec` (or `vec.iter()`) borrows each element; `for x in vec` (or `vec.into_iter()`) takes ownership and the original `vec` is no longer usable afterward — pick based on whether you still need the collection.
3. **Collecting into the wrong type and hitting a confusing compile error.** `.collect()` is generic over its return type — the compiler needs to infer it from context (a type annotation, or how the result is used); `let result = iter.collect();` alone with no other type information won't compile.
4. **Iterating and mutating the same collection at once.** Like most languages, Rust's borrow checker specifically prevents this at compile time (`cannot borrow as mutable because it is also borrowed as immutable`) rather than allowing undefined behavior at runtime.

## Exercise

Write `fn word_counts(words: &[&str]) -> HashMap<String, i32>` returning a map from each word to its occurrence count.

Try it yourself first, then check [`solutions/exercise_1.rs`](./solutions/exercise_1.rs).

## Interview questions

1. **What does "zero-cost abstraction" mean in the context of Rust's iterator methods?** — Chains of `.map()`/`.filter()`/etc. compile down to the same machine code as an equivalent hand-written loop — the abstraction (readable, composable iterator methods) costs nothing at runtime compared to writing the loop manually.
2. **Why does `HashMap::get` return `Option<&V>` instead of `&V` or panicking?** — A missing key is an entirely normal, expected outcome, not an error — `Option` makes the caller handle both cases explicitly at compile time, rather than risking an unchecked `None`/null dereference at runtime.

---
← [Previous: Functions](../06_functions/README.md) | [Next: OOP →](../08_oop/README.md)
