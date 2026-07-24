# Concurrency

Goroutines (`go f()`) are cheap, runtime-managed concurrent functions — not OS threads directly, but multiplexed onto a small pool of them. Go's proverb is "don't communicate by sharing memory; share memory by communicating": channels (`chan T`) pass values between goroutines safely, often replacing the locks other languages reach for first. `sync.WaitGroup` waits for a group of goroutines to finish; `sync.Mutex` protects shared state when a channel isn't the natural fit; `select` waits on multiple channel operations at once.

## Example

```go
results := make(chan int, 3)
var wg sync.WaitGroup

for i := 1; i <= 3; i++ {
	wg.Add(1)
	go func(n int) {
		defer wg.Done()
		results <- n * n
	}(i)
}

go func() {
	wg.Wait()
	close(results)   // signal "no more values" once all producers are done
}()

for r := range results {   // ranging over a channel reads until it's closed
	fmt.Println(r)
}
```

See [`example.go`](./example.go) for the full runnable file.

## Common mistakes

1. **Forgetting the main goroutine doesn't wait for others by default.** If `main()` returns while other goroutines are still running, the whole program exits immediately, mid-work — always synchronize with a `WaitGroup`, channel, or similar before returning.
2. **Sending to a channel that's never read (or reading from one that's never sent to)**, deadlocking — Go's runtime detects this specific "all goroutines are asleep" case and panics with a clear deadlock message, which is at least easier to diagnose than a silent hang.
3. **Closing a channel from the receiving side, or closing it more than once** — both panic. Only the sender should close a channel, and only once, typically after all sends are done.
4. **Sharing a map or slice across goroutines without synchronization.** Unlike a channel send, ordinary reads/writes to a shared map from multiple goroutines are a data race (maps aren't safe for concurrent read+write) — protect with a `sync.Mutex` or use `sync.Map` if that pattern is unavoidable.

## Exercise

Write `sumConcurrently(numbers []int) int` that splits `numbers` into two halves, sums each half in its own goroutine, and combines the results using a channel (not a shared variable with a mutex).

Try it yourself first, then check [`solutions/exercise_1.go`](./solutions/exercise_1.go).

## Interview questions

1. **What's the difference between a goroutine and an OS thread?** — A goroutine is a lightweight, runtime-managed unit of concurrency (starting at a few KB of stack, growing as needed) multiplexed onto a small number of OS threads by Go's scheduler — you can run hundreds of thousands of goroutines where OS threads would exhaust memory far sooner.
2. **Why does Go favor channels over shared-memory locking for many concurrency patterns?** — Passing ownership of data through a channel avoids the need for explicit locking around that data entirely — "share memory by communicating" sidesteps a whole class of race conditions that "communicate by sharing memory" (mutex-protected shared state) is prone to if a lock is forgotten anywhere.
3. **What happens if you close a channel and then try to close it again?** — It panics — closing an already-closed channel is a runtime error, part of why only the sender (and only once) should ever close a channel.

---
← [Previous: Databases](../14_databases/README.md) | [Next: Security →](../16_security/README.md)
