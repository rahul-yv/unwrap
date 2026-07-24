# Collections

Python's built-in collections are `list` (ordered, mutable), `tuple` (ordered, immutable), `dict` (key-value, insertion-ordered since 3.7), and `set`/`frozenset` (unordered, unique elements). Comprehensions build any of these concisely from an iterable.

## Example

```python
nums = [1, 2, 3, 4, 5]
squares = [n * n for n in nums]              # list comprehension
evens = {n for n in nums if n % 2 == 0}       # set comprehension
by_parity = {n: "even" if n % 2 == 0 else "odd" for n in nums}  # dict comprehension

point = (3, 4)          # tuple: immutable
x, y = point            # unpacking

d = {"a": 1, "b": 2}
d.get("c", 0)            # 0 — safe lookup with default, no KeyError
```

See [`example.py`](./example.py) for the full runnable file.

## Common mistakes

1. **Using `d[key]` when the key might be missing**, causing a `KeyError`. Use `d.get(key, default)`, or `key in d` to check first, depending on whether a missing key is expected or exceptional.
2. **Assuming `set`/`dict` preserve insertion order the way you'd expect from other languages.** `dict` does preserve insertion order (guaranteed since 3.7); plain `set` does not — never rely on set iteration order.
3. **Using a `list` where a `tuple` communicates intent better** — e.g. returning a fixed-size, never-mutated pair like coordinates. Tuples signal "this shape won't change"; lists signal "this may grow/shrink."
4. **Writing a nested loop to deduplicate** when `set(items)` (or `dict.fromkeys(items)` to preserve order) does it in one line.

## Exercise

Write a function `word_counts(words)` that takes a list of strings and returns a dict mapping each word to how many times it appears, using a dict comprehension or `collections.Counter` — not a manual loop with `if word in counts`.

Try it yourself first, then check [`solutions/exercise_1.py`](./solutions/exercise_1.py).

## Interview questions

1. **When would you choose a `tuple` over a `list`?** — When the collection has a fixed size/shape and shouldn't be mutated; tuples are also hashable (usable as dict keys) when their contents are hashable, unlike lists.
2. **What's the time complexity of `x in some_list` vs `x in some_set`?** — O(n) for a list (linear scan); O(1) average for a set (hash lookup). Prefer a set for membership testing on anything beyond a handful of items.
3. **Why can't you use a `list` as a dict key?** — Dict keys must be hashable, and lists are mutable (their hash would change if mutated, breaking the hash table invariant), so Python disallows it. Tuples work if all their elements are hashable.

---
← [Previous: Functions](../06_functions/README.md) | [Next: OOP →](../08_oop/README.md)
