# Exercises: Error Handling

1. Write `double safe_divide(double a, double b)` throwing `std::invalid_argument` if `b == 0`, otherwise returning `a / b`. Demonstrate both paths in `main` with a `try`/`catch`.
   - `safe_divide(10, 2)` → `5`
   - `safe_divide(10, 0)` → throws `std::invalid_argument`

Check your answer against [`solutions/exercise_1.cpp`](./solutions/exercise_1.cpp).
