# Error Handling

Unlike C, C++ has exceptions: `throw` an object (conventionally derived from `std::exception`), `try`/`catch` to handle it, and stack unwinding runs destructors along the way — which is exactly why RAII matters, since it guarantees resources are released even when an exception propagates. Catch by `const&` to avoid slicing. Many modern C++ codebases also use `std::optional` (for "no value") or, in C++23, `std::expected` (for "value or error") to signal failure without exceptions in hot paths.

## Example

```cpp
#include <stdexcept>
#include <string>

class InsufficientFundsError : public std::runtime_error {
public:
	InsufficientFundsError(double balance, double amount)
		: std::runtime_error("insufficient funds"),
		  balance(balance), amount(amount) {}
	double balance;
	double amount;
};

double divide(double a, double b) {
	if (b == 0) {
		throw std::invalid_argument("division by zero");
	}
	return a / b;
}

try {
	divide(10, 0);
} catch (const std::invalid_argument& e) {   // catch by const& — no slicing
	std::string msg = e.what();
}
```

See [`example.cpp`](./example.cpp) for the full runnable file.

## Common mistakes

1. **Catching an exception by value instead of `const&`.** `catch (std::exception e)` slices the exception down to `std::exception`, losing the derived type's information (and its overridden `what()`); always `catch (const std::exception& e)`.
2. **Throwing something that isn't derived from `std::exception`.** You *can* throw any type in C++, but throwing an `int` or a raw string breaks the convention that `catch (const std::exception&)` handles everything — derive custom exceptions from `std::exception` (or `std::runtime_error`/`std::logic_error`).
3. **Leaking resources on the exception path — the reason RAII exists.** Code that acquires a resource with raw `new` (or `fopen`, or a manual lock) and releases it later leaks if an exception is thrown in between; RAII wrappers (`std::unique_ptr`, `std::lock_guard`, etc.) release in their destructor during stack unwinding, making the code exception-safe automatically.
4. **Using exceptions for ordinary, expected control flow** where `std::optional` (or `std::expected` in C++23) is clearer and cheaper — exceptions are for exceptional conditions; a lookup that routinely misses is better modeled as returning `std::optional`.

## Exercise

Write `double safe_divide(double a, double b)` that throws `std::invalid_argument` if `b == 0`, otherwise returns `a / b`. Then in `main`, call it in a `try`/`catch` demonstrating both the success and the thrown-and-caught path.

Try it yourself first, then check [`solutions/exercise_1.cpp`](./solutions/exercise_1.cpp).

## Interview questions

1. **Why is RAII essential for exception safety?** — When an exception is thrown, the stack unwinds and every local object's destructor runs; RAII ties resource release to those destructors, so resources are freed automatically no matter how the scope is exited (normal return or exception) — without it, an exception thrown between acquiring and manually releasing a resource leaks it.
2. **Why catch exceptions by `const&` rather than by value?** — Catching by value copies (and slices) the exception object to the caught type, discarding any derived-class information and overridden behavior (like a custom `what()`); catching by `const&` binds to the original thrown object, preserving its dynamic type and avoiding an unnecessary copy.

---
← [Previous: OOP](../08_oop/README.md) | [Next: Files and I/O →](../10_files/README.md)
