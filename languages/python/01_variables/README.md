# Variables

A variable is a name bound to a value. Python variables have no declared type — the name just points at an object, and that object carries its own type. Assigning a new value rebinds the name; it doesn't mutate the old object unless the object itself is mutable and you call a method on it.

## Example

```python
age = 25
name = "Ada"
age = age + 1          # rebinds `age` to a new int object
first, second = 1, 2   # tuple unpacking
a = b = 0               # both names bound to the same object
```

See [`example.py`](./example.py) for the full runnable file.

## Common mistakes

1. **Assuming assignment copies mutable objects.** `b = a` makes `b` point at the *same* list as `a`; mutating one affects both. Use `b = a.copy()` (or `list(a)`) to get an independent copy.
2. **Confusing rebinding with mutation.** `a += 1` on an int rebinds `a` to a new object (ints are immutable). `a.append(1)` on a list mutates the same object in place. These look similar but behave very differently when the object is shared.
3. **Using a mutable default argument as if it resets each call.** Not strictly a variables issue, but it comes from the same misunderstanding — see `06_functions` for the full explanation.
4. **Shadowing a builtin name**, e.g. `list = [1, 2, 3]`, which then breaks any later use of `list(...)` in that scope.

## Exercise

Write a function `swap(a, b)` that returns `(b, a)` — the two values swapped — using tuple unpacking, not a temporary variable.

Try it yourself first, then check [`solutions/exercise_1.py`](./solutions/exercise_1.py).

## Interview questions

1. **What does `a = b = []` do, and why is it usually a bug if you then treat `a` and `b` as independent lists?** — Both names bind to the *same* list object; mutating one mutates both.
2. **Why does `id(a) == id(b)` hold for `a = 1; b = 1` but not always for larger integers or non-cached objects?** — CPython caches small integers (-5 to 256) and interns some strings, so small ints/short strings may share identity by implementation detail, not language guarantee. Never rely on this.

---
← Previous: (start) | [Next: Data Types →](../02_datatypes/README.md)
