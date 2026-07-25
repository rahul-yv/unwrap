# Exercises: Error Handling

1. Write a function `fun safeParseInt(s: String): Result<Int>` that parses `s` as an `Int`, returning `Result.success` or `Result.failure` (catching `NumberFormatException`) instead of letting the exception propagate.

Check your answer against [`solutions/exercise_1.kt`](./solutions/exercise_1.kt).
