# Interview Prep

The same classic problems as the other tracks, in PHP — useful for comparing the same algorithm across languages, plus PHP-specific interview questions.

## Two Sum

```php
<?php
function twoSum(array $nums, int $target): ?array {
	$seen = [];
	foreach ($nums as $i => $n) {
		$complement = $target - $n;
		if (isset($seen[$complement])) {
			return [$seen[$complement], $i];
		}
		$seen[$n] = $i;
	}
	return null;
}
```

## Valid Palindrome

```php
<?php
function isPalindrome(string $s): bool {
	$chars = strtolower(preg_replace('/[^a-zA-Z0-9]/', '', $s));
	return $chars === strrev($chars);
}
```

See [`example.php`](./example.php) for both, plus merge intervals, all runnable with self-checks.

## Common mistakes

1. **Jumping to code without stating the naive approach's complexity out loud first** — same expectation as any language's interview.
2. **Using `in_array()` inside a loop instead of an associative array (hash) lookup**, silently turning an intended O(n) solution into O(n²) — a common gap between "I know the optimal algorithm" and "I actually wrote the optimal algorithm." (`in_array()` is a linear scan unless the array happens to be used as a hash map via `isset()`.)
3. **Not stating time/space complexity of the final solution unprompted.**

## Exercise

Write `function groupAnagrams(array $words): array` grouping anagram words together, better than the O(n² · k) all-pairs approach.

Try it yourself first, then check [`solutions/exercise_1.php`](./solutions/exercise_1.php).

## Interview questions

1. **Why does the hash-map-based `twoSum` beat the brute-force nested loop?** — O(n) vs O(n²): the associative array turns "has the complement been seen" from an O(n) scan (`in_array`) into an O(1) average-case lookup (`isset`), at the cost of O(n) extra space.
2. **What canonical key works for grouping anagrams in PHP?** — Split the word into characters, sort them, and join back into a string (`$chars = str_split($word); sort($chars); $key = implode('', $chars);`) — identical for all anagrams of each other, usable directly as an associative array key.

---
← [Previous: Mini Projects](../17_projects/README.md) | Next: (end of PHP track)
