# Interview Prep

The same classic problems as the other tracks, in C# — useful for comparing the same algorithm across languages, plus C#-specific interview questions.

## Two Sum

```csharp
(int, int)? TwoSum(int[] nums, int target)
{
	var seen = new Dictionary<int, int>();
	for (int i = 0; i < nums.Length; i++)
	{
		if (seen.TryGetValue(target - nums[i], out int j))
		{
			return (j, i);
		}
		seen[nums[i]] = i;
	}
	return null;
}
```

## Valid Palindrome

```csharp
bool IsPalindrome(string s)
{
	var chars = s.Where(char.IsLetterOrDigit).Select(char.ToLowerInvariant).ToList();
	return chars.SequenceEqual(chars.AsEnumerable().Reverse());
}
```

See [`example.cs`](./example.cs) for both, plus merge intervals, all runnable with self-checks.

## Common mistakes

1. **Jumping to code without stating the naive approach's complexity out loud first** — same expectation as any language's interview.
2. **Using `List<T>.Contains` inside a loop instead of a `Dictionary`/`HashSet` lookup**, silently turning an intended O(n) solution into O(n²) — a common gap between "I know the optimal algorithm" and "I actually wrote the optimal algorithm."
3. **Not stating time/space complexity of the final solution unprompted.**

## Exercise

Write `List<List<string>> GroupAnagrams(string[] words)` grouping anagram words together, better than the O(n² · k) all-pairs approach.

Try it yourself first, then check [`solutions/exercise_1.cs`](./solutions/exercise_1.cs).

## Interview questions

1. **Why does the `Dictionary`-based `TwoSum` beat the brute-force nested loop?** — O(n) vs O(n²): the dictionary turns "has the complement been seen" from an O(n) scan into an O(1) average-case lookup, at the cost of O(n) extra space.
2. **What canonical key works for grouping anagrams in C#?** — Sort each word's characters into a `string` (e.g. `new string(word.OrderBy(c => c).ToArray())`) — identical for all anagrams of each other, usable directly as a `Dictionary<string, List<string>>` key.

---
← [Previous: Mini Projects](../17_projects/README.md) | Next: (end of C# track)
