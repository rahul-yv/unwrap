# Interview Prep

Classic problems, solved idiomatically in Python, with the reasoning and complexity that interviewers actually want to hear — not just working code.

## Two Sum

Given a list of numbers and a target, return the indices of two numbers that add up to the target.

**Naive approach:** check every pair — O(n²) time, O(1) space.
**Better:** one pass with a dict mapping value → index. For each number, check whether `target - number` was already seen. O(n) time, O(n) space.

```python
def two_sum(nums, target):
    seen = {}
    for i, n in enumerate(nums):
        complement = target - n
        if complement in seen:
            return [seen[complement], i]
        seen[n] = i
    return None
```

## Valid Palindrome

Check whether a string reads the same forwards and backwards, ignoring case and non-alphanumeric characters.

**Approach:** two pointers from both ends, skipping non-alphanumeric characters, comparing lowercase. O(n) time, O(1) extra space (excluding input).

```python
def is_palindrome(s):
    left, right = 0, len(s) - 1
    while left < right:
        while left < right and not s[left].isalnum():
            left += 1
        while left < right and not s[right].isalnum():
            right -= 1
        if s[left].lower() != s[right].lower():
            return False
        left += 1
        right -= 1
    return True
```

## Merge Intervals

Given a list of `[start, end]` intervals, merge all overlapping ones.

**Approach:** sort by start; walk through, merging with the last interval in the result if it overlaps. O(n log n) time (dominated by the sort).

```python
def merge_intervals(intervals):
    if not intervals:
        return []
    intervals = sorted(intervals, key=lambda pair: pair[0])
    merged = [intervals[0]]
    for start, end in intervals[1:]:
        last_start, last_end = merged[-1]
        if start <= last_end:
            merged[-1] = [last_start, max(last_end, end)]
        else:
            merged.append([start, end])
    return merged
```

See [`example.py`](./example.py) for all three, runnable with self-checks.

## Common mistakes

1. **Jumping straight to code without stating the naive approach and its complexity first.** Interviewers want to see you recognize the O(n²) solution, then explain *why* you're improving it — not just produce the optimal answer silently.
2. **Ignoring edge cases out loud** — empty input, one element, all-duplicate values. Naming them before coding shows you've actually thought about correctness.
3. **Not stating time/space complexity of the final solution unprompted.** Say it before being asked.

## Exercise

Write `group_anagrams(words)` that groups words that are anagrams of each other, returning a list of groups (order of groups and order within groups don't matter, but every input word must appear in exactly one group). Aim for better than the O(n² · k) approach of comparing every pair of words.

Try it yourself first, then check [`solutions/exercise_1.py`](./solutions/exercise_1.py).

## Interview questions

1. **What's the time complexity of `two_sum`, and why does the dict approach beat the brute-force nested loop?** — O(n) vs O(n²): the dict trades O(n) extra space for turning "has the complement been seen" from an O(n) scan into an O(1) average-case lookup.
2. **Why sort first in `merge_intervals`?** — Overlaps can only be detected between intervals that are adjacent once sorted by start time; without sorting you'd need to compare every pair, which is O(n²).
3. **What makes two words anagrams of each other, and how can that be turned into a hashable key?** — They contain the same letters in the same multiset (frequency). Sorting a word's letters into a canonical form (or a tuple of letter counts) gives a value that's identical for all anagrams of each other and can be used as a dict key.

---
← [Previous: Mini Projects](../17_projects/README.md) | Next: (end of Python track)
