# Interview Prep

The same classic problems as the other tracks, in Swift — useful for comparing the same algorithm across languages, plus Swift-specific interview questions.

## Two Sum

```swift
func twoSum(_ nums: [Int], _ target: Int) -> (Int, Int)? {
	var seen: [Int: Int] = [:]
	for (i, n) in nums.enumerated() {
		if let j = seen[target - n] {
			return (j, i)
		}
		seen[n] = i
	}
	return nil
}
```

## Valid Palindrome

```swift
func isPalindrome(_ s: String) -> Bool {
	let chars = s.lowercased().filter { $0.isLetter || $0.isNumber }
	return chars == String(chars.reversed())
}
```

See [`example.swift`](./example.swift) for both, plus merge intervals, all runnable with self-checks.

## Common mistakes

1. **Jumping to code without stating the naive approach's complexity out loud first** — same expectation as any language's interview.
2. **Using `Array.contains` inside a loop instead of a `Dictionary`/`Set` lookup**, silently turning an intended O(n) solution into O(n²) — a common gap between "I know the optimal algorithm" and "I actually wrote the optimal algorithm."
3. **Not stating time/space complexity of the final solution unprompted.**

## Exercise

Write `func groupAnagrams(_ words: [String]) -> [[String]]` grouping anagram words together, better than the O(n² · k) all-pairs approach.

Try it yourself first, then check [`solutions/exercise_1.swift`](./solutions/exercise_1.swift).

## Interview questions

1. **Why does the `Dictionary`-based `twoSum` beat the brute-force nested loop?** — O(n) vs O(n²): the dictionary turns "has the complement been seen" from an O(n) scan into an O(1) average-case lookup, at the cost of O(n) extra space.
2. **What canonical key works for grouping anagrams in Swift?** — Sort each word's characters into a `String` (e.g. `String(word.sorted())`) — identical for all anagrams of each other, usable directly as a `[String: [String]]` dictionary key.

---
← [Previous: Mini Projects](../17_projects/README.md) | Next: (end of Swift track)
