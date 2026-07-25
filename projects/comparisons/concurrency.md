# Concurrency, across 14 languages

The concurrency landscape splits into three clear models: real shared-memory threads, single-threaded event-loop concurrency, and message-passing isolation. Which model a language defaults to shapes almost everything else about how you write concurrent code in it.

## Real OS threads with shared memory

- **Java**: `Thread`, `synchronized`, `java.util.concurrent` (`ExecutorService`, `CompletableFuture`). Since Java 21, lightweight JVM-managed **virtual threads** let you spawn millions of them cheaply.
- **C#**: `Task`-based `async`/`await` for I/O, plus `Task.Run`/`lock`/`Interlocked` for CPU-bound work — both share the same `Task` type and compose via `Task.WhenAll`.
- **Rust**: `std::thread::spawn` for real OS threads; the borrow checker statically prevents data races at compile time — code that would race simply doesn't compile. `Arc<Mutex<T>>` shares mutable state safely; channels (`mpsc`) avoid shared memory entirely.
- **C**: POSIX threads (`pthreads`) — manual, unopinionated; you build any higher-level abstraction yourself on top of mutexes and condition variables.
- **C++**: threading in the standard library since C++11 (`std::thread`, `std::mutex`, `std::atomic`), with `std::lock_guard` providing RAII-based automatic unlocking — C's biggest pain point (forgetting to unlock) solved structurally.
- **Kotlin** (without the `kotlinx.coroutines` library): falls back to the JVM's `java.util.concurrent` toolkit directly — real threads, `synchronized`, `AtomicInteger`.
- **Ruby**: real `Thread`s, but MRI's Global VM Lock (GVL) means only one thread runs Ruby bytecode at a time — genuine concurrency for I/O-bound work (GVL releases during blocking I/O), not parallelism for CPU-bound work. `Ractor` sidesteps this with isolated memory per ractor.

## Single-threaded event loop (`async`/`await`, no real parallelism without extra tools)

- **JavaScript/TypeScript**: one thread, an event loop; I/O happens off-thread and resumes your code via the callback/microtask queue. `worker_threads` (Node) is the escape hatch for genuine CPU parallelism.
- **Python**: the GIL means `threading` doesn't parallelize CPU-bound work either — same shape as Ruby's GVL. `asyncio` gives cooperative single-thread concurrency; `multiprocessing` (separate processes, separate GILs) is the escape hatch for CPU parallelism.
- **Swift**: `async`/`await` plus **structured concurrency** (`Task`, `withTaskGroup` — child task lifetimes are tied to their parent scope). `actor` serializes access to its own state, eliminating data races without manual locks — but this is single-threaded-per-actor concurrency, not raw parallelism across actors necessarily.
- **Dart**: `async`/`await`/`Future` on one event loop by default — explicitly concurrency, not parallelism.
- **PHP**: shared-nothing by default (each request is its own process) — no threading model at all in the traditional sense. `Fiber` (8.1+) gives single-threaded cooperative concurrency for async I/O.

## True parallelism via isolated memory (message passing, no shared mutable state)

- **Go**: goroutines are cheap, runtime-multiplexed onto a small pool of OS threads — genuinely parallel across cores. Channels (`chan T`) are the idiomatic way to communicate ("share memory by communicating," not the reverse); `sync.Mutex`/`WaitGroup` exist for when a channel isn't the natural fit.
- **Dart**: `Isolate` for genuine parallelism — separate memory per isolate, communicating only via `SendPort`/`ReceivePort` message passing. No shared mutable state at all between isolates.
- **PHP**: `pcntl_fork()` spawns real child *processes* — separate memory, requiring explicit IPC (sockets/pipes) to communicate results back, the process-level equivalent of Dart's isolates.
- **Ruby**: `Ractor` (experimental) — isolated memory per ractor, message-passing communication, sidesteps the GVL for genuine parallelism.

## The recurring pattern: GIL/GVL-style single-thread execution locks

Python (GIL) and Ruby (GVL) share the exact same shape: real OS threads exist, but only one executes interpreted bytecode at a time, so threads help I/O-bound concurrency but not CPU-bound parallelism — both languages' escape hatch is a separate-memory-space mechanism (`multiprocessing` for Python, `Ractor` for Ruby) rather than "just spawn more threads."

## Interview-relevant takeaway

"Does spawning more threads speed up CPU-bound work in this language?" has a surprising number of "no, actually" answers once you look past the mainstream ones (Java, C#, Rust, Go, C, C++ all say yes) — Python and Ruby's global locks, and JS/Dart/Swift's single-event-loop-by-default model, are the ones worth being explicit about in an interview rather than assuming threading always parallelizes computation.
