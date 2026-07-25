# Testing

PHPUnit is the standard testing framework for real PHP projects, installed via Composer. For a dependency-free example matching every other topic's plain-`php` setup, this lesson uses a small hand-rolled harness — enough to show the essential shape of any test runner: run independent checks, keep going after a failure, and exit with a nonzero code if anything failed so CI can detect it.

## Example

```php
<?php
class TestRunner {
	private int $run = 0;
	private int $failed = 0;

	public function check(bool $condition, string $name): void {
		$this->run++;
		if ($condition) {
			echo "PASS: $name\n";
		} else {
			$this->failed++;
			echo "FAIL: $name\n";
		}
	}

	public function summary(): int {
		$passed = $this->run - $this->failed;
		echo "$passed/{$this->run} passed\n";
		return $this->failed === 0 ? 0 : 1;
	}
}

function add(int $a, int $b): int {
	return $a + $b;
}

$t = new TestRunner();
$t->check(add(2, 3) === 5, "adds positive numbers");
$t->check(add(-2, -3) === -5, "adds negative numbers");
exit($t->summary());
```

See [`example.php`](./example.php) for the full runnable file.

## Common mistakes

1. **Exiting with `0` (or not calling `exit()` with a code at all) regardless of test results.** CI decides pass/fail from the process exit code — a script that always exits `0` reports "green" even when checks failed; call `exit()` with a nonzero code when any check fails.
2. **Stopping at the first failure with a bare `assert()`.** By default (in typical configurations) a failed `assert()` throws an `AssertionError`, ending the script immediately — so you learn about exactly one failing condition per run; a real harness records each result and continues, giving a full picture of what passed and failed.
3. **Testing implementation details instead of behavior** — assert on a function's observable output for given inputs, not on internal state or call sequences a harmless refactor would change.
4. **Not testing edge cases** — empty arrays, zero, negative numbers, `null`, boundary values — the same discipline as any language.

## Exercise

Using the `TestRunner` pattern, write checks that `add(0, 0) === 0` and `add(-1, 1) === 0`, exiting with the runner's summary exit code.

Try it yourself first, then check [`solutions/exercise_1.php`](./solutions/exercise_1.php).

## Interview questions

1. **Why does a test runner's exit code matter?** — CI systems and build tools determine whether a test step passed by checking the process's exit code; a script that always returns success (`0`) regardless of individual test outcomes would let failing tests slip through automation undetected.
2. **What does PHPUnit add over a hand-rolled harness?** — Test discovery via naming conventions/annotations (no manual list of checks to run), rich assertion methods with descriptive failure messages (showing actual vs expected), fixtures and setup/teardown, data providers for parameterized tests, mocking support, and structured output formats for CI integration — conveniences a minimal harness omits but that matter at scale.

---
← [Previous: Modules and Packages](../11_modules_packages/README.md) | Next: Networking (coming soon)
