# Concurrency

PHP's traditional model is **shared-nothing**: each request (in a web context) runs in its own process/thread with no memory shared with any other request — there's no built-in threading with shared mutable state the way Kotlin/Java/C# have. For genuine parallelism in a script, the `pcntl` extension's `pcntl_fork()` spawns child *processes* (each with its own separate memory — nothing is implicitly shared, so results have to be communicated back explicitly, e.g. via a socket pair or pipe). PHP 8.1 added `Fiber` for single-threaded cooperative concurrency (suspend/resume, not parallelism) — useful for async I/O libraries, not for CPU-bound parallel work.

## Example

```php
<?php
function sumHalf(array $numbers): int {
	return array_sum($numbers);
}

// Fork two child processes, each computing one half's sum,
// communicating the result back through a socket pair (forked processes
// don't share memory, unlike threads in other languages).
$pipe = [];
socket_create_pair(AF_UNIX, SOCK_STREAM, 0, $pipe);
$pid = pcntl_fork();
if ($pid === 0) {
	socket_close($pipe[0]);
	$sum = sumHalf([1, 2, 3]);
	socket_write($pipe[1], (string) $sum);
	exit(0);
}
socket_close($pipe[1]);
$partial = (int) socket_read($pipe[0], 32);
pcntl_waitpid($pid, $status);
```

See [`example.php`](./example.php) for the full runnable file.

## Common mistakes

1. **Assuming a forked child process shares memory with the parent, the way a thread does in most other languages.** After `pcntl_fork()`, parent and child have entirely separate copies of memory — mutating a variable in the child has no effect on the parent's copy. Results must be communicated explicitly (a pipe, socket pair, shared-memory extension, or a file/database).
2. **Forgetting to `pcntl_waitpid()` for each forked child.** Without waiting, terminated child processes become zombies until the parent exits or reaps them — accumulating unreaped children in a long-running process leaks process table entries.
3. **Using `Fiber` expecting CPU-bound parallelism.** Fibers provide cooperative, single-threaded concurrency (useful for structuring async I/O code without callback nesting) — they don't run on multiple CPU cores simultaneously the way forked processes or true OS threads do; CPU-bound work still runs sequentially within one fiber at a time.
4. **Reaching for `pcntl_fork()` in a typical web request handler.** Fork-based parallelism is mainly useful in long-running CLI scripts/workers — most PHP web frameworks handle concurrency at the request level (multiple PHP-FPM workers each handling one request), not by forking within a single request's handling.

## Exercise

Write a function `function sumConcurrently(array $numbers): int` that splits `$numbers` into two halves, sums each half in a forked child process, and combines the results (communicated back via a socket pair).

Try it yourself first, then check [`solutions/exercise_1.php`](./solutions/exercise_1.php).

## Interview questions

1. **Why doesn't a forked PHP process share mutable state with its parent, unlike a thread in Java/Kotlin/C#?** — `fork()` (via `pcntl_fork()`) creates a new OS process with its own copy of the parent's memory at the moment of the fork — the two address spaces are entirely separate from that point forward. A thread, by contrast, shares its process's memory with all other threads in that process. This is why forked PHP workers need explicit IPC (pipes, sockets, shared memory) to communicate, where threads can just read/write a shared variable (with appropriate locking).
2. **What's the difference between what `Fiber` provides and true parallelism?** — `Fiber` lets a single PHP thread cooperatively switch between multiple logical "tasks," suspending one to run another (typically while waiting on I/O) — useful for writing async code without deeply nested callbacks. It does not run code on multiple CPU cores at the same time; only one fiber actually executes at any given instant. Real parallelism in PHP requires separate OS processes (`pcntl_fork`) or, in specific extensions like Swoole, a different concurrency runtime altogether.

---
← [Previous: Databases](../14_databases/README.md) | [Next: Security →](../16_security/README.md)
