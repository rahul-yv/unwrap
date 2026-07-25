# Exercises: Concurrency

1. Write a method `Task<int> SumConcurrentlyAsync(int[] numbers)` that splits `numbers` into two halves, sums each half on its own `Task.Run`, and combines the results with `Task.WhenAll`.

Check your answer against [`solutions/exercise_1.cs`](./solutions/exercise_1.cs).
