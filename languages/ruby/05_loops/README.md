# Loops

Ruby idiomatically favors iterator methods (`.each`, `.times`, `.map`, `.select`) over explicit `for`/`while` loops — a `for` loop exists but is rarely used, since `.each` reads more naturally and doesn't leak its loop variable into the enclosing scope. `break`/`next`/`redo` control iteration; a labeled equivalent isn't needed since blocks naturally nest and `break`/`next` always apply to the nearest enclosing block.

## Example

```ruby
total = 0
5.times { |i| total += i }        # 0, 1, 2, 3, 4

descending = []
5.step(1, -2) { |i| descending << i }   # 5, 3, 1

items = ["a", "b", "c"]
items.each_with_index { |value, index| puts "#{index}:#{value}" }

count = 0
count += 1 while count < 3

numbers = [1, 2, 3, 4, 5]
evens_doubled = numbers.select(&:even?).map { |n| n * 2 }   # [4, 8]

numbers.each do |n|
  next if n.odd?     # skip to the next iteration
  break if n > 4      # stop iterating entirely
  puts n
end
```

See [`example.rb`](./example.rb) for the full runnable file.

## Common mistakes

1. **Reaching for `for`/`while` where `.each`/`.times`/`.map` would be more idiomatic.** Iterator methods with blocks are Ruby's preferred style — they compose well (`.select.map.reduce`), don't leak the loop variable, and read closer to the intent ("for each item, do X") than manual indexing.
2. **Forgetting `for` (unlike `.each`) does *not* create a new scope for its loop variable** — after a `for i in 0..4` loop, `i` is still accessible in the enclosing scope, unlike `5.times { |i| ... }`, where `i` is local to the block. This scoping difference is one of the reasons `.each`/`.times` are generally preferred.
3. **Using `break` with a value inside a block and expecting the block's caller to see it as the iteration's normal return** — `break value` does exit early and makes the *enclosing method call* (like `.each`) return `value` instead of its usual return value, which is a genuinely useful pattern but easy to use unintentionally if not aware of it.
4. **Mutating a collection while iterating it with `.each`** — like most languages, modifying an array's structure (adding/removing elements) during iteration produces undefined or surprising behavior; build a new collection or iterate over a `.dup` instead.

## Exercise

Write a method `def sum_evens(n)` that returns the sum of all even numbers from `0` to `n` inclusive, using `.step` or a `Range` with `.select`.

Try it yourself first, then check [`solutions/exercise_1.rb`](./solutions/exercise_1.rb).

## Interview questions

1. **Why does idiomatic Ruby favor `.each`/`.times`/`.map` over `for`/`while`?** — Iterator methods with blocks scope their loop variable to the block (no leakage into the enclosing method), compose naturally with other iterator methods (`.select.map`), and read as intent ("for each element, transform it") rather than manual mechanics (initialize, check, increment) — `for` exists mainly for compatibility/familiarity but is rarely the idiomatic choice.
2. **What does `break value` do inside a block passed to `.each`?** — It immediately stops the iteration and makes the *entire method call* that yielded to the block (the `.each` call itself) evaluate to `value`, instead of `.each`'s normal return value (the receiver). This lets a block "return" a result from a search-like iteration without needing a separate accumulator variable declared before the loop.

---
← [Previous: Conditionals](../04_conditions/README.md) | [Next: Functions →](../06_functions/README.md)
