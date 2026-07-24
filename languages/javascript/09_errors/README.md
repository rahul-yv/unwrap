# Error Handling

`try`/`catch`/`finally` handles synchronous errors; `async`/`await` functions let you `try`/`catch` around `await`ed promise rejections the same way. Custom errors extend the built-in `Error` class. An unhandled promise rejection is a common source of silent failures.

## Example

```javascript
class InsufficientFundsError extends Error {
  constructor(balance, amount) {
    super(`cannot withdraw ${amount}, balance is ${balance}`);
    this.name = "InsufficientFundsError";
    this.balance = balance;
    this.amount = amount;
  }
}

function divide(a, b) {
  if (b === 0) throw new Error("cannot divide by zero");
  return a / b;
}

try {
  divide(10, 0);
} catch (err) {
  console.error(err.message);
} finally {
  console.log("always runs");
}

async function fetchData() {
  try {
    return await Promise.reject(new Error("network down"));
  } catch (err) {
    return null;
  }
}
```

See [`example.js`](./example.js) for the full runnable file.

## Common mistakes

1. **Throwing/rejecting with a non-`Error` value** (`throw "oops"`) — loses the stack trace and makes `instanceof Error` checks fail; always throw `Error` instances (or subclasses).
2. **Forgetting to `catch` a rejected promise**, causing an unhandled rejection — in Node this can crash the process (depending on version/config); always `.catch()` or wrap `await` in `try`/`catch`.
3. **Using `catch` to swallow every error silently** with an empty block — hides real bugs. At minimum log it; ideally only catch errors you can actually handle.
4. **Mixing `.then()` chains with `async`/`await` inconsistently** in the same function — pick one style per function for readability; mixing them is a common source of subtle bugs around error propagation.

## Exercise

Write `safeDivide(a, b)` returning `a / b`, or `null` if `b` is `0`, using a thrown error caught locally (not a plain `if` check that skips the `throw`/`catch` mechanism — practice the pattern).

Try it yourself first, then check [`solutions/exercise_1.js`](./solutions/exercise_1.js).

## Interview questions

1. **What happens to an unhandled promise rejection in Node.js?** — It emits an `unhandledRejection` event and (depending on Node version/flags) can terminate the process; always attach a `.catch()` or use `try`/`catch` with `await`.
2. **Why extend `Error` for custom error types instead of throwing a plain object?** — `Error` instances carry a stack trace and work correctly with `instanceof` checks, `console.error` formatting, and tooling that expects real errors.
3. **How does `try`/`catch` interact with `async`/`await`?** — `await`ing a rejected promise throws synchronously at that point, so it can be caught by a surrounding `try`/`catch` exactly like a thrown exception.

---
← [Previous: OOP](../08_oop/README.md) | [Next: Files and I/O →](../10_files/README.md)
