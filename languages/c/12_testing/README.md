# Testing

C has no built-in test framework. `assert()` (from `<assert.h>`) is the basic building block — it aborts the program immediately on failure, which is fine for "this must never happen" checks but gives poor feedback for a *test suite* (one failure stops everything, with no report of what else passed or failed). Real C projects typically add a small testing library (Unity, CMocka, Check) or, for something lightweight, a hand-rolled macro-based harness that keeps running after a failure and reports a summary — which is what this lesson builds.

## Example

```c
// a minimal hand-rolled test harness
#include <stdio.h>

static int tests_run = 0;
static int tests_failed = 0;

#define TEST_EQ(actual, expected, name)                              \
	do {                                                              \
		tests_run++;                                                  \
		if ((actual) != (expected)) {                                 \
			tests_failed++;                                           \
			printf("FAIL: %s\n", name);                               \
		} else {                                                      \
			printf("PASS: %s\n", name);                               \
		}                                                              \
	} while (0)

int add(int a, int b) { return a + b; }

int main(void) {
	TEST_EQ(add(2, 3), 5, "adds positive numbers");
	TEST_EQ(add(-2, -3), -5, "adds negative numbers");

	printf("%d/%d tests passed\n", tests_run - tests_failed, tests_run);
	return tests_failed == 0 ? 0 : 1;   // nonzero exit code signals CI failure
}
```

See [`example.c`](./example.c) for the full runnable file.

## Common mistakes

1. **Relying only on `assert()` for a whole test suite.** The first failed `assert` aborts the entire program — you learn about exactly one failure per run, not the full picture; a proper harness (like `TEST_EQ` above) keeps going and reports every failure.
2. **Not returning a nonzero exit code when tests fail.** CI systems (and shell scripting generally) check a process's exit code to decide pass/fail — a test runner that always exits `0` regardless of results silently "passes" broken code in automation.
3. **Writing test macros without wrapping the body in `do { ... } while (0)`.** Without it, a multi-statement macro can silently misbehave when used inside an `if`/`else` without braces — the `do...while(0)` wrapper makes the macro behave like a single statement syntactically.
4. **Testing only the happy path.** Same as any language — empty input, zero, negative numbers, boundary values are where real bugs hide.

## Exercise

Using the `TEST_EQ` macro pattern, write tests checking `add(0, 0) == 0` and `add(-1, 1) == 0`.

Try it yourself first, then check [`solutions/exercise_1.c`](./solutions/exercise_1.c).

## Interview questions

1. **Why does a test runner's exit code matter for CI?** — Automation (CI pipelines, shell scripts, `make check`) typically checks the exit code to decide whether a step succeeded; a test binary that always returns `0` regardless of failures would make a CI pipeline report green even when tests actually failed.
2. **Why is `assert()` alone insufficient as a full test framework?** — It aborts on the first failure, giving no visibility into whether other, unrelated checks would have passed or failed — a real test suite needs to isolate each check and report a complete summary, not stop at the first problem.

---
← [Previous: Modules and Packages](../11_modules_packages/README.md) | [Next: Networking →](../13_networking/README.md)
