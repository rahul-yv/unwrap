# Concurrency

Runtime behavior matches the JavaScript track's `15_concurrency` — single-threaded event loop, `Promise.all`/`allSettled` for concurrent async work, `worker_threads` for real parallelism. TypeScript's addition: `Promise.all([p1, p2, p3])` infers a *tuple* type matching each promise's resolved type, not just `Array<unknown>` — so `const [a, b] = await Promise.all([fetchNumber(), fetchString()])` types `a: number` and `b: string` correctly, individually.

## Example

```typescript
async function fetchNumber(): Promise<number> {
	return 42;
}
async function fetchLabel(): Promise<string> {
	return "done";
}

async function run(): Promise<void> {
	const [n, label] = await Promise.all([fetchNumber(), fetchLabel()]);
	// n: number, label: string — each position typed individually, not unioned
}
```

See [`example.ts`](./example.ts) for the full runnable file.

## Common mistakes

1. **Assuming `Promise.all`'s result type is `(A | B)[]`** (a union array) instead of a proper tuple — with TypeScript's inference, each position keeps its own specific type, so destructuring gives you the right type per variable without a manual cast.
2. **`await`ing independent async calls sequentially** when they don't depend on each other — same runtime pitfall as JavaScript; TypeScript's types don't prevent this performance mistake, only logic mistakes.
3. **Typing a worker's message payload as `any`** instead of a shared interface between the main thread and worker code — losing type safety exactly at the boundary where a mismatch (wrong field name, wrong type) is easiest to introduce.

## Exercise

Write an async function `fetchAllConcurrently<T>(tasks: Array<() => Promise<T>>): Promise<T[]>` that runs all the given zero-argument async functions concurrently and returns their results in order.

Try it yourself first, then check [`solutions/exercise_1.ts`](./solutions/exercise_1.ts).

## Interview questions

1. **What does TypeScript infer for `Promise.all([promiseA, promiseB])` where `promiseA` and `promiseB` resolve to different types?** — A tuple type `[TypeOfA, TypeOfB]`, preserving each position's specific resolved type — destructuring the awaited result gives correctly-typed variables without a cast.
2. **Does typing async code prevent sequential-instead-of-concurrent mistakes?** — No — that's a runtime/performance concern about *when* you `await`, which the type checker doesn't reason about; types only guarantee the values have the shape you expect, not that they were fetched efficiently.

---
← [Previous: Databases](../14_databases/README.md) | [Next: Security →](../16_security/README.md)
