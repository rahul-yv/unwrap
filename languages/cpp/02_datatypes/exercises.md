# Exercises: Data Types

1. Write `std::optional<int> safe_divide(int a, int b)` returning the quotient, or `std::nullopt` if `b == 0`.
   - `safe_divide(10, 2)` → `std::optional{5}`
   - `safe_divide(10, 0)` → `std::nullopt`

Check your answer against [`solutions/exercise_1.cpp`](./solutions/exercise_1.cpp).
