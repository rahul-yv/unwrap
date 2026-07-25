# Loops

C# has `for`, `while`, `do...while`, and `foreach` (the idiomatic way to iterate any `IEnumerable<T>` — arrays, `List<T>`, dictionaries, LINQ query results). `foreach` uses the iterator pattern under the hood and works with lazily-evaluated sequences. C# also has `yield return` for writing your own iterators that produce values on demand.

## Example

```csharp
for (int i = 0; i < 3; i++) {
	Console.WriteLine(i);
}

foreach (var item in new[] { "a", "b", "c" }) {
	Console.WriteLine(item);
}

int n = 0;
while (n < 3) {
	n++;
}

// a custom iterator with yield return — produces values lazily
static IEnumerable<int> Evens(int upTo) {
	for (int i = 0; i <= upTo; i += 2) {
		yield return i;
	}
}
foreach (var e in Evens(6)) {   // 0, 2, 4, 6
	Console.WriteLine(e);
}
```

See [`example.cs`](./example.cs) for the full runnable file.

## Common mistakes

1. **Modifying a collection while `foreach`-ing over it.** Adding or removing elements from a `List<T>` (or dictionary) during a `foreach` throws `InvalidOperationException` ("Collection was modified") — the enumerator detects the change. Iterate a copy, or use an index-based `for` loop (iterating backward) when removing.
2. **Assuming a LINQ query or `yield`-based sequence is already materialized.** These are lazily evaluated — the work happens as you iterate, so iterating twice runs it twice, and a query over a changing source reflects the source at iteration time. Call `.ToList()` to materialize once if needed.
3. **Using a `for` loop with an index when `foreach` is clearer** and you don't need the index — `foreach` avoids off-by-one index errors and reads more directly.
4. **Off-by-one on `for` bounds** — the usual `<` vs `<=` care; `foreach` sidesteps this entirely for whole-collection iteration.

## Exercise

Write `int SumEven(int[] numbers)` returning the sum of the even numbers, using a `foreach` loop.

Try it yourself first, then check [`solutions/exercise_1.cs`](./solutions/exercise_1.cs).

## Interview questions

1. **What does `yield return` do, and why is it useful?** — It lets a method produce a sequence lazily: each `yield return` hands one value to the consumer and pauses the method's state until the next value is requested. This enables writing custom iterators without building the whole collection up front — useful for infinite/large sequences and for composing with LINQ, since values are computed on demand.
2. **Why does modifying a collection during a `foreach` throw an exception?** — `foreach` obtains an enumerator that tracks a version/state of the collection; structural changes (add/remove) invalidate that state, and the enumerator fails fast with `InvalidOperationException` rather than silently skipping or repeating elements — a deliberate safety check.

---
← [Previous: Conditionals](../04_conditions/README.md) | [Next: Functions →](../06_functions/README.md)
