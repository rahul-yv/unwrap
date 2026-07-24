# Exercises: Modules and Packages

1. Using an inline module `mod mypackage { pub fn greet(name: &str) -> String { ... } }`, write `fn example_usage() -> String` returning `mypackage::greet("World")`.
   - `example_usage()` → `"Hello, World!"`

Check your answer against [`solutions/exercise_1.rs`](./solutions/exercise_1.rs).
