# Exercises: Concurrency

1. Write `long sum_concurrently(const int *numbers, int len)` splitting `numbers` into two halves, summing each half on its own thread, and returning the combined total. Give each thread a struct with its slice's pointer, length, and a partial-sum output field.
   - `sum_concurrently((int[]){1, 2, 3, 4}, 4)` → `10`

Compile with `cc solutions/exercise_1.c -o exercise_1 -lpthread`.

Check your answer against [`solutions/exercise_1.c`](./solutions/exercise_1.c).
