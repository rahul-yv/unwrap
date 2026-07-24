# Error Handling

Python uses exceptions, not error return codes, for exceptional conditions. `try`/`except`/`else`/`finally` covers catching, "only if no exception," and "always run" respectively. Custom exceptions subclass `Exception` (or a more specific built-in).

## Example

```python
def divide(a, b):
    try:
        result = a / b
    except ZeroDivisionError:
        raise ValueError("cannot divide by zero") from None
    else:
        return result          # runs only if no exception was raised
    finally:
        pass                    # runs whether or not an exception occurred


class InsufficientFundsError(Exception):
    def __init__(self, balance, amount):
        super().__init__(f"cannot withdraw {amount}, balance is {balance}")
        self.balance = balance
        self.amount = amount
```

See [`example.py`](./example.py) for the full runnable file.

## Common mistakes

1. **Catching `Exception` (or bare `except:`) broadly** and silently swallowing errors that should have surfaced — this hides real bugs. Catch the specific exception type you know how to handle.
2. **Using exceptions for ordinary control flow** where a normal `if`/`return` would be clearer — exceptions should signal exceptional conditions, not routine branching.
3. **Losing the original traceback** by re-raising a new exception without `raise ... from err` (or bare `raise` to re-raise the current one) — makes debugging much harder since the root cause is lost.
4. **Forgetting that `finally` runs even if the `try` block returns** — a `return` inside `finally` silently overrides a `return` from `try`, which is almost always a bug.

## Exercise

Write a function `safe_divide(a, b)` that returns `a / b`, or `None` if `b` is zero (catch `ZeroDivisionError` rather than checking `b == 0` beforehand — practice handling the exception, not avoiding it).

Try it yourself first, then check [`solutions/exercise_1.py`](./solutions/exercise_1.py).

## Interview questions

1. **What's the difference between `except Exception` and a bare `except:`?** — Bare `except:` also catches `BaseException` subclasses like `KeyboardInterrupt` and `SystemExit`, which usually should propagate; `except Exception` excludes those.
2. **What does `raise NewError(...) from original_error` do?** — Chains the new exception to the original, preserving both tracebacks in the output (`__cause__`), instead of hiding what actually triggered the failure.
3. **When does the `else` clause of a `try` run, and why not just put that code at the end of `try`?** — `else` runs only if the `try` block raised nothing; keeping it separate means it isn't accidentally wrapped by the `except` clauses, so an exception raised in `else` won't be caught by the preceding `except`.

---
← [Previous: OOP](../08_oop/README.md) | [Next: Files and I/O →](../10_files/README.md)
