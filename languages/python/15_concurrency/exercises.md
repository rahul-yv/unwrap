# Exercises: Concurrency

1. Write `count_up_concurrently(n_threads, per_thread)` that starts `n_threads` threads, each incrementing a shared counter `per_thread` times under a `threading.Lock`, joins all threads, and returns the final count.
   - `count_up_concurrently(4, 10_000)` → `40000`

Check your answer against [`solutions/exercise_1.py`](./solutions/exercise_1.py).
