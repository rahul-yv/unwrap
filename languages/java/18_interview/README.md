# Interview Prep

The same classic problems as the other tracks, in Java — useful for comparing the same algorithm across languages, plus Java-specific interview questions.

## Two Sum

```java
static int[] twoSum(int[] nums, int target) {
	Map<Integer, Integer> seen = new HashMap<>();
	for (int i = 0; i < nums.length; i++) {
		int complement = target - nums[i];
		if (seen.containsKey(complement)) {
			return new int[] {seen.get(complement), i};
		}
		seen.put(nums[i], i);
	}
	return null;
}
```

## Valid Palindrome

```java
static boolean isPalindrome(String s) {
	int left = 0, right = s.length() - 1;
	while (left < right) {
		while (left < right && !Character.isLetterOrDigit(s.charAt(left))) left++;
		while (left < right && !Character.isLetterOrDigit(s.charAt(right))) right--;
		if (Character.toLowerCase(s.charAt(left)) != Character.toLowerCase(s.charAt(right))) return false;
		left++;
		right--;
	}
	return true;
}
```

See [`Example.java`](./Example.java) for both, plus merge intervals, all runnable with self-checks.

## Common mistakes

1. **Jumping to code without stating the naive approach's complexity out loud first** — same expectation as any language's interview.
2. **Using `Character.isLetterOrDigit` without realizing it's Unicode-aware** (fine — arguably more correct than the ASCII-only checks some other languages' examples use) — worth mentioning out loud that it handles more than just English letters, since an interviewer may ask about that distinction.
3. **Not stating time/space complexity of the final solution unprompted.**

## Exercise

Write `List<List<String>> groupAnagrams(String[] words)` grouping anagram words together, better than the O(n² · k) all-pairs approach.

Try it yourself first, then check [`solutions/Exercise1.java`](./solutions/Exercise1.java).

## Interview questions

1. **Why does the `HashMap`-based `twoSum` beat the brute-force nested loop?** — O(n) vs O(n²): the map turns "has the complement been seen" from an O(n) scan into an O(1) average-case lookup.
2. **What canonical key works for grouping anagrams in Java?** — Convert the word to a `char[]`, sort it with `Arrays.sort`, and wrap it back into a `String` — identical for all anagrams of each other and usable directly as a `HashMap` key (a raw `char[]` isn't, since arrays don't override `equals`/`hashCode` by content).

---
← [Previous: Mini Projects](../17_projects/README.md) | Next: (end of Java track)
