# Interview Prep

The same classic problems as the Python track's interview topic, solved idiomatically in JavaScript — useful for seeing how the same algorithmic ideas look across languages.

## Two Sum

**Naive:** check every pair — O(n²) time, O(1) space.
**Better:** one pass with a `Map` from value → index. O(n) time, O(n) space.

```javascript
function twoSum(nums, target) {
  const seen = new Map();
  for (let i = 0; i < nums.length; i++) {
    const complement = target - nums[i];
    if (seen.has(complement)) return [seen.get(complement), i];
    seen.set(nums[i], i);
  }
  return null;
}
```

## Valid Palindrome

Two pointers from both ends, skipping non-alphanumeric characters, comparing lowercase. O(n) time, O(1) extra space.

```javascript
function isPalindrome(s) {
  const isAlnum = (c) => /[a-z0-9]/i.test(c);
  let left = 0;
  let right = s.length - 1;
  while (left < right) {
    while (left < right && !isAlnum(s[left])) left++;
    while (left < right && !isAlnum(s[right])) right--;
    if (s[left].toLowerCase() !== s[right].toLowerCase()) return false;
    left++;
    right--;
  }
  return true;
}
```

## Merge Intervals

Sort by start, then merge overlapping runs. O(n log n), dominated by the sort.

```javascript
function mergeIntervals(intervals) {
  if (intervals.length === 0) return [];
  const sorted = [...intervals].sort((a, b) => a[0] - b[0]);
  const merged = [sorted[0]];
  for (const [start, end] of sorted.slice(1)) {
    const last = merged[merged.length - 1];
    if (start <= last[1]) {
      last[1] = Math.max(last[1], end);
    } else {
      merged.push([start, end]);
    }
  }
  return merged;
}
```

See [`example.js`](./example.js) for all three, runnable with self-checks.

## Common mistakes

1. **Jumping to code without stating the naive approach and its complexity out loud first.** Interviewers want to see the reasoning, not just the final answer.
2. **Not naming edge cases before coding** — empty array, single element, all duplicates.
3. **Not stating time/space complexity of the final solution unprompted.**

## Exercise

Write `groupAnagrams(words)` grouping anagram words together, better than the O(n² · k) approach of comparing every pair.

Try it yourself first, then check [`solutions/exercise_1.js`](./solutions/exercise_1.js).

## Interview questions

1. **Why does the `Map`-based `twoSum` beat the brute-force nested loop?** — O(n) vs O(n²): trading O(n) space for turning "has the complement been seen" into an O(1) average lookup instead of an O(n) scan.
2. **Why sort first in `mergeIntervals`?** — Overlaps can only be detected between adjacent intervals once sorted by start; without sorting, every pair would need comparing, which is O(n²).
3. **What canonical key works for grouping anagrams?** — Letters sorted into a fixed order (e.g. `word.split("").sort().join("")`) is identical for all anagrams of each other and usable as a `Map` key.

---
← [Previous: Mini Projects](../17_projects/README.md) | Next: (end of JavaScript track)
