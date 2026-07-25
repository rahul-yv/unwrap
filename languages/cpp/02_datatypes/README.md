# Data Types

C++ has C's fundamental types plus a much richer standard library of types: `std::string` (owning, growable text, not a raw `char*`), `std::vector<T>` (dynamic array), `std::optional<T>` (a value that may or may not be present — a type-safe alternative to sentinel values or null pointers), `std::variant` (a type-safe union), and `std::pair`/`std::tuple`. Fixed-width integers come from `<cstdint>` (`int32_t`, `uint64_t`) just as in C.

## Example

```cpp
#include <optional>
#include <string>

std::string name = "Ada";        // owns its buffer
int32_t exact = 10;               // fixed width, from <cstdint>

std::optional<int> maybe = 42;    // holds a value
std::optional<int> nothing;        // holds nothing (std::nullopt)

if (maybe.has_value()) {
	int x = maybe.value();          // or *maybe
}

int fallback = nothing.value_or(0);   // 0, since nothing is empty
```

See [`example.cpp`](./example.cpp) for the full runnable file.

## Common mistakes

1. **Using a sentinel value (like `-1`) or a null pointer to mean "no result" when `std::optional<T>` says it directly.** `std::optional` makes "might be absent" part of the type, forcing the caller to check — safer and clearer than reserving a magic value that could collide with a real result.
2. **Calling `.value()` on an empty `std::optional`.** It throws `std::bad_optional_access`; use `.has_value()` / `if (opt)` to check first, or `.value_or(default)` to supply a fallback — same discipline as unwrapping an `Option`/`Result` in other languages.
3. **Mixing C strings (`char*`) and `std::string` carelessly.** `std::string` owns and manages its memory; a `char*` is a raw pointer with none of that safety. Prefer `std::string` (and `std::string_view` for non-owning read-only views) throughout modern C++ code, converting to `char*` (via `.c_str()`) only at C-API boundaries.
4. **Assuming `auto` deduces a reference or `const`.** `auto x = someVector[0];` copies the element; use `auto&` (reference) or `const auto&` to avoid a copy or to modify in place — a subtle but common performance and correctness gotcha.

## Exercise

Write `std::optional<int> safe_divide(int a, int b)` returning the quotient, or `std::nullopt` if `b == 0`.

Try it yourself first, then check [`solutions/exercise_1.cpp`](./solutions/exercise_1.cpp).

## Interview questions

1. **What problem does `std::optional<T>` solve, compared to returning a sentinel value or a null pointer?** — It encodes "a value may be absent" directly in the type, so the compiler and reader both see it, and the caller must explicitly handle the empty case — eliminating the ambiguity of a magic sentinel (which might collide with a valid value) and the unsafety of a raw null pointer.
2. **Why prefer `std::string` over `char*` in modern C++?** — `std::string` owns and automatically manages its memory (RAII — grows, copies, and frees safely), whereas a `char*` is a raw pointer requiring manual lifetime management and prone to buffer overflows, leaks, and dangling references.

---
← [Previous: Variables](../01_variables/README.md) | [Next: Operators →](../03_operators/README.md)
