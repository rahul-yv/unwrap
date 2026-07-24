# Data Types

Python is dynamically typed: a variable can hold any type, and the type is checked at runtime. The built-in scalar types are `int` (arbitrary precision, no overflow), `float` (IEEE 754 double), `bool` (a subtype of `int`), `str` (immutable Unicode text), and `NoneType` (the single value `None`).

## Example

```python
n = 10          # int, arbitrary precision
pi = 3.14159    # float
name = "Ada"    # str, immutable
ok = True       # bool, subtype of int: True == 1
nothing = None  # NoneType

print(type(n), isinstance(n, int))
```

See [`example.py`](./example.py) for the full runnable file.

## Common mistakes

1. **Comparing floats with `==`.** `0.1 + 0.2 == 0.3` is `False` due to binary floating-point representation. Use `math.isclose(a, b)` instead.
2. **Forgetting `bool` is an `int` subtype.** `True + True == 2` is valid and `isinstance(True, int)` is `True` — this can silently pass type checks that only test `isinstance(x, int)`.
3. **Assuming `int` division behaves like other languages.** `7 / 2 == 3.5` (true division, always returns `float`); use `7 // 2 == 3` for floor division.
4. **Treating `None` and `False`/`0`/`""` as the same "falsy" thing** when the code actually needs to distinguish "no value" from "empty/zero value" — use `is None` explicitly rather than a bare truthiness check when that distinction matters.

## Exercise

Write a function `describe(value)` that returns a string: `"int"`, `"float"`, `"str"`, `"bool"`, or `"none"` describing the runtime type of `value`. `True`/`False` must report `"bool"`, not `"int"` (watch out for common mistake #2 above).

Try it yourself first, then check [`solutions/exercise_1.py`](./solutions/exercise_1.py).

## Interview questions

1. **Why is `True == 1` and `True is not 1`?** — `bool` is a subtype of `int`, so `True` equals `1` by value, but `is` checks object identity, and `True`/`1` are distinct objects.
2. **Why does `0.1 + 0.2 != 0.3`?** — Binary floating point can't represent most decimal fractions exactly; the stored values are close approximations, and their sum isn't bit-identical to the stored approximation of `0.3`.
3. **What's the difference between `is` and `==`?** — `==` compares values (calls `__eq__`); `is` compares object identity. Use `is` only for singletons like `None`, `True`, `False`.

---
← [Previous: Variables](../01_variables/README.md) | [Next: Operators →](../03_operators/README.md)
