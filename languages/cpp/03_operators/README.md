# Operators

C++ has all of C's operators, plus the defining C++ feature: **operator overloading** — you can define what `+`, `==`, `<`, `[]`, etc. mean for your own types. This is what lets `std::string` support `+` for concatenation and `std::vector` support `[]` for indexing. Used well it makes custom types feel built-in; overused (or used for non-obvious meanings) it obscures code.

## Example

```cpp
struct Vec2 {
	double x, y;

	Vec2 operator+(const Vec2& other) const {   // overload + for Vec2
		return {x + other.x, y + other.y};
	}

	bool operator==(const Vec2& other) const {   // overload ==
		return x == other.x && y == other.y;
	}
};

Vec2 a{1, 2};
Vec2 b{3, 4};
Vec2 sum = a + b;        // {4, 6} — calls operator+
bool same = (a == b);     // false — calls operator==
```

See [`example.cpp`](./example.cpp) for the full runnable file.

## Common mistakes

1. **Overloading an operator with a surprising meaning.** `+` should mean something addition-like; overloading it to do something unrelated (e.g. logging, or appending to a database) makes code deeply confusing. Operator overloading is for types where the operator has an intuitive, mathematical-or-container-like meaning.
2. **Forgetting to mark a comparison/arithmetic operator `const`.** An `operator==` that doesn't modify its operands should be `const` (as a member) so it works on `const` objects and expresses intent — omitting it causes confusing "no matching operator" errors when comparing const values.
3. **Overloading `==` but not the other comparisons (or vice versa)** and then being surprised that `!=`, `<`, `>` don't work. (C++20's `operator<=>`, the "spaceship operator," can generate the full set from one definition — but pre-C++20 you define each, or at least `==` and `<`.)
4. **Returning a reference to a local in an overloaded operator** — same dangling-reference danger as any function; arithmetic operators like `+` return a new value (by value), not a reference to a temporary.

## Exercise

Define a `struct Fraction { int num; int den; };` and overload `operator==` to compare two fractions by cross-multiplication (`a.num * b.den == b.num * a.den`), so `1/2 == 2/4` is `true`.

Try it yourself first, then check [`solutions/exercise_1.cpp`](./solutions/exercise_1.cpp).

## Interview questions

1. **What is operator overloading, and when is it appropriate to use?** — Defining custom behavior for built-in operators (`+`, `==`, `[]`, etc.) on user-defined types. It's appropriate when the operator has a natural, intuitive meaning for the type (arithmetic on a math vector, `[]` on a container, `==` on a value type) — and inappropriate when it would surprise a reader, since it hides a function call behind familiar syntax.
2. **Why should a member `operator==` typically be marked `const`?** — Because comparing two objects shouldn't modify either — marking it `const` lets it be called on `const` objects and const references (the common case), and documents that the comparison has no side effects.

---
← [Previous: Data Types](../02_datatypes/README.md) | [Next: Conditionals →](../04_conditions/README.md)
