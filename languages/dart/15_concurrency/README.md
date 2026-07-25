# Concurrency

Dart is single-threaded by default: `async`/`await` and `Future` give **concurrency** (interleaving many I/O-bound operations on one thread's event loop, never blocking it), not parallelism. For genuine parallelism — using multiple CPU cores — Dart uses `Isolate`: an independent worker with its own memory (no shared mutable state, unlike threads in most other languages), communicating with the main isolate only via message passing over `SendPort`/`ReceivePort`.

## Example

```dart
import "dart:isolate";

Future<int> sumInIsolate(List<int> numbers) async {
	final receivePort = ReceivePort();
	await Isolate.spawn(_isolateSum, [receivePort.sendPort, numbers]);
	final result = await receivePort.first;
	return result as int;
}

// top-level function: isolate entry points can't be closures over outer state,
// since the new isolate doesn't share memory with the one that spawned it
void _isolateSum(List<dynamic> args) {
	final sendPort = args[0] as SendPort;
	final numbers = args[1] as List<int>;
	sendPort.send(numbers.fold<int>(0, (a, b) => a + b));
}

// async/await concurrency: multiple Futures interleaved on the single event loop
final results = await Future.wait([
	Future.delayed(Duration.zero, () => 1),
	Future.delayed(Duration.zero, () => 2),
]);
```

See [`example.dart`](./example.dart) for the full runnable file.

## Common mistakes

1. **Expecting `async`/`await`/`Future` to run code on multiple CPU cores.** They provide concurrency (efficiently interleaving I/O-bound work without blocking), not parallelism — all Dart code outside an `Isolate` still runs on one thread. CPU-bound work that needs to use multiple cores requires spawning an `Isolate`, not just `await`ing more `Future`s.
2. **Trying to close over mutable outer state in an `Isolate`'s entry-point function.** A spawned isolate has its own separate memory — it can't read or write variables from the isolate that spawned it directly; all communication must go through explicit message passing (`SendPort.send`/`ReceivePort`), which is why isolate entry points are typically top-level or static functions, not closures capturing local state.
3. **Spawning an `Isolate` for lightweight work where the message-passing overhead outweighs any parallelism benefit.** Isolates have real setup cost (a new isolate, its own heap) — reach for them for genuinely CPU-intensive work, not small tasks better served by plain `async`/`await` or even synchronous code.
4. **Forgetting only messages that can be serialized (primitives, and objects composed of them) can be sent between isolates** — you can't pass an arbitrary object with, say, an open file handle or a closure capturing local state through a `SendPort`; only "isolate-safe" values transfer.

## Exercise

Write a function `Future<int> sumConcurrently(List<int> numbers)` that splits `numbers` into two halves and sums each half in its own `Isolate`, combining the results.

Try it yourself first, then check [`solutions/exercise_1.dart`](./solutions/exercise_1.dart).

## Interview questions

1. **What's the difference between concurrency and parallelism in Dart, and which does `async`/`await` provide?** — Concurrency means multiple logical tasks make progress by interleaving (not necessarily running at the exact same instant); parallelism means tasks genuinely execute simultaneously on multiple CPU cores. `async`/`await`/`Future` give concurrency on Dart's single-threaded event loop — I/O-bound work doesn't block other work from proceeding, but no two pieces of Dart code (outside separate isolates) ever run at literally the same instant.
2. **Why can't an `Isolate` share mutable memory with the isolate that spawned it?** — Each `Isolate` has its own separate heap and garbage collector, entirely isolated from every other isolate's memory — a deliberate design choice that eliminates data races by construction (there's no shared mutable state to race over) at the cost of needing explicit message passing (`SendPort`/`ReceivePort`) to communicate, and only being able to send values that can be represented independently of the sender's memory (no raw object references, no closures capturing local variables).

---
← [Previous: Databases](../14_databases/README.md) | [Next: Security →](../16_security/README.md)
