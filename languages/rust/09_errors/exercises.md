# Exercises: Error Handling

1. Write `fn safe_divide(a: f64, b: f64) -> Option<f64>` returning `Some(a / b)`, or `None` if `b == 0.0`.
   - `safe_divide(10.0, 2.0)` → `Some(5.0)`
   - `safe_divide(10.0, 0.0)` → `None`

Check your answer against [`solutions/exercise_1.rs`](./solutions/exercise_1.rs).
