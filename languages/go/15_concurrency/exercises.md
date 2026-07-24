# Exercises: Concurrency

1. Write `sumConcurrently(numbers []int) int` splitting `numbers` into two halves, summing each half in its own goroutine, and combining the results via a channel (not a shared variable with a mutex).
   - `sumConcurrently([]int{1, 2, 3, 4})` → `10`

Check your answer against [`solutions/exercise_1.go`](./solutions/exercise_1.go).
