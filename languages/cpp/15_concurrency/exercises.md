# Exercises: Concurrency

1. Write `long sum_concurrently(const std::vector<int>& numbers)` splitting `numbers` into two halves, summing each half on its own `std::thread`, joining both, and returning the total.
   - `sum_concurrently({1, 2, 3, 4})` → `10`

Compile with `c++ solutions/exercise_1.cpp -o exercise_1 -pthread`.

Check your answer against [`solutions/exercise_1.cpp`](./solutions/exercise_1.cpp).
