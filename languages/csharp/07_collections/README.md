# Collections

C#'s generic collections live in `System.Collections.Generic`: `List<T>` (dynamic array), `Dictionary<TKey, TValue>` (hash map), `HashSet<T>`, plus `Queue<T>`/`Stack<T>`. LINQ (`System.Linq`) layers query operators (`Where`, `Select`, `OrderBy`, `GroupBy`, `Sum`) over any `IEnumerable<T>`, giving SQL-like data manipulation. Prefer the generic collections over the legacy non-generic ones (`ArrayList`, `Hashtable`) — generics give compile-time type safety and avoid boxing.

## Example

```csharp
using System.Linq;

var nums = new List<int> { 3, 1, 2 };
nums.Add(4);
nums.Sort();                                  // {1, 2, 3, 4}
int total = nums.Sum();                        // 10 (LINQ)

var counts = new Dictionary<string, int>();
counts["a"] = counts.GetValueOrDefault("a") + 1;   // safe default, no KeyNotFoundException

if (counts.TryGetValue("a", out int value)) {  // idiomatic lookup
	// value is the count
}

var evens = nums.Where(n => n % 2 == 0).ToList();   // {2, 4}
```

See [`example.cs`](./example.cs) for the full runnable file.

## Common mistakes

1. **Indexing a `Dictionary` with `dict[key]` for a possibly-absent key.** `dict[missingKey]` throws `KeyNotFoundException` (unlike some languages that return a default) — use `TryGetValue`, `GetValueOrDefault`, or `ContainsKey` to look up safely.
2. **Using the legacy non-generic collections (`ArrayList`, `Hashtable`).** They store `object`, losing type safety and boxing value types (a performance and correctness hazard) — always use the generic `List<T>`/`Dictionary<K,V>` in modern C#.
3. **Enumerating a LINQ query multiple times unintentionally.** LINQ is deferred — each enumeration re-runs the query against the current source; call `.ToList()`/`.ToArray()` once if you need a stable snapshot or will iterate repeatedly.
4. **Modifying a collection during a `foreach` over it** — throws `InvalidOperationException`, same as covered in `05_loops`; build a new collection or iterate a copy.

## Exercise

Write `Dictionary<string, int> WordCounts(string[] words)` returning a dictionary from each word to its occurrence count.

Try it yourself first, then check [`solutions/exercise_1.cs`](./solutions/exercise_1.cs).

## Interview questions

1. **Why prefer `Dictionary<K,V>` over the legacy `Hashtable`?** — `Dictionary<K,V>` is generic: it's type-safe at compile time (keys and values have fixed types, no casting) and avoids boxing value-type keys/values into `object` (which `Hashtable` does, hurting performance and allocating). The non-generic collections predate generics and exist mainly for backward compatibility.
2. **What does it mean that LINQ queries are "deferred," and how do you force evaluation?** — A LINQ query (built from `Where`, `Select`, etc.) doesn't execute when defined — it runs each time you enumerate it (via `foreach` or a terminal operator). To execute once and capture the results, call a materializing operator like `.ToList()`, `.ToArray()`, or `.Count()`.

---
← [Previous: Functions](../06_functions/README.md) | [Next: OOP →](../08_oop/README.md)
