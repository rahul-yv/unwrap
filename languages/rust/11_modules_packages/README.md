# Modules and Packages

A Rust module (`mod`) groups related items and controls visibility — everything is private by default; `pub` makes an item visible outside its module. A module can live inline (`mod name { ... }` in the same file) or in a separate file (`mod name;` pulls in `name.rs`, or `name/mod.rs`). A **crate** is a compilation unit (a binary or library); a **package** (what `Cargo.toml` describes) can contain multiple crates.

## Example

```rust
// mypackage.rs — a separate file, pulled in below
pub fn greet(name: &str) -> String {
	format!("Hello, {}!", name)
}
```

```rust
// main.rs
mod mypackage;   // pulls in mypackage.rs as a module

fn main() {
	println!("{}", mypackage::greet("Ada"));
}
```

See [`example.rs`](./example.rs) and [`mypackage.rs`](./mypackage.rs) for the full runnable files (compiled together as `rustc example.rs`, which automatically finds the sibling `mypackage.rs`).

## Common mistakes

1. **Forgetting items are private by default.** A function/struct/field without `pub` is invisible outside its own module — a very common "why can't I access this" moment coming from languages where everything is public unless marked otherwise.
2. **Confusing a crate with a package.** A package (one `Cargo.toml`) can contain a library crate plus multiple binary crates; "crate" refers to a single compiled unit, "package" to the whole thing Cargo manages together.
3. **Not realizing `mod name;` looks for `name.rs` (or `name/mod.rs`) relative to the *current file's* module, not always the crate root** — deeply nested modules follow the directory structure under their parent module's location, which trips people up in larger projects.
4. **Wildcard `use mypackage::*;`** to avoid listing individual imports — works, but obscures where a given name actually came from, same downside as in other languages.

## Exercise

Using an inline module `mod mypackage { pub fn greet(name: &str) -> String { ... } }`, write `fn example_usage() -> String` returning `mypackage::greet("World")`.

Try it yourself first, then check [`solutions/exercise_1.rs`](./solutions/exercise_1.rs).

## Interview questions

1. **How does Rust decide whether an item is visible outside its module?** — By the `pub` keyword: absent, an item is only visible within its own module (and descendant modules); `pub` makes it visible to anything that can reach the module itself, with `pub(crate)`/`pub(super)` available for narrower visibility.
2. **What's the difference between a crate and a package?** — A crate is a single compilation unit (one binary or one library); a package is what `Cargo.toml` describes, which can bundle a library crate together with one or more binary crates that depend on it.

---
← [Previous: Files and I/O](../10_files/README.md) | [Next: Testing →](../12_testing/README.md)
