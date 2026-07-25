# Testing

Real Kotlin projects typically use JUnit 5 or Kotest via Gradle, pulling in the framework as a build dependency. For a dependency-free, self-contained example matching every other topic's plain-`kotlinc` setup, this lesson uses a small hand-rolled harness — enough to show the essential shape of any test runner: run independent checks, keep going after a failure, and return a nonzero exit code if anything failed so CI can detect it.

## Example

```kotlin
class TestRunner {
	private var run = 0
	private var failed = 0

	fun check(condition: Boolean, name: String) {
		run++
		if (condition) {
			println("PASS: $name")
		} else {
			failed++
			println("FAIL: $name")
		}
	}

	fun summary(): Int {
		println("${run - failed}/$run passed")
		return if (failed == 0) 0 else 1
	}
}

fun add(a: Int, b: Int): Int = a + b

fun main() {
	val t = TestRunner()
	t.check(add(2, 3) == 5, "adds positive numbers")
	t.check(add(-2, -3) == -5, "adds negative numbers")
	kotlin.system.exitProcess(t.summary())
}
```

See [`example.kt`](./example.kt) for the full runnable file.

## Common mistakes

1. **Returning `0`/exiting normally regardless of test results.** CI decides pass/fail from the process exit code — a runner that always exits `0` reports "green" even when checks failed; use `kotlin.system.exitProcess` with a nonzero code when any check fails.
2. **Stopping at the first failure with a bare `check()`/`assert()`.** Kotlin's built-in `check`/`assert` throw immediately on failure, so you learn about exactly one failing condition per run; a real harness records each result and continues, giving a full picture of what passed and failed.
3. **Testing implementation details instead of behavior** — assert on a function's observable output for given inputs, not on internal state or call sequences a harmless refactor would change.
4. **Not testing edge cases** — empty collections, zero, negative numbers, `null`, boundary values — the same discipline as any language.

## Exercise

Using the `TestRunner` pattern, write checks that `add(0, 0) == 0` and `add(-1, 1) == 0`, exiting with the runner's summary exit code.

Try it yourself first, then check [`solutions/exercise_1.kt`](./solutions/exercise_1.kt).

## Interview questions

1. **Why does a test runner's exit code matter?** — CI systems and build tools determine whether a test step passed by checking the process's exit code; a runner that always returns success (`0`) regardless of individual test outcomes would let failing tests slip through automation undetected.
2. **What do dedicated frameworks like JUnit or Kotest add over a hand-rolled harness?** — Test discovery/registration via annotations (no manual list of checks to run), rich assertion functions with descriptive failure messages (showing actual vs expected), fixtures and setup/teardown, parameterized tests, and structured output formats for CI integration — conveniences a minimal harness omits but that matter at scale.

---
← [Previous: Modules and Packages](../11_modules_packages/README.md) | Next: Networking (coming soon)
