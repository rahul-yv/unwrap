# Concurrency

Java has real OS-thread-backed `Thread`s, `synchronized` blocks/methods for mutual exclusion, and higher-level utilities in `java.util.concurrent` (`ExecutorService`, `CompletableFuture`, thread-safe collections). Since Java 21, **virtual threads** (`Thread.ofVirtual()`) give lightweight, JVM-managed threads — you can create millions of them, unlike traditional platform threads which are expensive OS resources.

## Example

```java
Thread t = new Thread(() -> System.out.println("running"));
t.start();
t.join();   // wait for it to finish

ExecutorService pool = Executors.newFixedThreadPool(4);
Future<Integer> future = pool.submit(() -> 2 + 2);
int result = future.get();   // blocks until the task completes
pool.shutdown();

// virtual threads (Java 21+): cheap enough to use one per task, even thousands
try (ExecutorService virtualPool = Executors.newVirtualThreadPerTaskExecutor()) {
	virtualPool.submit(() -> System.out.println("on a virtual thread"));
}
```

See [`Example.java`](./Example.java) for the full runnable file.

## Common mistakes

1. **Mutating shared state from multiple threads without `synchronized` (or another safe mechanism).** `counter++` is not atomic — it's a read, increment, write; two threads interleaving those steps can lose an update. Use `synchronized`, `AtomicInteger`, or a lock.
2. **Forgetting to `shutdown()` an `ExecutorService`.** Its threads don't automatically stop when the submitting code is done — an un-shutdown pool can keep the JVM alive indefinitely (or leak threads over the program's lifetime); use try-with-resources (`AutoCloseable` since Java 19) or an explicit `shutdown()`.
3. **Using platform threads (`new Thread()`) for a huge number of blocking I/O-bound tasks.** Each platform thread is a real OS thread with real memory overhead — thousands of them exhausts resources fast. Virtual threads (Java 21+) are designed exactly for this "many blocked-on-I/O tasks" pattern.
4. **Calling `.get()` on a `Future` with no timeout** when the task might hang — blocks the calling thread indefinitely; use the timed overload (`future.get(5, TimeUnit.SECONDS)`) when a hang is possible.

## Exercise

Write `int sumConcurrently(int[] numbers) throws InterruptedException` splitting the array into two halves, summing each half on its own `Thread`, and combining the results (store each half's sum in a shared array slot, protected appropriately, then add them after both threads finish).

Try it yourself first, then check [`solutions/Exercise1.java`](./solutions/Exercise1.java).

## Interview questions

1. **What's the difference between a platform thread and a virtual thread?** — A platform thread maps 1:1 to an OS thread (expensive, limited to thousands at most); a virtual thread is managed by the JVM and multiplexed onto a small pool of platform (“carrier”) threads, cheap enough to create millions of, and designed for I/O-bound workloads that spend most of their time blocked.
2. **Why is `counter++` not thread-safe even though it looks like one operation?** — It's actually three steps (read the current value, add one, write it back) that aren't atomic; two threads can both read the same value before either writes, and one increment gets lost.

---
← [Previous: Databases](../14_databases/README.md) | [Next: Security →](../16_security/README.md)
