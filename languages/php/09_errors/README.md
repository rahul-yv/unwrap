# Error Handling

PHP uses `try`/`catch`/`finally` with a class-based exception hierarchy — all exceptions implement `Throwable`, split into `Exception` (application-level errors, meant to be caught) and `Error` (internal engine errors like `TypeError`/`DivisionByZeroError`, generally not meant to be routinely caught). Multiple `catch` blocks can handle different exception types, and a single `catch` can list several types with `|`.

## Example

```php
<?php
function divide(int $a, int $b): int {
	if ($b === 0) {
		throw new DivisionByZeroError("division by zero");
	}
	return intdiv($a, $b);
}

try {
	$result = divide(10, 0);
} catch (DivisionByZeroError $e) {
	$result = -1;
} finally {
	// always runs
}

class InvalidAmountException extends Exception {}

function withdraw(float $amount): void {
	if ($amount < 0) {
		throw new InvalidAmountException("amount cannot be negative");
	}
}

try {
	withdraw(-5);
} catch (InvalidAmountException | TypeError $e) {
	// handles either exception type
}
```

See [`example.php`](./example.php) for the full runnable file.

## Common mistakes

1. **Catching the broad `Exception` (or worse, `Throwable`) when only a specific exception type is actually expected**, masking unrelated bugs — a `TypeError` from a genuine programming mistake gets silently treated the same as the anticipated failure.
2. **Not defining custom exception subclasses for distinct failure categories**, instead throwing a generic `Exception` with only a message string — callers can't `catch` selectively by type and have to parse the message text to distinguish failure cases, which is fragile.
3. **Catching `Error` types (like `TypeError`, `DivisionByZeroError`) as if they were expected, routine failures.** These generally represent programming bugs or genuinely exceptional conditions — catching and silently continuing can hide real problems; they're catchable mainly so an application can log/report gracefully before failing, not to paper over the underlying issue.
4. **Forgetting `finally` runs even if the `try` block returns early or an uncaught exception propagates through it** — code that must always execute (releasing a resource, closing a connection) belongs in `finally`, not duplicated at the end of both the `try` and each `catch` block.

## Exercise

Write a function `function safeParseInt(string $s): int|false` that parses `$s` as an integer, returning `false` if it isn't numeric (using `is_numeric()` to check rather than `try`/`catch`, since PHP's int casting doesn't throw).

Try it yourself first, then check [`solutions/exercise_1.php`](./solutions/exercise_1.php).

## Interview questions

1. **What's the difference between `Exception` and `Error` in PHP's throwable hierarchy?** — Both implement `Throwable` and are catchable, but `Exception` (and its subclasses) represents application-level, often-expected failure conditions meant to be caught and handled; `Error` (and subclasses like `TypeError`, `DivisionByZeroError`, `ArgumentCountError`) represents internal engine-level problems, typically programming mistakes, that are catchable mainly for graceful logging/shutdown rather than routine handling.
2. **Why define custom exception classes instead of throwing a generic `Exception` with a descriptive message?** — A custom subclass (`class InvalidAmountException extends Exception {}`) lets callers `catch` selectively by type (`catch (InvalidAmountException $e)`), enabling different handling for different failure categories. A generic `Exception` forces callers to either catch everything indiscriminately or inspect the message string to figure out what actually went wrong — fragile and easy to break if the message text changes.

---
← [Previous: OOP](../08_oop/README.md) | [Next: Files and I/O →](../10_files/README.md)
