# Exercises: Data Types

1. Write `int32_t safe_add(int32_t a, int32_t b, int *overflowed)` adding `a` and `b`, setting `*overflowed = 1` if the result would overflow `int32_t` (check the range *before* adding), otherwise `*overflowed = 0`.
   - `safe_add(10, 20, &flag)` → `30`, `flag == 0`
   - `safe_add(INT32_MAX, 1, &flag)` → (unspecified return), `flag == 1`

Check your answer against [`solutions/exercise_1.c`](./solutions/exercise_1.c).
