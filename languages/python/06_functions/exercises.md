# Exercises: Functions

1. Write `make_counter()` that returns a zero-argument function; each call to the returned function returns an incrementing count starting at 1. Use a closure — no globals, no classes.

   ```python
   counter = make_counter()
   counter()  # 1
   counter()  # 2
   counter()  # 3
   ```

Check your answer against [`solutions/exercise_1.py`](./solutions/exercise_1.py).
