# Testing

Test runners work the same as in the JavaScript track's `12_testing` (Node's built-in `node:test`) — write the tests in TypeScript, compile alongside the rest of the project, then run the compiled JavaScript with `node --test`. TypeScript adds compile-time checking to the test file itself: a test that calls a function with the wrong argument types fails to compile, catching a whole class of "the test itself is wrong" mistakes before it ever runs.

## Example

```typescript
// code under test
export function add(a: number, b: number): number {
	return a + b;
}
```

```typescript
import test from "node:test";
import assert from "node:assert";
import { add } from "./example";

test("adds positive numbers", () => {
	assert.strictEqual(add(2, 3), 5);
});

// add("2", 3);   // would be a compile error: caught before the test even runs
```

Compile with `tsc`, then run with `node --test dist/12_testing/test_example.js`. See [`example.ts`](./example.ts) and [`test_example.ts`](./test_example.ts).

## Common mistakes

1. **Typing test inputs as `any`** to avoid fixing a type mismatch — defeats the point of writing tests in TypeScript, since a genuinely wrong call (wrong argument type) should fail to compile, not silently run with the wrong data.
2. **Not testing edge cases just because the types "look right."** Type correctness (the shape/type of the data) says nothing about logical correctness (whether the function behaves correctly for empty input, zero, negative numbers) — both matter, and types only catch the first kind of bug.
3. **One test covering many unrelated behaviors** — same pitfall as any language; if it fails, you can't tell which behavior broke.
4. **Forgetting an async test must `await` its assertions** — an `async` test function that returns before an `await`ed assertion completes may report as passed regardless of the outcome.

## Exercise

Given `example.ts`'s `add(a: number, b: number): number`, write a `node:test` test checking `add(0, 0) === 0` and `add(-1, 1) === 0`.

Try it yourself first, then check [`solutions/exercise_1.ts`](./solutions/exercise_1.ts).

## Interview questions

1. **What can TypeScript catch in a test file that plain JavaScript can't?** — Calling the function under test with arguments of the wrong type/shape fails to compile, catching a class of "the test itself is broken" mistakes (e.g. testing `add("2", 3)` by accident) before the test suite even runs.
2. **Does a passing type check mean the tested code is correct?** — No — types verify shape/type consistency, not logical correctness; a function can be perfectly well-typed and still return the wrong value for a given input, which is exactly what runtime tests are for.

---
← [Previous: Modules and Packages](../11_modules_packages/README.md) | [Next: Networking →](../13_networking/README.md)
