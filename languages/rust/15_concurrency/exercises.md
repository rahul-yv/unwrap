# Exercises: Concurrency

1. Write `fn sum_concurrently(numbers: Vec<i32>) -> i32` splitting `numbers` into two halves, summing each half on its own thread, and combining the results via an `mpsc` channel.
   - `sum_concurrently(vec![1, 2, 3, 4])` → `10`

Check your answer against [`solutions/exercise_1.rs`](./solutions/exercise_1.rs).
