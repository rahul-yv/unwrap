# Interview Prep

The same classic problems as the other tracks, in Dart — useful for comparing the same algorithm across languages, plus Dart-specific interview questions.

## Two Sum

```dart
List<int>? twoSum(List<int> nums, int target) {
	final seen = <int, int>{};
	for (int i = 0; i < nums.length; i++) {
		final complement = target - nums[i];
		if (seen.containsKey(complement)) {
			return [seen[complement]!, i];
		}
		seen[nums[i]] = i;
	}
	return null;
}
```

## Valid Palindrome

```dart
bool isPalindrome(String s) {
	final chars = s.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');
	return chars == chars.split('').reversed.join();
}
```

See [`example.dart`](./example.dart) for both, plus merge intervals, all runnable with self-checks.

## Common mistakes

1. **Jumping to code without stating the naive approach's complexity out loud first** — same expectation as any language's interview.
2. **Using `List.contains` inside a loop instead of a `Map`/`Set` lookup**, silently turning an intended O(n) solution into O(n²) — a common gap between "I know the optimal algorithm" and "I actually wrote the optimal algorithm."
3. **Not stating time/space complexity of the final solution unprompted.**

## Exercise

Write `List<List<String>> groupAnagrams(List<String> words)` grouping anagram words together, better than the O(n² · k) all-pairs approach.

Try it yourself first, then check [`solutions/exercise_1.dart`](./solutions/exercise_1.dart).

## Interview questions

1. **Why does the `Map`-based `twoSum` beat the brute-force nested loop?** — O(n) vs O(n²): the map turns "has the complement been seen" from an O(n) scan into an O(1) average-case lookup, at the cost of O(n) extra space.
2. **What canonical key works for grouping anagrams in Dart?** — Sort each word's characters into a `String` (`(word.split('')..sort()).join()`) — identical for all anagrams of each other, usable directly as a `Map<String, List<String>>` key.

---
← [Previous: Mini Projects](../17_projects/README.md) | Next: (end of Dart track)
