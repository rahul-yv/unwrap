# Functions

C# methods support overloading, optional parameters (with defaults), named arguments, `out`/`ref`/`in` parameter modifiers, and expression-bodied members (`=>`). Lambdas (`x => x + 1`) and delegates (`Func<>`, `Action<>`) make functions first-class values, powering LINQ. Local functions (a method defined inside another method) and closures capture their enclosing scope.

## Example

```csharp
static string Greet(string name, string greeting = "Hello") =>   // optional param, expression body
	$"{greeting}, {name}!";

Greet("Ada");                       // "Hello, Ada!"
Greet("Ada", greeting: "Hi");        // "Hi, Ada!" — named argument

// out parameter: an additional output alongside the return value
static bool TryParseInt(string s, out int result) =>
	int.TryParse(s, out result);

// Func<> as a first-class value; a closure capturing `n`
static Func<int, int> MakeAdder(int n) => x => x + n;
var addFive = MakeAdder(5);
int r = addFive(3);                  // 8

// LINQ: functions passed to query operators
var evens = new[] { 1, 2, 3, 4 }.Where(x => x % 2 == 0).ToList();   // {2, 4}
```

See [`example.cs`](./example.cs) for the full runnable file.

## Common mistakes

1. **Reusing a captured loop variable across closures (pre-C# 5 `for` semantics).** In modern C#, `foreach` gives each iteration a fresh variable, so closures capture distinct values — but a classic `for (int i = ...)` loop shares the single `i`, so lambdas created inside capture the *same* `i` (its final value). Copy it to a local inside the loop if you need per-iteration capture.
2. **Ignoring the difference between `out`, `ref`, and `in`.** `out` = the method must assign it (output only); `ref` = passed in and can be modified (input/output); `in` = passed by reference but read-only (an optimization for large structs). Using the wrong one is a compile error, but knowing which to reach for matters.
3. **Materializing a LINQ result too early or too late.** LINQ methods like `.Where()` are deferred (lazy) — nothing runs until you enumerate; forgetting `.ToList()`/`.ToArray()` when you need a snapshot (or calling it prematurely and losing laziness) are both common.
4. **Overusing optional parameters where overloads would be clearer**, or mixing many optional parameters so call sites become ambiguous — named arguments help, but a few focused overloads are often more readable.

## Exercise

Write a method `Func<int> MakeCounter()` returning a function; each call to the returned function returns an incrementing count starting at 1 (use a closure over a local variable).

Try it yourself first, then check [`solutions/exercise_1.cs`](./solutions/exercise_1.cs).

## Interview questions

1. **What's the difference between `out`, `ref`, and `in` parameters?** — `out`: the argument need not be initialized by the caller, and the method *must* assign it before returning (output-only, used for "try" patterns); `ref`: the argument must be initialized and the method may read and modify it (bidirectional); `in`: passed by reference for efficiency but read-only — the method can't modify it (useful for passing large structs without copying).
2. **What makes LINQ's query operators "deferred," and why does it matter?** — Operators like `Where`/`Select` return a query object that hasn't executed yet; the actual work happens only when you enumerate the result (via `foreach`, `.ToList()`, etc.). This enables composing queries efficiently and short-circuiting, but means enumerating twice re-runs the query, and a query over a mutable source reflects its state at enumeration time — call `.ToList()` to capture a snapshot.

---
← [Previous: Loops](../05_loops/README.md) | Next: Collections (coming soon)
