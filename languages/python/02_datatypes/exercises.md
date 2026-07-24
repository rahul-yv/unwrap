# Exercises: Data Types

1. Write a function `describe(value)` that returns one of `"int"`, `"float"`, `"str"`, `"bool"`, `"none"` describing the runtime type of `value`.
   - `describe(5)` → `"int"`
   - `describe(True)` → `"bool"` (not `"int"`, even though `bool` is an `int` subtype)
   - `describe(3.14)` → `"float"`
   - `describe("hi")` → `"str"`
   - `describe(None)` → `"none"`

Check your answer against [`solutions/exercise_1.py`](./solutions/exercise_1.py).
