# Collections

The C++ Standard Template Library (STL) provides the containers C lacks entirely: `std::vector<T>` (dynamic array), `std::map<K,V>` (ordered, tree-based) and `std::unordered_map<K,V>` (hash-based), `std::set`/`std::unordered_set`, plus algorithms (`std::sort`, `std::find`, `std::accumulate`) that work across containers via iterators. Everything manages its own memory via RAII — no manual `malloc`/`free` (the whole hard part of C's `07_collections`).

## Example

```cpp
#include <vector>
#include <unordered_map>
#include <algorithm>
#include <numeric>

std::vector<int> nums{3, 1, 2};
nums.push_back(4);                      // grows automatically
std::sort(nums.begin(), nums.end());     // {1, 2, 3, 4}
int total = std::accumulate(nums.begin(), nums.end(), 0);   // 10

std::unordered_map<std::string, int> counts;
counts["a"]++;                           // default-constructs to 0, then increments
counts["a"]++;                           // now 2

auto it = counts.find("a");
if (it != counts.end()) {
	int value = it->second;              // 2
}
```

See [`example.cpp`](./example.cpp) for the full runnable file.

## Common mistakes

1. **Holding an iterator or reference across a `push_back` that reallocates.** When a `std::vector` grows beyond its capacity, it moves its elements to new storage, invalidating all existing iterators, pointers, and references into it — using one afterward is undefined behavior.
2. **Using `operator[]` on a `std::map`/`unordered_map` to *check* for a key.** `map[key]` **inserts** a default-constructed value if the key is absent (and returns a reference to it), silently growing the map — use `.find(key)` or `.count(key)` / `.contains(key)` (C++20) to check without inserting.
3. **Choosing `std::map` when `std::unordered_map` fits.** `std::map` is a balanced tree (O(log n), keeps keys sorted); `std::unordered_map` is a hash table (O(1) average, no ordering). Use the ordered one only when you actually need sorted iteration.
4. **Ignoring iterator invalidation rules when erasing during iteration.** `erase` returns an iterator to the next element for exactly this reason — `it = container.erase(it)` is the correct pattern, not `container.erase(it++)` guesswork.

## Exercise

Write `std::unordered_map<std::string, int> word_counts(const std::vector<std::string>& words)` returning a map from each word to its occurrence count.

Try it yourself first, then check [`solutions/exercise_1.cpp`](./solutions/exercise_1.cpp).

## Interview questions

1. **What's the difference between `std::map` and `std::unordered_map`, and when would you choose each?** — `std::map` is a balanced binary search tree: O(log n) operations, keeps keys in sorted order; `std::unordered_map` is a hash table: O(1) average operations, no ordering guarantee. Choose `unordered_map` by default for lookups, and `map` only when you need keys iterated in sorted order (or need the ordering-dependent operations like range queries).
2. **Why is `map[key]` risky when you only want to check whether a key exists?** — `operator[]` inserts a default-constructed value for a missing key and returns a reference to it — so merely "checking" with `if (map[key])` mutates the map (adding the key); use `.find()`, `.count()`, or `.contains()` to check without side effects.

---
← [Previous: Functions](../06_functions/README.md) | [Next: OOP →](../08_oop/README.md)
