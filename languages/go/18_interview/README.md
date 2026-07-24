# Interview Prep

The same classic problems as the other tracks, in Go — useful for comparing how the same algorithm reads across languages, plus Go-specific interview questions that come up alongside general algorithm ones.

## Two Sum

```go
func twoSum(nums []int, target int) []int {
	seen := make(map[int]int)
	for i, n := range nums {
		if j, ok := seen[target-n]; ok {
			return []int{j, i}
		}
		seen[n] = i
	}
	return nil
}
```

## Valid Palindrome

```go
func isPalindrome(s string) bool {
	isAlnum := func(b byte) bool {
		return (b >= 'a' && b <= 'z') || (b >= 'A' && b <= 'Z') || (b >= '0' && b <= '9')
	}
	left, right := 0, len(s)-1
	for left < right {
		for left < right && !isAlnum(s[left]) {
			left++
		}
		for left < right && !isAlnum(s[right]) {
			right--
		}
		if toLower(s[left]) != toLower(s[right]) {
			return false
		}
		left++
		right--
	}
	return true
}
```

See [`example.go`](./example.go) for both, plus merge intervals, all runnable with self-checks. Note: this byte-based palindrome check assumes ASCII input — see `02_datatypes` for why `s[i]` isn't safe for arbitrary Unicode.

## Common mistakes

1. **Jumping to code without stating the naive approach's complexity first** — same expectation as any language's interview.
2. **Using byte indexing (`s[i]`) on a string that might contain multi-byte UTF-8 characters**, as in the palindrome example above — fine for ASCII-only input (a reasonable simplifying assumption to state out loud), wrong in general; `range` over the string for real Unicode safety.
3. **Not stating time/space complexity of the final solution unprompted.**

## Exercise

Write `groupAnagrams(words []string) [][]string` grouping anagram words together, better than the O(n² · k) all-pairs approach.

Try it yourself first, then check [`solutions/exercise_1.go`](./solutions/exercise_1.go).

## Interview questions

1. **Why does the `twoSum` map-based solution beat the brute-force nested loop?** — O(n) vs O(n²): the map turns "has the complement been seen" from an O(n) scan into an O(1) average-case lookup.
2. **What canonical key works for grouping anagrams in Go?** — Convert each word to a `[]byte`, sort it, and convert back to a `string` as the map key — identical for all anagrams of each other and usable as a map key (Go map keys must be comparable; a `[]byte` itself isn't, but a `string` is).

---
← [Previous: Mini Projects](../17_projects/README.md) | Next: (end of Go track)
