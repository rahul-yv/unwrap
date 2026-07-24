# Exercises: Error Handling

1. Write `double safeDivide(double a, double b)` returning `a / b`, or `Double.NaN` if `b == 0` — throw an `ArithmeticException` yourself for the zero case and catch it locally, practicing the try/catch pattern.
   - `safeDivide(10, 2)` → `5.0`
   - `safeDivide(10, 0)` → `Double.NaN`

Check your answer against [`solutions/Exercise1.java`](./solutions/Exercise1.java).
