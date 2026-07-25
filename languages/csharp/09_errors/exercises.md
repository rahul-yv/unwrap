# Exercises: Error Handling

1. Write `double SafeDivide(double a, double b)` throwing `DivideByZeroException` if `b == 0`, otherwise returning `a / b`. Demonstrate both the success and caught-exception paths.
   - `SafeDivide(10, 2)` → `5`
   - `SafeDivide(10, 0)` → throws `DivideByZeroException`

Check your answer against [`solutions/exercise_1.cs`](./solutions/exercise_1.cs).
