# Collections

The Java Collections Framework centers on interfaces (`List`, `Set`, `Map`) with multiple implementations to choose from: `ArrayList` (resizable array, fast random access) vs `LinkedList` (fast insert/remove at ends); `HashMap` (no order guarantee) vs `LinkedHashMap` (insertion order) vs `TreeMap` (sorted by key); `HashSet` vs `TreeSet`. Generics (`List<String>`) give compile-time type safety over what used to be raw, unchecked collections in older Java.

## Example

```java
List<Integer> nums = new ArrayList<>(List.of(1, 2, 3, 4, 5));
List<Integer> squares = nums.stream().map(n -> n * n).toList();

Map<String, Integer> scores = new HashMap<>();
scores.put("a", 1);
Integer value = scores.get("a");        // 1
Integer missing = scores.get("z");       // null, not an exception
Integer withDefault = scores.getOrDefault("z", 0);  // 0

Set<Integer> unique = new HashSet<>(List.of(1, 2, 2, 3));  // {1, 2, 3}
```

See [`Example.java`](./Example.java) for the full runnable file.

## Common mistakes

1. **Calling `.get(key)` on a `Map` and using the result without a `null` check**, then hitting `NullPointerException` when unboxing it into a primitive (`int x = map.get(missingKey);` throws, since `null` can't unbox to `int`). Use `.getOrDefault(key, default)` or check for `null` first.
2. **Using `List.of(...)` and then trying to mutate the result.** `List.of()` returns an *immutable* list — `.add()`/`.remove()` throw `UnsupportedOperationException`. Wrap it in `new ArrayList<>(List.of(...))` for a mutable copy.
3. **Choosing `ArrayList` by default without considering access patterns.** `ArrayList` is usually right, but frequent insertion/removal at the front/middle is O(n) for `ArrayList` and O(1) for `LinkedList` at the ends — pick based on the actual usage pattern.
4. **Comparing collections with `==` instead of `.equals()`.** Like any reference type, `==` checks identity; `List`/`Map`/`Set` all override `.equals()` to compare contents.

## Exercise

Write `Map<String, Integer> wordCounts(List<String> words)` returning a map from each word to its occurrence count.

Try it yourself first, then check [`solutions/Exercise1.java`](./solutions/Exercise1.java).

## Interview questions

1. **What's the difference between `HashMap` and `TreeMap`?** — `HashMap` gives O(1) average-case get/put with no ordering guarantee; `TreeMap` gives O(log n) get/put but keeps keys sorted (by natural order or a supplied `Comparator`), useful when iteration order matters.
2. **Why does `map.get(missingKey)` return `null` instead of throwing?** — `Map.get` is designed to signal "not present" via `null` for reference types, distinct from `Map.getOrDefault` (explicit fallback) — but this means unboxing the result directly into a primitive can throw `NullPointerException` if the key was actually missing.

---
← [Previous: Functions](../06_functions/README.md) | [Next: OOP →](../08_oop/README.md)
