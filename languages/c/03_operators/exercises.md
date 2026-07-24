# Exercises: Operators

1. Write `int is_power_of_two(unsigned int n)` returning `1` if `n` is a nonzero power of two, `0` otherwise, using `n & (n - 1)`.
   - `is_power_of_two(8)` → `1`
   - `is_power_of_two(10)` → `0`
   - `is_power_of_two(0)` → `0`

Check your answer against [`solutions/exercise_1.c`](./solutions/exercise_1.c).
