# Interview Prep

The same classic problems as the other tracks, in Ruby — useful for comparing the same algorithm across languages, plus Ruby-specific interview questions.

## Two Sum

```ruby
def two_sum(nums, target)
  seen = {}
  nums.each_with_index do |n, i|
    complement = target - n
    return [seen[complement], i] if seen.key?(complement)
    seen[n] = i
  end
  nil
end
```

## Valid Palindrome

```ruby
def palindrome?(s)
  chars = s.downcase.gsub(/[^a-z0-9]/, "")
  chars == chars.reverse
end
```

See [`example.rb`](./example.rb) for both, plus merge intervals, all runnable with self-checks.

## Common mistakes

1. **Jumping to code without stating the naive approach's complexity out loud first** — same expectation as any language's interview.
2. **Using `.include?` on an array inside a loop instead of a `Hash`/`Set` lookup**, silently turning an intended O(n) solution into O(n²) — a common gap between "I know the optimal algorithm" and "I actually wrote the optimal algorithm." (`Array#include?` is a linear scan; `Hash#key?`/`Set#include?` are O(1) average case.)
3. **Not stating time/space complexity of the final solution unprompted.**

## Exercise

Write `def group_anagrams(words)` grouping anagram words together, better than the O(n² · k) all-pairs approach.

Try it yourself first, then check [`solutions/exercise_1.rb`](./solutions/exercise_1.rb).

## Interview questions

1. **Why does the `Hash`-based `two_sum` beat the brute-force nested loop?** — O(n) vs O(n²): the hash turns "has the complement been seen" from an O(n) scan (`Array#include?`) into an O(1) average-case lookup (`Hash#key?`), at the cost of O(n) extra space.
2. **What canonical key works for grouping anagrams in Ruby?** — Sort each word's characters and join them back into a string (`word.chars.sort.join`) — identical for all anagrams of each other, usable directly as a `Hash` key (or via `.group_by`, which does exactly this pattern in one call).

---
← [Previous: Mini Projects](../17_projects/README.md) | Next: (end of Ruby track)
