# Concurrency

CPython has a Global Interpreter Lock (GIL): only one thread executes Python bytecode at a time, so `threading` doesn't give you parallel CPU work — it's useful for I/O-bound tasks (waiting on network/disk) where a thread releases the GIL while blocked. For CPU-bound parallelism, use `multiprocessing` (separate processes, separate GILs). `asyncio` gives cooperative concurrency on a single thread via `async`/`await`, well suited to many concurrent I/O-bound tasks without thread overhead.

## Example

```python
import threading

counter = 0
lock = threading.Lock()

def increment():
    global counter
    for _ in range(100_000):
        with lock:            # without the lock, this is a data race
            counter += 1

threads = [threading.Thread(target=increment) for _ in range(4)]
[t.start() for t in threads]
[t.join() for t in threads]
```

See [`example.py`](./example.py) for the full runnable file, including an `asyncio` example.

## Common mistakes

1. **Expecting `threading` to speed up CPU-bound work.** The GIL means only one thread runs Python bytecode at a time; CPU-bound work needs `multiprocessing` (or a C-extension that releases the GIL, like NumPy) for true parallelism.
2. **Mutating shared state from multiple threads without a lock.** `counter += 1` is not atomic — two threads can read the same value, both increment, and one update is lost. Protect shared mutable state with a `Lock`.
3. **Blocking calls inside `async def` functions.** `time.sleep(1)` inside an `async` function blocks the entire event loop, stalling every other concurrent task; use `await asyncio.sleep(1)` instead.
4. **Forgetting to `await` a coroutine.** Calling an `async def` function without `await` just creates a coroutine object — it never runs, and Python usually warns about this.

## Exercise

Write a function `count_up_concurrently(n_threads, per_thread)` that starts `n_threads` threads, each incrementing a shared counter `per_thread` times under a lock, joins them all, and returns the final counter value (should equal `n_threads * per_thread` exactly, proving the lock prevented lost updates).

Try it yourself first, then check [`solutions/exercise_1.py`](./solutions/exercise_1.py).

## Interview questions

1. **What is the GIL, and what does it actually prevent?** — A lock in CPython ensuring only one thread executes Python bytecode at a time; it prevents true parallel execution of Python code across threads (but I/O and some C extensions release it, allowing overlap during blocking calls).
2. **When would you choose `multiprocessing` over `threading`?** — For CPU-bound work that needs real parallelism; `multiprocessing` sidesteps the GIL by using separate processes, at the cost of higher memory use and slower inter-process communication.
3. **What problem does `asyncio` solve that threads don't?** — Running thousands of concurrent I/O-bound tasks cheaply on one thread, avoiding the memory and context-switching overhead of one OS thread per task.

---
← [Previous: Databases](../14_databases/README.md) | [Next: Security →](../16_security/README.md)
