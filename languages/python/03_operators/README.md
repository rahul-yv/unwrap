# Operators

Python has the usual arithmetic, comparison, and logical operators, plus a few that surprise people coming from C-family languages: `//` (floor division), `**` (power), chained comparisons, and `and`/`or` that return one of their operands rather than a strict `bool`.

## Example

```python
7 // 2        # 3   (floor division)
7 % 2         # 1   (modulo)
2 ** 10       # 1024 (power)
1 < 2 < 3     # True (chained comparison, equivalent to 1 < 2 and 2 < 3)
"" or "fallback"   # "fallback" — `or` returns the first truthy operand, or the last one
0 and "x"     # 0   — `and` returns the first falsy operand, or the last one
```

See [`example.py`](./example.py) for the full runnable file.

## Common mistakes

1. **Expecting `and`/`or` to always return `True`/`False`.** They short-circuit and return one of the *operands*, not a coerced boolean. `x = value or default` relies on this — but it also means `0 or "fallback"` returns `"fallback"`, which is a bug if `0` was a valid value.
2. **Using `//` and expecting truncation toward zero.** Floor division rounds toward negative infinity: `-7 // 2 == -4`, not `-3`.
3. **Chaining comparisons incorrectly assumed to work like other languages.** `1 < 2 < 3` is valid Python and means `1 < 2 and 2 < 3` — but `(1 < 2) < 3` (explicitly parenthesized) evaluates the bool `True` as `1`, giving a different, easy-to-misread result.
4. **Using `is` instead of `==` for value comparison** (e.g. `if x is 5`) — relies on CPython's small-int caching, not a language guarantee, and does the wrong thing for larger numbers or non-cached objects.

## Exercise

Write a function `clamp(value, low, high)` that returns `value` restricted to the range `[low, high]` — if `value < low` return `low`, if `value > high` return `high`, otherwise return `value`. Do it without an `if`/`else` chain, using `max`/`min`.

Try it yourself first, then check [`solutions/exercise_1.py`](./solutions/exercise_1.py).

## Interview questions

1. **What does `a or b` evaluate to if `a` is truthy?** — `a` itself, not `True`. `or` short-circuits and returns the operand value.
2. **Why is `-7 // 2` equal to `-4`, not `-3`?** — Floor division always rounds toward negative infinity, not toward zero.

---
← [Previous: Data Types](../02_datatypes/README.md) | [Next: Conditionals →](../04_conditions/README.md)
