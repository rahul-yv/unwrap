# Interview Prep

The same classic problems as the other tracks, in Rust — useful for comparing the same algorithm across languages, plus Rust-specific interview questions.

## Two Sum

```rust
use std::collections::HashMap;

fn two_sum(nums: &[i32], target: i32) -> Option<(usize, usize)> {
	let mut seen: HashMap<i32, usize> = HashMap::new();
	for (i, &n) in nums.iter().enumerate() {
		if let Some(&j) = seen.get(&(target - n)) {
			return Some((j, i));
		}
		seen.insert(n, i);
	}
	None
}
```

## Valid Palindrome

```rust
fn is_palindrome(s: &str) -> bool {
	let chars: Vec<char> = s.chars().filter(|c| c.is_alphanumeric()).collect();
	let lowered: Vec<char> = chars.iter().map(|c| c.to_ascii_lowercase()).collect();
	lowered.iter().eq(lowered.iter().rev())
}
```

See [`example.rs`](./example.rs) for both, plus merge intervals, all runnable with self-checks.

## Common mistakes

1. **Jumping to code without stating the naive approach's complexity out loud first** — same expectation as any language's interview.
2. **Fighting the borrow checker mid-interview instead of restructuring around it.** A "the compiler won't let me do this" moment in an interview is a chance to explain *why* (aliasing/ownership) and adjust the approach — showing that understanding, not just producing code that compiles by trial and error, is usually more valuable to the interviewer.
3. **Not stating time/space complexity of the final solution unprompted.**

## Exercise

Write `fn group_anagrams(words: &[&str]) -> Vec<Vec<String>>` grouping anagram words together, better than the O(n² · k) all-pairs approach.

Try it yourself first, then check [`solutions/exercise_1.rs`](./solutions/exercise_1.rs).

## Interview questions

1. **Why does the `HashMap`-based `two_sum` beat the brute-force nested loop?** — O(n) vs O(n²): the map turns "has the complement been seen" from an O(n) scan into an O(1) average-case lookup.
2. **What canonical key works for grouping anagrams in Rust?** — Collect the word's characters into a `Vec<char>`, sort it, and convert to a `String` — identical for all anagrams of each other and usable directly as a `HashMap` key.

---
← [Previous: Mini Projects](../17_projects/README.md) | Next: (end of Rust track)
