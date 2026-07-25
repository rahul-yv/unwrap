# Testing

C++ has no built-in test framework in its standard library. Real projects use a testing library — GoogleTest, Catch2, and doctest are the popular choices, typically added via a package manager or a single bundled header. For a dependency-free, self-contained example, this lesson uses a small hand-rolled harness (a helper that records pass/fail per check and reports a summary), which is enough to show the essential shape of any test runner: run independent checks, keep going after a failure, and return a nonzero exit code if anything failed so CI can detect it.

## Example

```cpp
#include <iostream>
#include <string>

struct TestRunner {
	int run = 0;
	int failed = 0;

	void check(bool condition, const std::string& name) {
		run++;
		if (condition) {
			std::cout << "PASS: " << name << "\n";
		} else {
			failed++;
			std::cout << "FAIL: " << name << "\n";
		}
	}

	int summary() const {
		std::cout << (run - failed) << "/" << run << " passed\n";
		return failed == 0 ? 0 : 1;   // nonzero exit signals CI failure
	}
};

int add(int a, int b) { return a + b; }

int main() {
	TestRunner t;
	t.check(add(2, 3) == 5, "adds positive numbers");
	t.check(add(-2, -3) == -5, "adds negative numbers");
	return t.summary();
}
```

See [`example.cpp`](./example.cpp) for the full runnable file.

## Common mistakes

1. **Returning `0` from a test program regardless of results.** CI decides pass/fail from the process exit code — a test runner that always exits `0` reports "green" even when assertions failed; return nonzero when any check fails.
2. **Stopping at the first failure (e.g. with a bare `assert`).** `assert` aborts immediately, so you learn about exactly one failure per run; a real harness records each result and continues, giving a full picture of what passed and failed.
3. **Testing implementation details instead of behavior** — assert on the function's observable output for given inputs, not on internal state or call sequences that a harmless refactor would change.
4. **Not testing edge cases** — empty containers, zero, negative numbers, boundary values — the same discipline as any language.

## Exercise

Using the `TestRunner` pattern, write checks that `add(0, 0) == 0` and `add(-1, 1) == 0`, returning the runner's summary exit code from `main`.

Try it yourself first, then check [`solutions/exercise_1.cpp`](./solutions/exercise_1.cpp).

## Interview questions

1. **Why does a test runner's exit code matter?** — CI systems and build tools determine whether a test step passed by checking the process's exit code; a runner that always returns success (`0`) regardless of individual test outcomes would let failing tests slip through automation undetected.
2. **What do dedicated frameworks like GoogleTest or Catch2 add over a hand-rolled harness?** — Test discovery/registration (no manual list), rich assertion macros with descriptive failure messages (showing actual vs expected), fixtures and setup/teardown, parameterized tests, test filtering, and structured output formats for CI integration — conveniences a minimal harness omits but that matter at scale.

---
← [Previous: Modules and Packages](../11_modules_packages/README.md) | [Next: Networking →](../13_networking/README.md)
