# Functions

C++ functions add a lot over C: default parameters, function overloading (same name, different parameter types), pass-by-reference (`int&` — a true reference, no pointer syntax needed), templates (generic functions), and lambdas (`[](int x) { return x + 1; }`, with a capture list that makes closures possible). `std::function` holds any callable (function, lambda, functor) as a value.

## Example

```cpp
int add(int a, int b) { return a + b; }
double add(double a, double b) { return a + b; }   // overload: same name, different types

std::string greet(const std::string& name, const std::string& greeting = "Hello") {
	return greeting + ", " + name + "!";             // default parameter
}

void increment(int& x) { x++; }                       // pass by reference — modifies the caller's variable

template <typename T>
T max_of(T a, T b) { return a > b ? a : b; }           // generic function

auto make_adder = [](int n) {
	return [n](int x) { return x + n; };                // lambda capturing n by value
};
```

See [`example.cpp`](./example.cpp) for the full runnable file.

## Common mistakes

1. **Passing a large object by value when a `const&` would avoid the copy.** `void process(std::vector<int> v)` copies the whole vector on every call; `void process(const std::vector<int>& v)` passes a reference — the default choice for read-only parameters of non-trivial types.
2. **Capturing a local by reference in a lambda that outlives the enclosing scope.** `[&]` captures by reference; if the lambda is stored and called after the captured variable is destroyed, that's a dangling reference (undefined behavior). Capture by value (`[=]` or naming the variable) when the lambda may outlive the scope.
3. **Ambiguous overloads.** Two overloads that a given call matches equally well cause a compile error; and implicit conversions can make an overload match unexpectedly. Keep overload sets small and their parameter types distinct.
4. **Forgetting a reference parameter (`int&`) modifies the caller's variable.** Unlike a value parameter, changes through a reference are visible to the caller — intended for "output parameters," but surprising if you expected a copy.

## Exercise

Write a function `std::function<int()> make_counter()` returning a callable; each call to the returned callable returns an incrementing count starting at 1 (use a lambda capturing a counter by value with the `mutable` keyword, or by capturing a shared state).

Try it yourself first, then check [`solutions/exercise_1.cpp`](./solutions/exercise_1.cpp).

## Interview questions

1. **What's the difference between capturing by value (`[=]` / `[x]`) and by reference (`[&]` / `[&x]`) in a lambda?** — By value copies the captured variable into the lambda (independent of the original, safe to use after the original is gone); by reference binds to the original variable (sees later changes, but becomes a dangling reference if the lambda outlives that variable's scope).
2. **When should a function parameter be `const T&` instead of `T`?** — When the function only reads the argument and the type is non-trivial to copy (strings, vectors, large structs) — `const T&` passes a reference (no copy, and `const` promises not to modify it), while `T` by value would copy. For small, cheap types (`int`, `double`), by value is fine and sometimes preferred.

---
← [Previous: Loops](../05_loops/README.md) | Next: Collections (coming soon)
