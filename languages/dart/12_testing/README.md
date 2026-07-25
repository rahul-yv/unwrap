# Testing

Real Dart/Flutter projects use the `test` package (or `flutter_test` for widget tests), installed via `pubspec.yaml` and run with `dart test`/`flutter test`. For a dependency-free example matching every other topic's plain-`dart run` setup, this lesson uses a small hand-rolled harness — enough to show the essential shape of any test runner: run independent checks, keep going after a failure, and exit with a nonzero code if anything failed so CI can detect it.

## Example

```dart
import "dart:io";

class TestRunner {
	int run = 0;
	int failed = 0;

	void check(bool condition, String name) {
		run++;
		if (condition) {
			print("PASS: $name");
		} else {
			failed++;
			print("FAIL: $name");
		}
	}

	int summary() {
		print("${run - failed}/$run passed");
		return failed == 0 ? 0 : 1;
	}
}

int add(int a, int b) => a + b;

void main() {
	final t = TestRunner();
	t.check(add(2, 3) == 5, "adds positive numbers");
	t.check(add(-2, -3) == -5, "adds negative numbers");
	exit(t.summary());
}
```

See [`example.dart`](./example.dart) for the full runnable file.

## Common mistakes

1. **Exiting with `0` (or not calling `exit()` with a code at all) regardless of test results.** CI decides pass/fail from the process exit code — a script that always exits `0` reports "green" even when checks failed; call `exit(code)` from `dart:io` with a nonzero code when any check fails.
2. **Stopping at the first failure with a bare `assert()`.** A failed `assert` throws immediately (when assertions are enabled), so you learn about exactly one failing condition per run; a real harness records each result and continues, giving a full picture of what passed and failed.
3. **Testing implementation details instead of behavior** — assert on a function's observable output for given inputs, not on internal state or call sequences a harmless refactor would change.
4. **Not testing edge cases** — empty collections, zero, negative numbers, `null`, boundary values — the same discipline as any language.

## Exercise

Using the `TestRunner` pattern, write checks that `add(0, 0) == 0` and `add(-1, 1) == 0`, exiting with the runner's summary exit code.

Try it yourself first, then check [`solutions/exercise_1.dart`](./solutions/exercise_1.dart).

## Interview questions

1. **Why does a test runner's exit code matter?** — CI systems and build tools determine whether a test step passed by checking the process's exit code; a script that always returns success (`0`) regardless of individual test outcomes would let failing tests slip through automation undetected.
2. **What does the `test` package add over a hand-rolled harness?** — Test discovery via file naming conventions (`_test.dart` suffix, no manual list of checks to run), rich `expect()` matchers with descriptive failure messages (showing actual vs expected), `setUp`/`tearDown` fixtures, grouping and filtering tests, and structured output formats for CI integration — conveniences a minimal harness omits but that matter at scale.

---
← [Previous: Modules and Packages](../11_modules_packages/README.md) | [Next: Networking →](../13_networking/README.md)
