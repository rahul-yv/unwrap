# Concurrency

Kotlin's flagship concurrency tool is **coroutines** (`kotlinx.coroutines`) — lightweight, suspendable functions that let async code read like sequential code. Since coroutines are a separate library (not stdlib), this lesson uses the JVM's `java.util.concurrent` toolkit directly instead — real threads, `synchronized`, and `AtomicInteger` — the same foundation coroutines are ultimately built on, and dependency-free like every other topic.

## Example

```kotlin
import java.util.concurrent.atomic.AtomicInteger

var counter = 0
val gate = Any()
val threads = (1..10).map {
	Thread {
		synchronized(gate) { counter++ }
	}
}
threads.forEach { it.start() }
threads.forEach { it.join() }
// counter == 10

val atomicCounter = AtomicInteger(0)
val threads2 = (1..10).map {
	Thread { atomicCounter.incrementAndGet() }
}
threads2.forEach { it.start() }
threads2.forEach { it.join() }
// atomicCounter.get() == 10
```

See [`example.kt`](./example.kt) for the full runnable file.

## Common mistakes

1. **Using `synchronized` where an atomic type would do.** For a single simple operation (increment, compare-and-swap) on a primitive counter, `AtomicInteger`/`AtomicLong` use lock-free CPU instructions and are cheaper than acquiring a monitor lock with `synchronized`; reach for `synchronized` when a critical section spans multiple statements or fields that must stay consistent together.
2. **Forgetting `Thread.join()` and assuming spawned threads have finished** when `main` continues — an un-joined thread keeps running independently, and the calling code can observe incomplete work (or the whole program can exit before it finishes).
3. **Synchronizing on a publicly accessible object (`synchronized(this)`, or a shared singleton) shared by unrelated code**, creating an unrelated contention point or a deadlock; use a private, dedicated lock object created solely for that purpose.
4. **Reaching for raw `Thread` for I/O-bound work in a real application instead of coroutines or a thread pool (`ExecutorService`).** Spinning up an OS thread per unit of work doesn't scale well for many concurrent I/O-bound tasks — coroutines (lightweight, many per OS thread) or a bounded thread pool are the idiomatic real-world choices; raw `Thread` here is for showing the underlying primitives directly.

## Exercise

Write a function `fun sumConcurrently(numbers: List<Int>): Int` that splits `numbers` into two halves, sums each half on its own `Thread`, and combines the results after joining both threads.

Try it yourself first, then check [`solutions/exercise_1.kt`](./solutions/exercise_1.kt).

## Interview questions

1. **When should you use `synchronized` versus an atomic type like `AtomicInteger`?** — Atomic types provide lock-free atomic operations for a single value (increment, compare-and-swap), cheaper than a lock since there's no monitor acquisition/release involved. `synchronized` is needed when a critical section touches multiple fields or statements that must be updated together consistently — something a single atomic operation can't express.
2. **What do Kotlin coroutines add over raw JVM threads?** — Coroutines are far cheaper to create (thousands can run concurrently on a small pool of real threads, since a suspended coroutine doesn't block its underlying thread), and structured concurrency (`launch`/`async` inside a `CoroutineScope`) ties a coroutine's lifetime to its parent, preventing "fire and forget" work from outliving the scope that started it — something raw `Thread` gives no help with.

---
← [Previous: Databases](../14_databases/README.md) | [Next: Security →](../16_security/README.md)
