# Interview Prep

The same classic problems as the other tracks, in C++ — where the STL makes them concise (a real hash map for Two Sum, unlike C's O(n²) fallback) while still testing the fundamentals interviewers probe: complexity reasoning, STL fluency, and knowing what the containers cost.

## Two Sum

With `std::unordered_map` available, the O(n) one-pass hash approach is natural:

```cpp
std::optional<std::pair<int, int>> two_sum(const std::vector<int>& nums, int target) {
	std::unordered_map<int, int> seen;
	for (int i = 0; i < static_cast<int>(nums.size()); i++) {
		auto it = seen.find(target - nums[i]);
		if (it != seen.end()) {
			return std::make_pair(it->second, i);
		}
		seen[nums[i]] = i;
	}
	return std::nullopt;
}
```

## Valid Palindrome

Two pointers from both ends, skipping non-alphanumeric, comparing lowercase — in-place, no allocation.

```cpp
bool is_palindrome(const std::string& s) {
	int left = 0, right = static_cast<int>(s.size()) - 1;
	while (left < right) {
		while (left < right && !std::isalnum((unsigned char)s[left])) left++;
		while (left < right && !std::isalnum((unsigned char)s[right])) right--;
		if (std::tolower((unsigned char)s[left]) != std::tolower((unsigned char)s[right]))
			return false;
		left++; right--;
	}
	return true;
}
```

See [`example.cpp`](./example.cpp) for both, plus merge intervals (using `std::sort` with a lambda comparator).

## Common mistakes

1. **Not stating complexity, or reaching for `std::map` when `std::unordered_map` is what you want.** `std::map` is O(log n) ordered; the Two Sum hash approach wants O(1) average lookups, so `unordered_map` — say which and why.
2. **Signed/unsigned mismatches with `.size()`.** `std::vector::size()` returns an unsigned `size_t`; comparing it against a signed `int` index triggers `-Wsign-compare` warnings and can cause subtle bugs — cast deliberately or use consistent types.
3. **Copying containers unnecessarily** — pass by `const&`, and be mindful that returning large containers relies on move semantics/RVO (which C++ provides, but know it's happening).

## Exercise

Write `std::vector<std::vector<std::string>> group_anagrams(const std::vector<std::string>& words)` grouping anagram words together, better than the O(n² · k) all-pairs approach.

Try it yourself first, then check [`solutions/exercise_1.cpp`](./solutions/exercise_1.cpp).

## Interview questions

1. **Why does the `std::unordered_map`-based Two Sum beat the brute-force nested loop, and why `unordered_map` over `map`?** — O(n) vs O(n²): the map turns "has the complement been seen" into an O(1) average lookup instead of an O(n) scan. `unordered_map` (hash table, O(1) average) is preferred over `map` (balanced tree, O(log n)) here because no ordering is needed — only fast membership/lookup.
2. **What's a canonical key for grouping anagrams in C++?** — Sort the word's characters (`std::sort` on a copy of the `std::string`) into a canonical form usable as an `unordered_map` key — identical for all anagrams of each other, so they collide into the same bucket/group.

---
← [Previous: Mini Projects](../17_projects/README.md) | Next: (end of C++ track)
