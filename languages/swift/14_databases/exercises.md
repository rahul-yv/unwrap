# Exercises: Databases

1. Write a function `func getUserName(_ db: OpaquePointer?, id: Int64) -> String?` that returns the user's name for a given `id` via a parameterized query, or `nil` if no row matches.

Check your answer against [`Sources/exercise_1/main.swift`](./Sources/exercise_1/main.swift) (run with `swift run exercise_1`).
