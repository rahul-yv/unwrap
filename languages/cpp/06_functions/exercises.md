# Exercises: Functions

1. Write `std::function<int()> make_counter()` returning a callable; each call returns an incrementing count starting at 1. Use a lambda with `mutable` capturing a counter by value (or a shared state).

   ```cpp
   auto counter = make_counter();
   counter();  // 1
   counter();  // 2
   ```

Check your answer against [`solutions/exercise_1.cpp`](./solutions/exercise_1.cpp).
