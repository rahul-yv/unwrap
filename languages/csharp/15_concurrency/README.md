# Concurrency

C# has two complementary concurrency models: `Task`-based asynchrony (`async`/`await`) for I/O-bound work that shouldn't block a thread while waiting, and the thread pool (`Task.Run`) plus explicit synchronization (`lock`, `Interlocked`) for CPU-bound parallel work. Both use the same `Task`/`Task<T>` type, so they compose — `await Task.WhenAll(...)` waits for a batch of either kind.

## Example

```csharp
using System.Threading;
using System.Threading.Tasks;

// CPU-bound work in parallel, with shared mutable state protected by lock
int counter = 0;
object gate = new();
var tasks = new Task[10];
for (int i = 0; i < 10; i++)
{
	tasks[i] = Task.Run(() => {
		lock (gate) { counter++; }
	});
}
await Task.WhenAll(tasks);
// counter == 10

// Interlocked: lock-free atomic increment for simple counters
int atomicCounter = 0;
var tasks2 = new Task[10];
for (int i = 0; i < 10; i++)
{
	tasks2[i] = Task.Run(() => Interlocked.Increment(ref atomicCounter));
}
await Task.WhenAll(tasks2);
// atomicCounter == 10
```

See [`example.cs`](./example.cs) for the full runnable file.

## Common mistakes

1. **Using `lock` where `Interlocked` would do.** For a single simple operation (increment, compare-and-swap) on a primitive field, `Interlocked.Increment`/`.CompareExchange` are lock-free and cheaper than acquiring a `lock`; reach for `lock` when the critical section spans multiple statements or fields that must stay consistent together.
2. **Forgetting `Task.Run` schedules on the thread pool — using it for I/O-bound work wastes a thread pool thread blocking on I/O.** `Task.Run` is for CPU-bound work; I/O-bound work (network, file, database calls) should use the operation's own `async` API (`ReadAsync`, `GetStringAsync`) so no thread is occupied while waiting.
3. **Locking on a publicly accessible object (`lock(this)` or a public field).** External code can also lock on that same object, creating an unrelated contention point or a deadlock; lock on a private, dedicated object created solely for that purpose (as `gate` above).
4. **Not awaiting `Task.WhenAll` and instead awaiting tasks one by one in a loop.** `foreach (var t in tasks) await t;` runs them sequentially if they weren't already started concurrently, or otherwise loses the "wait for all, propagate all exceptions" semantics that `Task.WhenAll` provides.

## Exercise

Write a method `Task<int> SumConcurrentlyAsync(int[] numbers)` that splits `numbers` into two halves, sums each half on its own `Task.Run`, and combines the results with `Task.WhenAll`.

Try it yourself first, then check [`solutions/exercise_1.cs`](./solutions/exercise_1.cs).

## Interview questions

1. **When should you use `lock` versus `Interlocked` for protecting shared state?** — `Interlocked` provides lock-free atomic operations (increment, decrement, compare-and-swap) for a single primitive value, cheaper than a lock since there's no OS-level synchronization primitive involved; `lock` is needed when a critical section touches multiple fields or statements that must be updated together consistently, since `Interlocked` only atomizes one operation at a time.
2. **What's the difference between `Task.Run` and `async`/`await` over an I/O API, and when does each apply?** — `Task.Run` queues work onto the thread pool, occupying a thread for the work's duration — appropriate for CPU-bound work you want to run off the calling thread. `async`/`await` over an I/O API (like `ReadAsync`) doesn't occupy a thread while waiting; the underlying OS handles the I/O and the thread is freed until it completes. Using `Task.Run` to wrap I/O-bound work wastes a thread pool thread blocking on I/O that didn't need a thread at all.

---
← [Previous: Databases](../14_databases/README.md) | [Next: Security →](../16_security/README.md)
