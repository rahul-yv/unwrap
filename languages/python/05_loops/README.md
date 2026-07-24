# Loops

Python has `for` (iterates over any iterable — not a C-style counter loop) and `while`. There's no classic `for (i = 0; i < n; i++)` form; use `range(n)` for counting. Both loop types support an `else` clause that runs only if the loop finishes without `break` — a feature most languages don't have.

## Example

```python
for i in range(3):
    print(i)          # 0, 1, 2

for item in ["a", "b", "c"]:
    print(item)

n = 0
while n < 3:
    n += 1

for i in range(5):
    if i == 3:
        break
else:
    print("never runs: loop was broken")   # skipped because of the break
```

See [`example.py`](./example.py) for the full runnable file.

## Common mistakes

1. **Mutating a list while iterating over it.** `for x in items: items.remove(x)` skips elements because the indices shift under you. Iterate over a copy (`for x in items[:]`) or build a new list instead.
2. **Reaching for `range(len(items))` plus indexing** when `for item in items` (or `enumerate(items)` if you need the index) is clearer and avoids off-by-one errors.
3. **Not knowing about the `for`/`while` `else` clause** and reimplementing it with a manual flag variable to detect "loop completed without break."
4. **Off-by-one with `range`.** `range(n)` is `0..n-1`; `range(1, n+1)` is needed to count `1..n` inclusive.

## Exercise

Write a function `first_even(numbers)` that returns the first even number in a list, or `None` if there isn't one. Use a `for`/`else` to make the "not found" case explicit rather than a separate flag variable.

Try it yourself first, then check [`solutions/exercise_1.py`](./solutions/exercise_1.py).

## Interview questions

1. **What does the `else` clause on a `for` loop do?** — Runs only if the loop completes without hitting `break`. Useful for "search and if not found, do X" without a flag variable.
2. **Why is mutating a list while iterating over it dangerous?** — The iterator tracks a position by index; removing/inserting shifts subsequent elements' indices, causing skipped or repeated items.

---
← [Previous: Conditionals](../04_conditions/README.md) | [Next: Functions →](../06_functions/README.md)
