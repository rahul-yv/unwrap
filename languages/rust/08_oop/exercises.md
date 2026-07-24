# Exercises: OOP

1. Define `struct Rectangle { width: f64, height: f64 }`, deriving `PartialEq`.
2. Implement `fn area(&self) -> f64` returning `width * height`.
   - `Rectangle { width: 3.0, height: 4.0 }.area()` → `12.0`
   - Two rectangles with equal fields should be `==`.

Check your answer against [`solutions/exercise_1.rs`](./solutions/exercise_1.rs).
