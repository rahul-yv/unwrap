# Exercises: Functions

1. Write `int apply_twice(int (*fn)(int), int x)` returning `fn(fn(x))`.

   ```c
   int increment(int x) { return x + 1; }
   apply_twice(increment, 5);  // 7
   ```

Check your answer against [`solutions/exercise_1.c`](./solutions/exercise_1.c).
