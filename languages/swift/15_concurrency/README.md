# Concurrency

Swift's modern concurrency model is built on `async`/`await` plus **structured concurrency**: `Task` and `withTaskGroup` spawn concurrent work whose lifetime is tied to its enclosing scope, so it can't silently outlive the code that started it. An `actor` is a reference type that serializes access to its own mutable state automatically — only one task can be executing inside an actor's methods at a time, which eliminates a whole category of data races without manual locks.

## Example

```swift
actor Counter {
	private var value = 0
	func increment() { value += 1 }
	func get() -> Int { value }
}

let counter = Counter()
await withTaskGroup(of: Void.self) { group in
	for _ in 0..<10 {
		group.addTask { await counter.increment() }
	}
}
let result = await counter.get()   // 10 — no data race, no manual lock needed

let sum = await withTaskGroup(of: Int.self, returning: Int.self) { group in
	group.addTask { (1...5).reduce(0, +) }
	group.addTask { (6...10).reduce(0, +) }
	var total = 0
	for await partial in group { total += partial }
	return total
}
```

See [`example.swift`](./example.swift) for the full runnable file.

## Common mistakes

1. **Mutating shared state from multiple concurrent tasks without an actor (or other synchronization).** A plain `class` with a `var` property mutated from several concurrently-running tasks is a data race — Swift's compiler-enforced concurrency checking (`Sendable`) catches many such mistakes at compile time, but wrapping genuinely shared mutable state in an `actor` is the idiomatic fix, not working around the checker.
2. **Forgetting every access to an actor's members from outside the actor needs `await`**, even for simple property reads — the `await` marks a potential suspension point where the actor might be busy with another task's call.
3. **Using `Task { ... }` (unstructured) where `withTaskGroup`/`async let` (structured) would tie the work's lifetime to the right scope.** An unstructured `Task` keeps running independently of where it was created, which is sometimes exactly what's wanted (fire-and-forget), but structured concurrency is preferred when the work should be guaranteed to finish (or be cancelled) alongside its caller.
4. **Not handling task cancellation.** Structured concurrency propagates cancellation automatically down through child tasks, but a long-running task still needs to periodically check `Task.isCancelled` (or use a cancellation-aware API) to actually stop promptly rather than running to completion regardless.

## Exercise

Write an async function `func sumConcurrently(_ numbers: [Int]) async -> Int` that splits `numbers` into two halves, sums each half in its own child task via `withTaskGroup`, and combines the results.

Try it yourself first, then check [`solutions/exercise_1.swift`](./solutions/exercise_1.swift).

## Interview questions

1. **How does an `actor` prevent data races without explicit locks?** — An actor serializes access to its own mutable state: only one task may be executing inside any of its methods at a time, and the compiler enforces that external code can only reach that state through `await`-marked calls (which may suspend while waiting their turn). This achieves the same mutual exclusion a lock provides, but structurally, without a manually acquired/released lock object that could be forgotten or held too long.
2. **What does "structured concurrency" mean, and what problem does it solve?** — Concurrent work spawned via `async let` or `withTaskGroup` is scoped to the code block that created it — the parent can't return or the block can't exit until all of its child tasks have completed (or been cancelled), and cancellation of the parent propagates to children automatically. This solves the "leaked" or "forgotten" background task problem that unstructured concurrency (raw threads, or a fire-and-forget `Task`) doesn't prevent — work that keeps running with no one tracking or awaiting it.

---
← [Previous: Databases](../14_databases/README.md) | [Next: Security →](../16_security/README.md)
