# Concurrency

Rust's "fearless concurrency" claim comes from the same ownership/borrowing rules that prevent memory bugs also preventing data races — code that would race on shared mutable state simply doesn't compile. `std::thread::spawn` starts an OS thread; `Arc<Mutex<T>>` shares mutable state safely across threads (`Arc` for shared ownership via reference counting, `Mutex` for exclusive access); `std::sync::mpsc` channels pass messages between threads without shared memory at all.

## Example

```rust
use std::sync::{Arc, Mutex};
use std::thread;

let counter = Arc::new(Mutex::new(0));
let mut handles = vec![];

for _ in 0..10 {
	let counter = Arc::clone(&counter);
	handles.push(thread::spawn(move || {
		let mut num = counter.lock().unwrap();
		*num += 1;
	}));
}
for handle in handles {
	handle.join().unwrap();
}
assert_eq!(*counter.lock().unwrap(), 10);

use std::sync::mpsc;
let (tx, rx) = mpsc::channel();
thread::spawn(move || tx.send(42).unwrap());
assert_eq!(rx.recv().unwrap(), 42);
```

See [`example.rs`](./example.rs) for the full runnable file.

## Common mistakes

1. **Trying to share a plain (non-`Arc`) reference across threads.** The compiler rejects it at compile time — a spawned thread's closure can't borrow data that might not outlive the thread, so shared state needs `Arc` (shared ownership, safe to hand a clone to each thread) rather than a raw reference.
2. **Forgetting `.lock()` returns a `Result` (poisoned if a thread panicked while holding the lock), not the value directly.** `.lock().unwrap()` is the common shorthand, but a poisoned mutex means a prior panic happened mid-critical-section — worth knowing what the `unwrap` there is actually guarding against.
3. **Holding a `Mutex` lock longer than necessary**, serializing work that didn't need to be serialized — keep the locked critical section as small as possible.
4. **Not calling `.join()` on a spawned thread's handle** when the program needs to wait for it — an un-joined thread keeps running independently, and `main` can exit before it finishes.

## Exercise

Write `fn sum_concurrently(numbers: Vec<i32>) -> i32` that splits `numbers` into two halves, sums each half on its own thread, and combines the results using an `mpsc` channel (send each half's sum, receive both, add them).

Try it yourself first, then check [`solutions/exercise_1.rs`](./solutions/exercise_1.rs).

## Interview questions

1. **What does "fearless concurrency" mean in Rust, concretely?** — The same compile-time ownership/borrowing checks that prevent use-after-free and double-free also prevent data races on shared mutable state — code that would race (two threads mutating the same data without synchronization) fails to compile rather than compiling into undefined behavior discovered at runtime.
2. **Why does sharing mutable state across threads require both `Arc` and `Mutex`, not just one?** — `Arc` provides shared *ownership* (so the data can outlive any single thread and multiple threads can each hold a reference), but doesn't make mutation safe on its own; `Mutex` provides safe *mutation* (exclusive access while locked), but doesn't manage shared ownership by itself — combined, `Arc<Mutex<T>>` gives both.

---
← [Previous: Databases](../14_databases/README.md) | [Next: Security →](../16_security/README.md)

