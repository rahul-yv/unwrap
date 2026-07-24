# Concurrency

JavaScript runs on a single thread with an event loop: only one piece of JS executes at a time, but I/O (network, file, timers) happens off-thread and resumes your code via the callback/microtask queue when it's ready — this is what makes `async`/`await` useful without real threads. For actual parallel *computation* (CPU-bound work), Node provides `worker_threads` (stdlib), running separate JS engine instances with message-passing between them.

## Example

```javascript
// sequential: waits for each before starting the next — 3x the latency
async function sequential() {
  const a = await fetchAfter(100, "a");
  const b = await fetchAfter(100, "b");
  const c = await fetchAfter(100, "c");
  return [a, b, c];
}

// concurrent: all three start immediately, wait for all to finish
async function concurrent() {
  return Promise.all([fetchAfter(100, "a"), fetchAfter(100, "b"), fetchAfter(100, "c")]);
}
```

See [`example.js`](./example.js) for the full runnable file, including a `worker_threads` example for real parallel computation.

## Common mistakes

1. **`await`ing independent async operations one at a time** when they don't depend on each other's results — this serializes work that could run concurrently. Use `Promise.all` to start them together.
2. **Using `Promise.all` when one failure shouldn't cancel the others.** `Promise.all` rejects as soon as any promise rejects, discarding the other results. Use `Promise.allSettled` when you need every outcome regardless of individual failures.
3. **Expecting `worker_threads` for I/O-bound work.** Workers add real parallelism for CPU-bound tasks (heavy computation); for I/O-bound work, plain `async`/`await` already overlaps efficiently without the overhead of spinning up a worker.
4. **Sharing mutable JS objects between the main thread and a worker directly.** Workers communicate via message-passing (structured clone) by default, not shared memory — passing a large object copies it; use `SharedArrayBuffer` only when true shared memory is actually needed.

## Exercise

Write an async function `fetchAllConcurrently(delays)` that takes an array of millisecond delays and returns an array of results (one per delay, e.g. the string `` `waited ${ms}` ``), where all the waits happen concurrently rather than sequentially — the whole function should take roughly as long as the *longest* delay, not the sum of all of them.

Try it yourself first, then check [`solutions/exercise_1.js`](./solutions/exercise_1.js).

## Interview questions

1. **Is JavaScript single-threaded? If so, how does `async`/`await` provide concurrency?** — Yes, one thread runs JS at a time; concurrency comes from the event loop handing off I/O to the runtime/OS and resuming your code via callbacks/microtasks once it completes, not from parallel execution of your JS.
2. **`Promise.all` vs `Promise.allSettled` — when would you pick each?** — `Promise.all` when any single failure should abort the whole operation (fail-fast); `Promise.allSettled` when you need the outcome of every promise regardless of individual failures (e.g. batch operations where partial success is fine).
3. **When would you reach for `worker_threads` instead of async/await?** — For genuinely CPU-bound work (heavy computation, parsing, image processing) that would otherwise block the event loop; async/await doesn't help here because there's no I/O wait to overlap with.

---
← [Previous: Databases](../14_databases/README.md) | [Next: Security →](../16_security/README.md)
