# Exercises: Concurrency

1. Write an async function `func sumConcurrently(_ numbers: [Int]) async -> Int` that splits `numbers` into two halves, sums each half in its own child task via `withTaskGroup`, and combines the results.

Check your answer against [`solutions/exercise_1.swift`](./solutions/exercise_1.swift).
