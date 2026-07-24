# Conditionals

Python has `if`/`elif`/`else`, a ternary expression (`x if cond else y`), and — since 3.10 — structural pattern matching (`match`/`case`). There's no `switch` statement in the classic C sense; `match` fills that role with more power (structural destructuring, not just value equality).

## Example

```python
score = 85
if score >= 90:
    grade = "A"
elif score >= 80:
    grade = "B"
else:
    grade = "C"

label = "pass" if score >= 60 else "fail"   # ternary expression

match score:
    case s if s >= 90:
        grade2 = "A"
    case s if s >= 80:
        grade2 = "B"
    case _:
        grade2 = "C"
```

See [`example.py`](./example.py) for the full runnable file.

## Common mistakes

1. **Writing `if x == True:` instead of `if x:`.** Redundant and fragile — if `x` is a truthy non-bool value, `== True` fails even though `if x:` would pass.
2. **Forgetting Python has no block-scoping for `if`.** Variables assigned inside an `if` block are visible after it (unlike C-family block scope) — this is normal in Python, but it means a variable might be unbound if the branch that sets it never ran; guard with an `else` or check `is not None` before use.
3. **Using nested `if`/`elif` chains where `match` on structure would be clearer**, e.g. matching on the shape of a tuple or the type of an object — `match` can destructure directly (`case (x, y):`), which a plain `if` chain has to do manually.
4. **Confusing `elif` with a `switch`'s guaranteed single evaluation** — each `elif` condition is a fresh expression evaluation; if conditions have side effects, be aware they only run until the first match.

## Exercise

Write a function `grade(score)` that returns `"A"` for `score >= 90`, `"B"` for `score >= 80`, `"C"` for `score >= 70`, and `"F"` otherwise.

Try it yourself first, then check [`solutions/exercise_1.py`](./solutions/exercise_1.py).

## Interview questions

1. **What's the difference between `match`/`case` and a chain of `if`/`elif`?** — `match` can destructure the *structure* of the subject (tuples, lists, dict keys, class attributes via `case Point(x=0, y=y):`), not just compare values; `if`/`elif` only test boolean expressions.
2. **Why is `if x == True:` considered bad style?** — It's redundant (`if x:` already tests truthiness) and breaks for truthy non-bool values compared strictly against `True`.

---
← [Previous: Operators](../03_operators/README.md) | [Next: Loops →](../05_loops/README.md)
