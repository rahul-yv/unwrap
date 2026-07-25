# Error Handling

C# uses exceptions: `throw` an exception object (derived from `System.Exception`), `try`/`catch`/`finally` to handle it. `finally` always runs (for cleanup), but the idiomatic cleanup mechanism for resources is the **`using` statement/declaration**, which calls `Dispose()` on an `IDisposable` automatically when it goes out of scope — C#'s deterministic-cleanup answer to the garbage collector's non-determinism. Catch specific exception types, and use exception filters (`catch (Ex e) when (...)`) to handle conditionally.

## Example

```csharp
public class InsufficientFundsException : Exception {
	public decimal Balance { get; }
	public decimal Amount { get; }
	public InsufficientFundsException(decimal balance, decimal amount)
		: base("insufficient funds") { Balance = balance; Amount = amount; }
}

static double Divide(double a, double b) {
	if (b == 0) throw new DivideByZeroException();
	return a / b;
}

try {
	Divide(10, 0);
} catch (DivideByZeroException e) {
	Console.WriteLine(e.Message);
} finally {
	// always runs
}

// using declaration: Dispose() is called automatically at end of scope
using var file = new StreamWriter("out.txt");
file.WriteLine("hello");   // file.Dispose() (which flushes and closes) runs when scope ends
```

See [`example.cs`](./example.cs) for the full runnable file.

## Common mistakes

1. **Catching `System.Exception` broadly** and swallowing everything, hiding bugs — catch the specific exception types you can actually handle, and let others propagate. A bare `catch { }` that discards the exception is especially dangerous.
2. **Managing `IDisposable` resources with manual `try`/`finally` + `Dispose()` when a `using` statement/declaration is cleaner** and can't forget the `Dispose` call — `using` is the idiomatic way to guarantee deterministic cleanup of files, connections, locks, etc.
3. **Throwing or catching `Exception` base type instead of a specific derived type**, losing the ability to distinguish error kinds — define/catch specific exceptions (`ArgumentException`, `InvalidOperationException`, custom types) so callers can respond appropriately.
4. **Using exceptions for expected control flow** (like "not found" on a common lookup) where a `TryGet`-style method returning `bool` + `out` is cheaper and clearer — exceptions carry stack-capture overhead and signal exceptional conditions, not routine outcomes.

## Exercise

Write `double SafeDivide(double a, double b)` that throws `DivideByZeroException` if `b == 0`, otherwise returns `a / b`. Demonstrate both the success and the caught-exception paths.

Try it yourself first, then check [`solutions/exercise_1.cs`](./solutions/exercise_1.cs).

## Interview questions

1. **What does a `using` statement/declaration do, and why is it preferred over manual `try`/`finally` for resources?** — It calls `Dispose()` on an `IDisposable` object automatically when the `using` scope ends (normally or via an exception), guaranteeing deterministic cleanup of unmanaged/expensive resources (files, sockets, DB connections) without a manual `finally` block you could forget or get wrong — it's syntactic sugar over exactly that `try`/`finally` + `Dispose` pattern.
2. **Why avoid catching the base `System.Exception` type in most cases?** — It catches *everything*, including exceptions you didn't anticipate and can't meaningfully handle (out-of-memory, programming bugs), which hides defects and can leave the program in a bad state; catching specific types you know how to recover from — and letting the rest propagate — produces more correct, debuggable error handling.

---
← [Previous: OOP](../08_oop/README.md) | [Next: Files and I/O →](../10_files/README.md)
