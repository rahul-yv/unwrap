# Functions

Functions are first-class objects: they can be assigned to variables, passed as arguments, returned from other functions, and stored in collections. Python supports positional, keyword, default, `*args`, and `**kwargs` parameters, plus closures and decorators.

## Example

```python
def greet(name, greeting="Hello"):
    return f"{greeting}, {name}!"

greet("Ada")                    # "Hello, Ada!"
greet("Ada", greeting="Hi")     # "Hi, Ada!"

def total(*args, **kwargs):
    return sum(args) + sum(kwargs.values())

total(1, 2, x=3)   # 6

def make_multiplier(n):
    def multiplier(x):
        return x * n
    return multiplier   # closure: remembers `n`

double = make_multiplier(2)
double(5)   # 10
```

See [`example.py`](./example.py) for the full runnable file.

## Common mistakes

1. **Using a mutable default argument.** `def f(items=[]):` — the default list is created *once* at function definition time and shared across every call that doesn't pass its own `items`, so mutations accumulate across calls. Use `def f(items=None): items = items if items is not None else []`.
2. **Not understanding closures capture variables by reference, not by value.** A loop that creates closures over a loop variable (`[lambda: i for i in range(3)]`) captures the *same* `i`, so all three lambdas return `2`, not `0, 1, 2`. Fix with a default argument: `lambda i=i: i`.
3. **Overusing `*args`/`**kwargs`** where explicit named parameters would document the function's real interface — makes the signature unreadable and loses IDE/type-checker help.
4. **Forgetting a function without an explicit `return` returns `None`**, then being surprised when chaining or storing that `None` downstream.

## Exercise

Write a function `make_counter()` that returns a function taking no arguments; each call to the returned function returns an incrementing count starting at 1 (1, 2, 3, …), using a closure (no global variables, no classes).

Try it yourself first, then check [`solutions/exercise_1.py`](./solutions/exercise_1.py).

## Interview questions

1. **Why is a mutable default argument a common bug source?** — Defaults are evaluated once, at function-definition time, and the same object is reused on every call that omits the argument.
2. **What is a closure, and what does it capture?** — A function that references variables from an enclosing scope; it captures those variables by reference (the enclosing scope's cell), not a snapshot of their value at closure-creation time.
3. **What's the difference between `*args` and `**kwargs`?** — `*args` collects extra positional arguments into a tuple; `**kwargs` collects extra keyword arguments into a dict.

---
← [Previous: Loops](../05_loops/README.md) | [Next: Collections →](../07_collections/README.md)
