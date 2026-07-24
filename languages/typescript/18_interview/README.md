# Interview Prep

The same classic problems as the Python and JavaScript tracks, typed — useful for seeing how the same algorithm reads with explicit types, and for the TypeScript-specific interview questions that come up alongside general algorithm questions.

## Two Sum

```typescript
function twoSum(nums: number[], target: number): [number, number] | null {
	const seen = new Map<number, number>();
	for (let i = 0; i < nums.length; i++) {
		const complement = target - nums[i];
		if (seen.has(complement)) return [seen.get(complement)!, i];
		seen.set(nums[i], i);
	}
	return null;
}
```

Note the `!` (non-null assertion) after `seen.get(complement)` — the code just checked `seen.has(complement)` on the line above, so the compiler can't (in this case) infer that `.get` will succeed, even though the logic guarantees it. This is one of the few legitimate everyday uses of `!`: right after a check that makes it provably safe.

## Valid Palindrome & Merge Intervals

Same algorithms as the JavaScript track, with parameter/return types added — see [`example.ts`](./example.ts) for all three, runnable with self-checks.

## Common mistakes

1. **Reaching for `!` out of habit rather than because a prior check just proved it's safe** — see the discussion above; each use of `!` should be justifiable by the two lines around it, not a general "make the error go away" habit.
2. **Not stating time/space complexity of the final solution unprompted** — same expectation as any language's interview.
3. **Over-typing simple local variables** in a live coding interview, spending time on annotations inference would have handled — lean on inference for locals, spend the typing effort on function signatures.

## Exercise

Write `groupAnagrams(words: string[]): string[][]` grouping anagram words together, better than the O(n² · k) all-pairs approach.

Try it yourself first, then check [`solutions/exercise_1.ts`](./solutions/exercise_1.ts).

## Interview questions

1. **When is using the non-null assertion (`!`) justified?** — Only when the surrounding code just proved the value can't be `null`/`undefined` in a way the compiler can't itself infer (e.g. right after a `.has()` check before a `.get()`); anywhere else, it's suppressing a real signal.
2. **How would you type a generic `groupBy<T, K>` function, and what does that buy you over a JavaScript version?** — `function groupBy<T, K>(items: T[], keyFn: (item: T) => K): Map<K, T[]>` — the caller gets a correctly-typed `Map` back with keys of whatever `keyFn` returns and values as arrays of the original item type, catching a mismatched key function at the call site instead of at first use.

---
← [Previous: Mini Projects](../17_projects/README.md) | Next: (end of TypeScript track)
