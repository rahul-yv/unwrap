# Testing

Real Swift projects use XCTest (or the newer Swift Testing framework), typically via Swift Package Manager or Xcode. For a dependency-free, self-contained example matching every other topic's plain-`swift` setup, this lesson uses a small hand-rolled harness — enough to show the essential shape of any test runner: run independent checks, keep going after a failure, and return a nonzero exit code if anything failed so CI can detect it.

## Example

```swift
final class TestRunner {
	private var run = 0
	private var failed = 0

	func check(_ condition: Bool, _ name: String) {
		run += 1
		if condition {
			print("PASS: \(name)")
		} else {
			failed += 1
			print("FAIL: \(name)")
		}
	}

	func summary() -> Int32 {
		print("\(run - failed)/\(run) passed")
		return failed == 0 ? 0 : 1
	}
}

func add(_ a: Int, _ b: Int) -> Int { a + b }

let t = TestRunner()
t.check(add(2, 3) == 5, "adds positive numbers")
t.check(add(-2, -3) == -5, "adds negative numbers")
exit(t.summary())
```

See [`example.swift`](./example.swift) for the full runnable file.

## Common mistakes

1. **Returning/exiting normally regardless of test results.** CI decides pass/fail from the process exit code — a runner that always exits `0` reports "green" even when checks failed; call `exit()` with a nonzero code when any check fails.
2. **Stopping at the first failure with a bare `assert()`.** Swift's `assert` traps immediately on failure, so you learn about exactly one failing condition per run; a real harness records each result and continues, giving a full picture of what passed and failed.
3. **Testing implementation details instead of behavior** — assert on a function's observable output for given inputs, not on internal state or call sequences a harmless refactor would change.
4. **Not testing edge cases** — empty collections, zero, negative numbers, `nil`, boundary values — the same discipline as any language.

## Exercise

Using the `TestRunner` pattern, write checks that `add(0, 0) == 0` and `add(-1, 1) == 0`, exiting with the runner's summary exit code.

Try it yourself first, then check [`solutions/exercise_1.swift`](./solutions/exercise_1.swift).

## Interview questions

1. **Why does a test runner's exit code matter?** — CI systems and build tools determine whether a test step passed by checking the process's exit code; a runner that always returns success (`0`) regardless of individual test outcomes would let failing tests slip through automation undetected.
2. **What do dedicated frameworks like XCTest or Swift Testing add over a hand-rolled harness?** — Test discovery via naming conventions or macros/attributes (no manual list of checks to run), rich assertion functions with descriptive failure messages (showing actual vs expected, source location), fixtures and setup/teardown, parameterized tests, and structured output formats for CI/Xcode integration — conveniences a minimal harness omits but that matter at scale.

---
← [Previous: Modules and Packages](../11_modules_packages/README.md) | Next: Networking (coming soon)
