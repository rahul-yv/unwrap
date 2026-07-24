# Exercises: Concurrency

1. Write `int sumConcurrently(int[] numbers) throws InterruptedException` splitting `numbers` into two halves, summing each half on its own `Thread`, and combining the results after both finish (via `join()`).
   - `sumConcurrently(new int[]{1, 2, 3, 4})` → `10`

Check your answer against [`solutions/Exercise1.java`](./solutions/Exercise1.java).
