# Testing

Node ships a built-in test runner (`node:test`, stable since Node 20) with `assert` from the standard library — no dependency needed for basic unit tests. The wider ecosystem often uses Jest or Vitest for richer features (snapshot testing, mocking, watch mode), but the core ideas are the same across all of them.

## Example

```javascript
// code under test
function add(a, b) {
  return a + b;
}
module.exports = { add };
```

```javascript
const test = require("node:test");
const assert = require("node:assert");
const { add } = require("./example.js");

test("adds positive numbers", () => {
  assert.strictEqual(add(2, 3), 5);
});

test("adds negative numbers", () => {
  assert.strictEqual(add(-2, -3), -5);
});
```

Run with `node --test test_example.js`. See [`example.js`](./example.js) (code under test) and [`test_example.js`](./test_example.js) (the tests).

## Common mistakes

1. **Testing implementation details instead of behavior** — asserting internal call counts or private state instead of the function's actual output for given input. Implementation-detail tests break on harmless refactors.
2. **One test covering many unrelated behaviors.** If it fails, you can't tell which behavior broke. One `test(...)` block per behavior, named for what it checks.
3. **Not testing edge cases** — empty arrays, zero, negative numbers, `null`/`undefined` — only the happy path misses the bugs that actually surface in production.
4. **Async tests that forget to `await` the assertion**, letting the test function return before the assertion actually runs — the test then passes even if the assertion would have failed.

## Exercise

Given `example.js`'s `add(a, b)`, write a `node:test` test checking `add(0, 0) === 0` and `add(-1, 1) === 0`.

Try it yourself first, then check [`solutions/exercise_1.js`](./solutions/exercise_1.js).

## Interview questions

1. **What's the difference between a unit test and an integration test?** — A unit test isolates one function/module (dependencies mocked/stubbed); an integration test exercises multiple real components together.
2. **Why must an async test `await` its assertions?** — If the test function returns (or the promise resolves) before an async assertion completes, the test runner may mark it as passed regardless of whether the assertion would have failed.
3. **What makes a test "flaky"?** — It passes/fails inconsistently with no code change — usually caused by relying on real timers, network calls, unseeded randomness, or shared mutable state between tests.

---
← [Previous: Modules and Packages](../11_modules_packages/README.md) | Next: Networking (coming soon)
