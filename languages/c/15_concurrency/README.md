# Concurrency

C11 added a standard threads API (`<threads.h>`), but support is patchy across compilers/platforms, so in practice the POSIX threads (pthreads) API — `<pthread.h>`, linked with `-lpthread` (or `-pthread`) — remains the portable, widely-supported choice on Unix-like systems. The primitives are `pthread_create`/`pthread_join` for threads, `pthread_mutex_t` for mutual exclusion. There's no built-in message-passing or higher-level abstraction; you build those yourself on top of mutexes and condition variables.

## Example

```c
#include <pthread.h>

int counter = 0;
pthread_mutex_t lock = PTHREAD_MUTEX_INITIALIZER;

void *increment(void *arg) {
	(void)arg;
	for (int i = 0; i < 100000; i++) {
		pthread_mutex_lock(&lock);
		counter++;               // protected: no lost updates
		pthread_mutex_unlock(&lock);
	}
	return NULL;
}

pthread_t threads[4];
for (int i = 0; i < 4; i++) {
	pthread_create(&threads[i], NULL, increment, NULL);
}
for (int i = 0; i < 4; i++) {
	pthread_join(threads[i], NULL);   // wait for each thread to finish
}
```

Compile with `cc example.c -o example -lpthread`. See [`example.c`](./example.c) for the full runnable file.

## Common mistakes

1. **Incrementing shared state without a mutex.** `counter++` is a read-modify-write, not atomic — two threads can interleave and lose updates. Unlike Rust (which makes this a compile error) or garbage-collected languages, C gives you no protection: an unsynchronized data race is undefined behavior that often *appears* to work in testing and fails intermittently under load.
2. **Forgetting to `pthread_join` (or `pthread_detach`) every thread you create.** A joinable thread that's never joined leaks its resources; and if `main` returns while threads are still running, the whole process exits and cuts them off mid-work.
3. **Locking a mutex and returning/erroring out before unlocking it**, leaving it locked forever — any other thread that tries to acquire it then blocks permanently (a deadlock). Every lock needs a matching unlock on every code path.
4. **Passing a pointer to a loop variable into `pthread_create`** and having all threads read the same (by-then-changed) value — the classic "capture by reference in a loop" bug; pass each thread its own copy of the data it needs.

## Exercise

Write `long sum_concurrently(const int *numbers, int len)` that splits `numbers` into two halves, sums each half on its own thread, and returns the combined total. (Give each thread a small struct with its slice's start pointer, length, and a field to write its partial sum into.)

Try it yourself first, then check [`solutions/exercise_1.c`](./solutions/exercise_1.c) — compile with `cc solutions/exercise_1.c -o exercise_1 -lpthread`.

## Interview questions

1. **Why is `counter++` unsafe when shared across threads without a mutex?** — It compiles to a load, an increment, and a store — three separate steps; two threads can both load the same value before either stores, so one increment overwrites the other and is lost. In C this data race is undefined behavior, not just a "sometimes wrong number" — the compiler and CPU are free to reorder and cache in ways that make unsynchronized access genuinely unpredictable.
2. **What's the difference between joining and detaching a thread?** — `pthread_join` blocks until the thread finishes and reclaims its resources (and can retrieve its return value); `pthread_detach` tells the system to reclaim the thread's resources automatically when it finishes, with no one waiting on it. Every thread should be exactly one or the other, or its resources leak.

---
← [Previous: Databases](../14_databases/README.md) | [Next: Security →](../16_security/README.md)

