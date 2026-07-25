# Interview Prep

The same classic problems as the other tracks, in C — which is revealing, because C has no hash map, no dynamic string helpers, and no built-in sort-by-key, so problems that are a few lines elsewhere require more explicit work. This is exactly why C interview questions often focus on pointer manipulation, manual memory, and understanding what higher-level languages do for you.

## Two Sum

Without a built-in hash map, the simplest correct approach in plain C is the O(n²) nested loop. (A production solution would build or import a hash table — the point of this example is that the data structure other languages hand you is itself a project in C.)

```c
// returns 1 and sets *i, *j if a pair summing to target exists; 0 otherwise
int two_sum(const int *nums, int len, int target, int *i, int *j) {
	for (int a = 0; a < len; a++) {
		for (int b = a + 1; b < len; b++) {
			if (nums[a] + nums[b] == target) {
				*i = a; *j = b;
				return 1;
			}
		}
	}
	return 0;
}
```

## Valid Palindrome

Two pointers from both ends, skipping non-alphanumeric characters, comparing lowercase — no allocation needed, which is C's strength for this kind of in-place scan.

```c
int is_palindrome(const char *s) {
	int left = 0, right = (int)strlen(s) - 1;
	while (left < right) {
		while (left < right && !isalnum((unsigned char)s[left])) left++;
		while (left < right && !isalnum((unsigned char)s[right])) right--;
		if (tolower((unsigned char)s[left]) != tolower((unsigned char)s[right]))
			return 0;
		left++; right--;
	}
	return 1;
}
```

See [`example.c`](./example.c) for both, plus a reverse-a-linked-list problem (a C interview staple that directly tests pointer manipulation).

## Common mistakes

1. **Reaching for a hash map that doesn't exist.** In an interview, state the O(n) hash-map approach and its complexity, then note C has no built-in one — either implement a minimal open-addressing table if time allows, or fall back to the O(n²) approach and say why. Showing you know the better approach matters even when you code the simpler one.
2. **Off-by-one and buffer bounds errors** — C gives no runtime bounds checking, so an interview answer that indexes past an array is a real bug, not a caught exception; walk the boundaries carefully.
3. **Not stating time/space complexity unprompted** — same expectation as any language.

## Exercise

Write `struct Node *reverse_list(struct Node *head)` that reverses a singly linked list in place (iteratively, with three pointers: previous, current, next) and returns the new head. The `struct Node { int value; struct Node *next; };` definition is provided in the solution file.

Try it yourself first, then check [`solutions/exercise_1.c`](./solutions/exercise_1.c).

## Interview questions

1. **Why is reversing a linked list a classic C interview question specifically?** — It directly tests pointer manipulation with no library help: you must track three pointers (previous, current, next) and rewire each node's `next` in the right order, which exposes whether a candidate genuinely understands pointers and aliasing rather than relying on higher-level abstractions.
2. **In C, what would implementing an efficient Two Sum actually require, and why is that notable?** — A hash table for O(1) average lookups — which C's standard library doesn't provide, so you'd have to write one (buckets, a hash function, collision handling) or import a third-party one; it highlights how much foundational data-structure work C leaves to the programmer that most other languages include out of the box.

---
← [Previous: Mini Projects](../17_projects/README.md) | Next: (end of C track)
