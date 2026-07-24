# Exercises: Error Handling

1. Write `safeDivide(a, b float64) (float64, error)` returning an error (via `errors.New`) instead of panicking when `b == 0`.
   - `safeDivide(10, 2)` → `(5, nil)`
   - `safeDivide(10, 0)` → `(0, error)`

Check your answer against [`solutions/exercise_1.go`](./solutions/exercise_1.go).
