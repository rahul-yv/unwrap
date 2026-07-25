# Loops

C++ has C's classic `for`, `while`, `do...while`, and adds the **range-based for loop** (`for (auto x : container)`, since C++11) — the idiomatic way to iterate any standard container or array without manual indexing or iterators. The reference qualifier matters: `for (auto x : v)` copies each element, `for (auto& x : v)` binds a reference (to modify in place or avoid copying), `for (const auto& x : v)` is a read-only reference (the efficient default for read-only iteration of non-trivial types).

## Example

```cpp
std::vector<int> nums{1, 2, 3};

for (int x : nums) {              // copies each element
	std::cout << x << "\n";
}

for (auto& x : nums) {            // reference: modifies in place
	x *= 2;                       // nums is now {2, 4, 6}
}

for (const auto& x : nums) {      // const reference: read-only, no copy
	std::cout << x << "\n";
}

for (int i = 0; i < 3; i++) {     // classic form still available
	// ...
}
```

See [`example.cpp`](./example.cpp) for the full runnable file.

## Common mistakes

1. **Copying each element with `for (auto x : container)` when the elements are expensive to copy** (strings, large structs) and you only need to read them — use `for (const auto& x : container)` to iterate by reference with no copy.
2. **Using `for (auto& x : v)` and expecting to modify a copy** — the reference means changes to `x` affect the actual container element. If you want a modifiable copy that doesn't touch the original, use `auto x` (by value) explicitly.
3. **Modifying a container's size (adding/removing elements) while range-iterating it.** The range-based for holds iterators internally; inserting or erasing can invalidate them, causing undefined behavior — collect changes and apply them after, or use an index/iterator loop designed for mutation.
4. **Off-by-one in a classic index loop** where a range-based for would eliminate the risk entirely — prefer range-based for whenever you don't actually need the index.

## Exercise

Write `int sum_even(const std::vector<int>& numbers)` returning the sum of the even numbers, using a range-based for loop with a `const&`.

Try it yourself first, then check [`solutions/exercise_1.cpp`](./solutions/exercise_1.cpp).

## Interview questions

1. **What's the difference between `for (auto x : v)`, `for (auto& x : v)`, and `for (const auto& x : v)`?** — `auto x` copies each element (safe but potentially wasteful for large types); `auto& x` binds a mutable reference (modifies the container's elements in place, no copy); `const auto& x` binds a read-only reference (no copy, can't modify) — the last is the efficient default for read-only iteration of anything non-trivial.
2. **Why is modifying a container's size during a range-based for loop dangerous?** — The loop uses iterators (or begin/end) captured at the start; operations that change the container's size (like `push_back` triggering a reallocation, or `erase`) can invalidate those iterators, so continuing to use them is undefined behavior.

---
← [Previous: Conditionals](../04_conditions/README.md) | [Next: Functions →](../06_functions/README.md)
