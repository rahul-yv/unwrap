# Interview Prep

The same classic problems as the other tracks, in Kotlin — useful for comparing the same algorithm across languages, plus Kotlin-specific interview questions.

## Two Sum

```kotlin
fun twoSum(nums: IntArray, target: Int): Pair<Int, Int>? {
	val seen = mutableMapOf<Int, Int>()
	for (i in nums.indices) {
		val complement = target - nums[i]
		seen[complement]?.let { j -> return j to i }
		seen[nums[i]] = i
	}
	return null
}
```

## Valid Palindrome

```kotlin
fun isPalindrome(s: String): Boolean {
	val chars = s.filter { it.isLetterOrDigit() }.lowercase()
	return chars == chars.reversed()
}
```

See [`example.kt`](./example.kt) for both, plus merge intervals, all runnable with self-checks.

## Common mistakes

1. **Jumping to code without stating the naive approach's complexity out loud first** — same expectation as any language's interview.
2. **Using `List.contains` inside a loop instead of a `Map`/`Set` lookup**, silently turning an intended O(n) solution into O(n²) — a common gap between "I know the optimal algorithm" and "I actually wrote the optimal algorithm."
3. **Not stating time/space complexity of the final solution unprompted.**

## Exercise

Write `fun groupAnagrams(words: List<String>): List<List<String>>` grouping anagram words together, better than the O(n² · k) all-pairs approach.

Try it yourself first, then check [`solutions/exercise_1.kt`](./solutions/exercise_1.kt).

## Interview questions

1. **Why does the `Map`-based `twoSum` beat the brute-force nested loop?** — O(n) vs O(n²): the map turns "has the complement been seen" from an O(n) scan into an O(1) average-case lookup, at the cost of O(n) extra space.
2. **What canonical key works for grouping anagrams in Kotlin?** — Sort each word's characters into a `String` (e.g. `word.toCharArray().sorted().joinToString("")`) — identical for all anagrams of each other, usable directly as a `Map<String, MutableList<String>>` key.

---
← [Previous: Mini Projects](../17_projects/README.md) | Next: (end of Kotlin track)
