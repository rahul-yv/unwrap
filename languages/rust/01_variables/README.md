# Variables

Rust variables are **immutable by default** — `let x = 5;` cannot be reassigned; `let mut x = 5;` opts into mutability explicitly. This is a deliberate design choice: immutability is the default because it's usually what you want, and the compiler catches accidental reassignment as an error rather than a runtime surprise. Rust also has **shadowing**: redeclaring `let x = ...` with the same name creates a new binding, optionally with a different type.

## Example

```rust
let age = 25;              // immutable by default
let mut count = 0;          // mut opts into reassignment
count += 1;

// age = 26;                 // compile error: cannot assign twice to immutable variable

let spaces = "   ";         // shadowing: same name, new binding, can even change type
let spaces = spaces.len();  // now spaces is a usize, not a &str

const MAX_RETRIES: u32 = 3; // const: always immutable, must have an explicit type, known at compile time
```

See [`example.rs`](./example.rs) for the full runnable file.

## Common mistakes

1. **Trying to reassign a `let` binding without `mut`.** `let x = 5; x = 6;` is a compile error, not a runtime one — the compiler catches every accidental mutation of something meant to be fixed.
2. **Confusing shadowing with mutation.** `let x = 5; let x = x + 1;` creates a *new* binding named `x` (can even change type); it isn't the same as `let mut x = 5; x += 1;`, which mutates the existing variable in place. They can look similar in simple cases but behave differently with closures or references.
3. **Forgetting `const` requires an explicit type annotation and a value computable at compile time.** Unlike `let`, `const MAX: u32 = 3;` can't infer the type, and can't be initialized from a runtime computation (like a function call that isn't `const fn`).
4. **Using `mut` defensively "just in case"** instead of only where reassignment is actually needed — fighting the compiler's immutable-by-default design instead of leaning into it; if a variable never changes, leaving off `mut` documents that intent and lets the compiler enforce it.

## Exercise

Write a function `fn swap(a: i32, b: i32) -> (i32, i32)` that returns `(b, a)`.

Try it yourself first, then check [`solutions/exercise_1.rs`](./solutions/exercise_1.rs).

## Interview questions

1. **Why is immutability the default in Rust, unlike most mainstream languages?** — It eliminates a whole class of bugs where a value is changed unexpectedly somewhere in a large function or across threads; the compiler enforces "this shouldn't change" as a checked property instead of a convention, and `mut` makes every place mutation happens visible and intentional.
2. **What's the difference between shadowing and mutation?** — Shadowing (`let x = ...` again) creates an entirely new variable (can change type, keeps the old value alive if still referenced elsewhere in memory until dropped); mutation (`x = ...` with `mut`) changes the same variable's value in place and cannot change its type.

---
← Previous: (start) | [Next: Data Types →](../02_datatypes/README.md)
