# Conditionals

C++ has C's `if`/`else`/ternary/`switch`, plus a few modern additions: an `if` with an initializer (`if (auto it = m.find(k); it != m.end())`) that scopes a variable to the `if`/`else`, and `std::string`/container comparisons via overloaded operators (so `if (name == "Ada")` works directly, unlike C's `strcmp`). C++17's `if constexpr` evaluates a condition at compile time for template code.

## Example

```cpp
int score = 85;
std::string grade;
if (score >= 90) {
	grade = "A";
} else if (score >= 80) {
	grade = "B";
} else {
	grade = "C";
}

std::string label = (score >= 60) ? "pass" : "fail";   // ternary

// if with an initializer, scoped to the if/else
std::map<std::string, int> scores{{"Ada", 90}};
if (auto it = scores.find("Ada"); it != scores.end()) {
	int value = it->second;   // it is only in scope inside this if/else
}
```

See [`example.cpp`](./example.cpp) for the full runnable file.

## Common mistakes

1. **Comparing `std::string` with `==` and expecting C-style `strcmp` behavior confusion.** In C++, `std::string`'s `operator==` compares *contents* (what you want), unlike comparing two `char*` with `==` (which compares pointers). Mixing the two mental models causes bugs — prefer `std::string` so `==` does the intuitive thing.
2. **Forgetting `switch` still falls through** (C++ inherited this from C) — every case needs `break` unless fallthrough is intended; C++17 adds `[[fallthrough]];` to mark deliberate fallthrough and silence warnings.
3. **Not using the `if`-with-initializer form** when a variable is only needed inside the conditional — declaring it in the enclosing scope leaks it and can cause accidental reuse; the initializer form keeps it tightly scoped.
4. **Floating-point equality with `==`** — the same binary-precision issue as every language; compare with a tolerance.

## Exercise

Write `std::string grade(int score)` returning `"A"` for `score >= 90`, `"B"` for `>= 80`, `"C"` for `>= 70`, `"F"` otherwise.

Try it yourself first, then check [`solutions/exercise_1.cpp`](./solutions/exercise_1.cpp).

## Interview questions

1. **What does the `if`-with-initializer form (`if (init; condition)`) give you over declaring the variable before the `if`?** — It scopes the variable to just the `if`/`else` block, so it doesn't leak into the surrounding scope (avoiding accidental reuse and keeping the scope minimal) — especially useful for things like an iterator from `.find()` that's only relevant to that one conditional.
2. **Why does `==` on `std::string` behave differently from `==` on `char*`?** — `std::string` overloads `operator==` to compare character contents; two `char*` compared with `==` compare the pointer addresses (whether they point to the same location), not the strings' contents — a classic source of bugs when moving between C and C++ string handling.

---
← [Previous: Operators](../03_operators/README.md) | [Next: Loops →](../05_loops/README.md)
