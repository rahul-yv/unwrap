# Concurrency

Ruby's `Thread` provides real OS threads, but MRI (the standard Ruby implementation) has a **Global VM Lock (GVL)** — only one thread executes Ruby code at a time, so threads don't give CPU-bound work true parallelism on MRI (JRuby and TruffleRuby don't have this restriction). Threads *do* give real concurrency for I/O-bound work, since the GVL is released during blocking I/O operations. `Mutex` provides mutual exclusion for shared mutable state, same as most languages.

## Example

```ruby
counter = 0
mutex = Mutex.new

threads = 10.times.map do
  Thread.new do
    mutex.synchronize { counter += 1 }
  end
end
threads.each(&:join)
# counter == 10

# Ractor (since Ruby 3.0) provides true parallelism by running in separate,
# isolated memory spaces (no shared mutable state, communicating via message passing)
ractor = Ractor.new { 1 + 2 }
result = ractor.value   # 3 — Ractor's API is still marked experimental as of recent Ruby versions
```

See [`example.rb`](./example.rb) for the full runnable file.

## Common mistakes

1. **Expecting `Thread` to speed up CPU-bound work on MRI.** Because of the GVL, only one thread runs Ruby bytecode at a time on the standard interpreter — spawning threads for pure computation (no I/O, no blocking) won't use multiple CPU cores; use `Ractor` (isolated parallelism), multiple processes (`fork`), or a JRuby/TruffleRuby runtime for genuine CPU parallelism.
2. **Mutating shared state from multiple threads without a `Mutex`.** Even with the GVL, individual Ruby operations aren't always atomic at the bytecode level (`counter += 1` is actually a read-then-write, which can interleave between threads) — a `Mutex` around the critical section is still needed to avoid lost updates.
3. **Forgetting to `.join` spawned threads** when the program needs to wait for their results — an un-joined thread keeps running independently, and the main thread (and process) can exit before it finishes.
4. **Holding a `Mutex` longer than necessary**, serializing work that didn't need to be serialized — keep the locked critical section as small as possible.

## Exercise

Write a method `def sum_concurrently(numbers)` that splits `numbers` into two halves, sums each half on its own `Thread`, and combines the results after joining both threads.

Try it yourself first, then check [`solutions/exercise_1.rb`](./solutions/exercise_1.rb).

## Interview questions

1. **What is the GVL (Global VM Lock), and why does it limit `Thread`'s usefulness for CPU-bound work?** — On MRI (the reference Ruby implementation), the GVL ensures only one thread executes Ruby code at any instant, even on a multi-core machine — a safety mechanism that simplifies MRI's internals but means spawning more threads doesn't parallelize pure computation. It's released during blocking I/O (file/network reads, sleeping), which is why threads are still genuinely useful for I/O-bound concurrency.
2. **How does `Ractor` differ from `Thread` for achieving parallelism?** — Each `Ractor` has its own isolated memory space — no implicit sharing of mutable objects between ractors (they communicate by passing messages, similar to Erlang's actor model), which sidesteps the GVL's single-thread-at-a-time restriction and enables genuine parallel execution across CPU cores, at the cost of not being able to freely share mutable objects the way threads within one GVL-protected memory space can.

---
← [Previous: Databases](../14_databases/README.md) | [Next: Security →](../16_security/README.md)
