# Collections

`Array` and `Hash` are Ruby's core collections, both mutable and packed with `Enumerable` methods (`.map`, `.select`, `.reduce`, `.sort_by`, dozens more) — nearly every collection operation reads as a chain of small, composable calls rather than manual loops. Ruby has no separate read-only collection type; immutability, when wanted, comes from `.freeze` on the object itself.

## Example

```ruby
numbers = [1, 2, 3, 4, 5]

doubled = numbers.map { |n| n * 2 }         # [2, 4, 6, 8, 10]
evens = numbers.select(&:even?)              # [2, 4]
total = numbers.reduce(0) { |acc, n| acc + n }   # 15, or numbers.sum

ages = { "Ada" => 36, "Grace" => 85 }
ada_age = ages["Ada"]                        # 36
missing = ages.fetch("Nobody", 0)            # 0 — fetch with a default avoids a nil surprise

frozen = [1, 2, 3].freeze
# frozen << 4   # raises FrozenError

lazy_result = (1..Float::INFINITY).lazy.map { |n| n * 2 }.select { |n| n > 4 }.first
# 6 — lazy enumerator, stops as soon as the first match is found, even over an infinite range
```

See [`example.rb`](./example.rb) for the full runnable file.

## Common mistakes

1. **Using `hash[key]` and assuming it always returns a meaningful value.** It returns `nil` if the key is absent (no error) — `hash.fetch(key)` raises `KeyError` for a missing key (making a typo obvious immediately), and `hash.fetch(key, default)` provides an explicit fallback — both are safer than a bare `[]` when "missing" shouldn't silently become `nil`.
2. **Chaining many eager `Enumerable` methods on a large or infinite collection where `.lazy` would avoid building intermediate arrays at every step.** `.map.select` on a plain array fully materializes each intermediate result; `.lazy.map.select.first` only evaluates as many elements as needed to satisfy the terminal call.
3. **Assuming `.freeze` deeply freezes a nested structure.** `array.freeze` prevents changes to the array itself (`<<`, `[]=`), but if it contains mutable objects (strings, nested arrays), those inner objects are still mutable unless frozen individually — freezing is shallow by default.
4. **Reaching for a manual loop with an accumulator variable where `.reduce`/`.sum`/`.tally`/`.group_by` already express the operation directly** — Ruby's `Enumerable` module covers most aggregation patterns idiomatically without hand-rolled loops.

## Exercise

Write a method `def word_lengths(words)` that returns a hash mapping each word to its length.

Try it yourself first, then check [`solutions/exercise_1.rb`](./solutions/exercise_1.rb).

## Interview questions

1. **What's the difference between `hash[key]` and `hash.fetch(key)`?** — `hash[key]` returns `nil` if the key is absent, silently — a typo'd key name produces `nil` with no error, which can propagate confusingly. `hash.fetch(key)` raises `KeyError` immediately if the key is missing, surfacing the mistake at its source; `hash.fetch(key, default)` (or with a block) provides an explicit fallback instead of `nil`.
2. **When does `.lazy` matter for `Enumerable` chains?** — Without `.lazy`, each method in a chain (`.map`, `.select`) fully processes and materializes its input into a new array before the next method runs — wasteful for long chains or unnecessary if a terminal call like `.first` only needs a few results. `.lazy` makes the chain evaluate one element at a time, pulling only as many through as the terminal operation needs — essential for working with infinite or very large sequences.

---
← [Previous: Functions](../06_functions/README.md) | [Next: OOP →](../08_oop/README.md)
