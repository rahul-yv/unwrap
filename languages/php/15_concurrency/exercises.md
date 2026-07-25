# Exercises: Concurrency

1. Write a function `function sumConcurrently(array $numbers): int` that splits `$numbers` into two halves, sums each half in a forked child process, and combines the results (communicated back via a socket pair).

Check your answer against [`solutions/exercise_1.php`](./solutions/exercise_1.php).
