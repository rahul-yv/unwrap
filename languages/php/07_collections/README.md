# Collections

PHP has one built-in composite type — `array` — which doubles as both a list (sequential integer keys) and a map (any mix of string/integer keys), unlike languages with separate `List`/`Map`/`Set` types. Arrays are ordered (iteration follows insertion order, not key order) and value types (copied on assignment). `array_map`, `array_filter`, and `array_reduce` provide the usual functional operations.

## Example

```php
<?php
$numbers = [1, 2, 3, 4, 5];

$doubled = array_map(fn($n) => $n * 2, $numbers);        // [2, 4, 6, 8, 10]
$evens = array_filter($numbers, fn($n) => $n % 2 === 0);  // [1 => 2, 3 => 4] — keeps original keys!
$total = array_reduce($numbers, fn($acc, $n) => $acc + $n, 0);   // 15

$ages = ["Ada" => 36, "Grace" => 85];
$adaAge = $ages["Ada"] ?? null;    // 36 — ?? avoids a warning if the key is missing

$evensReindexed = array_values($evens);   // [2, 4] — renumber keys after filtering
```

See [`example.php`](./example.php) for the full runnable file.

## Common mistakes

1. **Forgetting `array_filter` preserves the original keys** rather than reindexing — iterating the result with a `for` loop assuming sequential `0, 1, 2, ...` keys will skip or error on the gaps; use `array_values()` to reindex, or `foreach` (which handles arbitrary keys correctly) instead.
2. **Accessing an array key without `isset()`/`??` and triggering an "Undefined array key" warning.** PHP arrays don't error on a missing key the way some languages throw, but they do warn (as of PHP 8) — always guard with `??` (for a default value) or `isset()`/`array_key_exists()` (for a presence check) when the key might not exist.
3. **Confusing `isset($arr['key'])` with `array_key_exists('key', $arr)`.** `isset()` returns `false` if the key exists but its value is `null`; `array_key_exists()` returns `true` in that case — the distinction matters when `null` is a meaningful stored value, not just "absent."
4. **Using `array_merge()` on numerically-keyed arrays when array union (`+`) or explicit re-indexing was actually intended** — `array_merge` renumbers integer keys (appending both arrays' elements sequentially), which is usually right for lists but wrong if the original integer keys carried meaning.

## Exercise

Write a function `function wordLengths(array $words): array` that returns an associative array mapping each word to its length.

Try it yourself first, then check [`solutions/exercise_1.php`](./solutions/exercise_1.php).

## Interview questions

1. **Why does PHP have only one array type instead of separate list/map/set types?** — PHP's `array` is internally an ordered hash map that supports both sequential integer keys (functioning as a list) and arbitrary string/integer keys (functioning as a map) in the same structure — a deliberate simplification from PHP's early design that trades some type-safety and specialization for a single, flexible, uniformly-handled collection type used everywhere.
2. **Why does `array_filter` preserve original keys, and what's the practical implication?** — It's designed to let you know which original elements survived the filter (useful when keys carry meaning, like array indices tied to another parallel array) — but it means the result may have "gaps" in numeric keys, so code that assumes a filtered list is re-indexed from 0 needs an explicit `array_values()` call first.

---
← [Previous: Functions](../06_functions/README.md) | [Next: OOP →](../08_oop/README.md)
