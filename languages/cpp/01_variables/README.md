# Variables

C++ builds on C's variables but adds `auto` type inference (since C++11), stricter `const`, `constexpr` (values computed at compile time), and — crucially — object lifetime with constructors and destructors. The defining C++ idea introduced here is RAII (Resource Acquisition Is Initialization): an object acquires a resource in its constructor and releases it in its destructor, which runs automatically when the object goes out of scope. This is how modern C++ manages memory and resources safely without a garbage collector.

## Example

```cpp
int age = 25;
auto name = std::string("Ada");   // auto infers std::string
age = age + 1;

const int max_retries = 3;         // runtime const
constexpr int buffer_size = 1024;   // compile-time constant

// RAII: the std::string manages its own heap buffer, freed automatically
{
	std::string owned = "hello";     // allocates
}                                     // destructor runs here, frees the buffer — no manual free
```

See [`example.cpp`](./example.cpp) for the full runnable file.

## Common mistakes

1. **Overusing `auto` where it hides an important type.** `auto` is great for verbose types (iterators, lambdas) but can obscure meaning — `auto x = foo();` gives no hint what `x` is; use it where the type is obvious or unwieldy, not to avoid thinking about types.
2. **Forgetting that a copy is a copy in C++.** `std::string b = a;` copies the entire string (unlike reference-semantics languages where it aliases). This is often what you want (value semantics), but copying large objects unnecessarily is a common performance mistake — pass by `const&` to avoid it.
3. **Confusing `const` with `constexpr`.** `const` means "won't change after initialization" (can be a runtime value); `constexpr` means "computable at compile time" (stronger, enables use in contexts requiring compile-time constants like array sizes).
4. **Manual `new`/`delete` in modern C++.** Raw `new`/`delete` is error-prone (leaks, double-frees) — modern C++ uses RAII types (`std::string`, `std::vector`) and smart pointers (`std::unique_ptr`, covered in `07_collections`/`08_oop`) so cleanup is automatic; reaching for raw `new` is usually a code smell.

## Exercise

Write a function `std::pair<int, int> swap_pair(int a, int b)` that returns `{b, a}` (using `std::pair` and brace initialization).

Try it yourself first, then check [`solutions/exercise_1.cpp`](./solutions/exercise_1.cpp).

## Interview questions

1. **What is RAII, and why is it central to modern C++?** — Resource Acquisition Is Initialization: a resource (memory, file handle, lock) is tied to an object's lifetime — acquired in its constructor, released in its destructor, which runs deterministically when the object goes out of scope. It's how C++ guarantees cleanup without a garbage collector, and underlies `std::string`, `std::vector`, smart pointers, and lock guards.
2. **What's the difference between `const` and `constexpr`?** — `const` promises a value won't be modified after initialization but allows it to be computed at runtime; `constexpr` requires the value to be computable at compile time, allowing its use where a compile-time constant is mandatory (array bounds, template arguments, `switch` cases).

---
← Previous: (start) | [Next: Data Types →](../02_datatypes/README.md)
