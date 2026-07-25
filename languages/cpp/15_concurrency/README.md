# Concurrency

Unlike C (which relies on the OS's pthreads), C++ has threading **in its standard library** since C++11: `std::thread`, `std::mutex`, `std::lock_guard` (RAII locking), `std::atomic`, `std::future`/`std::async`. `std::lock_guard` is the standout — it locks a mutex in its constructor and unlocks in its destructor, so the mutex is released automatically even if the protected code throws, eliminating the "locked and never unlocked" deadlock C's manual `pthread_mutex_lock`/`unlock` invites. (On Linux, still link with `-pthread`, since `std::thread` is implemented on top of pthreads.)

## Example

```cpp
#include <thread>
#include <mutex>
#include <vector>

int counter = 0;
std::mutex mtx;

void increment() {
	for (int i = 0; i < 100000; i++) {
		std::lock_guard<std::mutex> lock(mtx);   // RAII: unlocks when `lock` goes out of scope
		counter++;
	}
}

std::vector<std::thread> threads;
for (int i = 0; i < 4; i++) {
	threads.emplace_back(increment);
}
for (auto& t : threads) {
	t.join();                                    // wait for each thread
}
// counter == 400000 — the mutex prevented every lost update
```

See [`example.cpp`](./example.cpp) for the full runnable file.

## Common mistakes

1. **Locking a `std::mutex` manually with `.lock()`/`.unlock()` instead of `std::lock_guard`.** A manual `.lock()` that isn't matched by `.unlock()` on every path (early return, exception) deadlocks; `std::lock_guard` (or `std::unique_lock`) releases in its destructor automatically — the RAII pattern, and the idiomatic C++ way to hold a lock.
2. **Destroying a `std::thread` without `join()`ing or `detach()`ing it.** A `std::thread` that's still joinable when its destructor runs calls `std::terminate()` (crashes the program) — you must explicitly `join()` (wait for it) or `detach()` (let it run independently) before it's destroyed.
3. **Data races on shared mutable state** — `counter++` across threads without a mutex (or `std::atomic`) is undefined behavior, exactly as in C; C++ doesn't prevent it, but `std::atomic<int>` and `std::lock_guard` make the fix concise.
4. **Capturing local variables by reference in a thread's lambda that outlives them** — if the thread runs after the captured variable's scope ends, that's a dangling reference; capture by value, or ensure the variable outlives the thread (e.g. by `join()`ing before it's destroyed).

## Exercise

Write `long sum_concurrently(const std::vector<int>& numbers)` that splits `numbers` into two halves, sums each half on its own `std::thread` (writing into a shared results array or captured references), joins both, and returns the total.

Try it yourself first, then check [`solutions/exercise_1.cpp`](./solutions/exercise_1.cpp) — compile with `c++ solutions/exercise_1.cpp -o exercise_1 -pthread`.

## Interview questions

1. **How does `std::lock_guard` improve on manually calling a mutex's `lock()`/`unlock()`?** — It's an RAII wrapper: it locks the mutex in its constructor and unlocks in its destructor, so the lock is released automatically when the guard goes out of scope — on every exit path including exceptions — eliminating the "returned/threw while holding the lock" deadlock that manual unlock is prone to.
2. **What happens if a joinable `std::thread` is destroyed without being joined or detached?** — Its destructor calls `std::terminate()`, abruptly ending the program. C++ deliberately makes this a hard failure to force an explicit decision: either `join()` (wait for the thread to finish) or `detach()` (release ownership and let it run on its own) before the `std::thread` object is destroyed.

---
← [Previous: Databases](../14_databases/README.md) | [Next: Security →](../16_security/README.md)
