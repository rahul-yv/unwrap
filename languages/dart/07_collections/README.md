# Collections

Dart's core collections are `List`, `Map`, `Set`, all generic (`List<int>`) and all supporting the usual functional operations (`.map`, `.where`, `.reduce`, `.fold`) via the `Iterable` interface. Collection literals infer their type from context (`[1, 2, 3]` is `List<int>`), and the collection-if/collection-for syntax (seen in the loops topic) lets literals be built conditionally and iteratively inline.

## Example

```dart
final numbers = [1, 2, 3, 4, 5];

final doubled = numbers.map((n) => n * 2).toList();       // [2, 4, 6, 8, 10]
final evens = numbers.where((n) => n.isEven).toList();      // [2, 4]
final total = numbers.fold(0, (acc, n) => acc + n);          // 15

final ages = {"Ada": 36, "Grace": 85};
final adaAge = ages["Ada"];                                  // 36 (int?, nullable — null if key missing)
final missing = ages["Nobody"] ?? 0;                          // 0

final unique = {1, 2, 2, 3}.toList();                         // [1, 2, 3] — Set deduplicates

final lazyResult = numbers
    .map((n) => n * 2)
    .where((n) => n > 4)
    .first;   // 6 — Iterable operations are lazy by default, evaluated on demand
```

See [`example.dart`](./example.dart) for the full runnable file.

## Common mistakes

1. **Forgetting `.map`/`.where` return a lazy `Iterable`, not an eagerly-computed `List`.** Chaining `.map(...).where(...)` doesn't run anything until the result is actually consumed (iterated, or converted with `.toList()`) — this is usually beneficial (short-circuiting works, as in `.first` above), but forgetting to call `.toList()` when a concrete, reusable `List` is needed (rather than a one-shot lazy view) can cause the transformation to re-run every time the `Iterable` is iterated again.
2. **Using `map[key]` and assuming it always returns a non-null value.** It returns `V?` — `null` if the key is absent — reflecting Dart's null safety; use `??` for a default, or `.containsKey()` for an existence check, rather than assuming the lookup always succeeds.
3. **Assuming `Set` preserves insertion order the way `List` does.** `LinkedHashSet` (what `{...}` set literals produce by default) *does* preserve insertion order in Dart, but relying on this without knowing it's specifically `LinkedHashSet`'s behavior (not a general `Set` contract) can be a fragile assumption if the underlying implementation were ever different.
4. **Reaching for a manual loop with an accumulator where `.fold`/`.reduce`/collection-for already express the operation directly** — Dart's `Iterable` methods cover most aggregation and transformation patterns idiomatically without hand-rolled loops.

## Exercise

Write a function `Map<String, int> wordLengths(List<String> words)` that returns a map from each word to its length.

Try it yourself first, then check [`solutions/exercise_1.dart`](./solutions/exercise_1.dart).

## Interview questions

1. **Why does `map[key]` return a nullable type in Dart?** — With sound null safety, a lookup that might not find a matching key must be reflected in the type system — `Map<K, V>.operator []` returns `V?`, forcing callers to handle the "key absent" case (via `??`, a null check, or `.containsKey()`) rather than silently getting an unexpected `null` that a non-nullable `V` would have hidden from the type checker.
2. **What does it mean for `.map`/`.where` to be lazy in Dart, and when does that matter?** — Calling `.map()`/`.where()` on an `Iterable` doesn't immediately process every element — it returns a new lazy `Iterable` that computes each result only as it's actually consumed. This means chaining several such calls and then only asking for `.first` can short-circuit without processing the whole collection, but it also means re-iterating the same lazy chain re-runs all the transformations each time — call `.toList()` once to get a concrete, reusable, eagerly-computed result when that matters.

---
← [Previous: Functions](../06_functions/README.md) | [Next: OOP →](../08_oop/README.md)
