# Testing

Python ships `unittest` in the standard library; the wider ecosystem mostly uses `pytest` for its plain-`assert` style and fixtures, but both discover and run tests the same conceptual way: find functions/methods that check behavior, run them, report pass/fail. This lesson uses `unittest` so the examples run with no extra install.

## Example

```python
# code under test
def add(a, b):
    return a + b
```

```python
import unittest

class TestAdd(unittest.TestCase):
    def test_positive_numbers(self):
        self.assertEqual(add(2, 3), 5)

    def test_negative_numbers(self):
        self.assertEqual(add(-2, -3), -5)

if __name__ == "__main__":
    unittest.main()
```

Run with `python -m unittest test_example.py`. See [`example.py`](./example.py) (code under test) and [`test_example.py`](./test_example.py) (the tests) for the full runnable files.

## Common mistakes

1. **Testing implementation details instead of behavior** — e.g. asserting a private helper was called a specific way, rather than asserting the public function returns the right output. Implementation-detail tests break on harmless refactors.
2. **One giant test that checks many unrelated things** — if it fails, you don't know which part broke. Prefer one behavior per test function, named for what it checks (`test_negative_numbers`, not `test_1`).
3. **Not testing edge cases** — empty input, zero, negative numbers, `None` — only testing the "happy path" misses the bugs that actually show up in production.
4. **Tests that depend on execution order or shared mutable state** between test methods — each test should set up its own state and be runnable in isolation, in any order.

## Exercise

Given `example.py`'s `add(a, b)` function, write a test (in `unittest` style) that checks `add(0, 0) == 0` and `add(-1, 1) == 0`.

Try it yourself first, then check [`solutions/exercise_1.py`](./solutions/exercise_1.py).

## Interview questions

1. **What's the difference between a unit test and an integration test?** — A unit test checks one function/class in isolation (dependencies mocked/stubbed); an integration test checks multiple components working together (e.g. a function that actually hits a database).
2. **Why should tests be independent of execution order?** — Shared mutable state between tests makes failures order-dependent and hard to reproduce; each test should arrange its own state and clean up after itself.
3. **What is a "flaky" test, and what commonly causes it?** — A test that sometimes passes and sometimes fails with no code change; common causes are relying on real time/dates, network calls, unseeded randomness, or shared state between tests.

---
← [Previous: Modules and Packages](../11_modules_packages/README.md) | [Next: Networking →](../13_networking/README.md)
