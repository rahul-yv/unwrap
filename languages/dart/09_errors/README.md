# Error Handling

Dart uses `try`/`catch`/`finally`/`on` — `on ExceptionType catch (e)` catches a specific type, while a bare `catch (e)` catches anything thrown (`Exception`s and `Error`s alike, plus any arbitrary object, since Dart allows `throw` on any value). Dart distinguishes `Exception` (expected, recoverable failures — application code should generally catch these) from `Error` (programming mistakes like `RangeError`/`TypeError`, generally not meant to be caught and silently handled).

## Example

```dart
class InvalidAmountException implements Exception {
	final String message;
	InvalidAmountException(this.message);
}

int divide(int a, int b) {
	if (b == 0) {
		throw ArgumentError("division by zero");
	}
	return a ~/ b;
}

int result;
try {
	result = divide(10, 0);
} on ArgumentError catch (e) {
	result = -1;
} finally {
	// always runs
}

void withdraw(double amount) {
	if (amount < 0) {
		throw InvalidAmountException("amount cannot be negative");
	}
}

try {
	withdraw(-5);
} on InvalidAmountException catch (e) {
	print(e.message);
}
```

See [`example.dart`](./example.dart) for the full runnable file.

## Common mistakes

1. **Catching a bare `catch (e)` when a specific exception type is actually expected**, masking unrelated bugs — a `TypeError` or `RangeError` from a genuine programming mistake gets silently treated the same as the anticipated failure. Use `on SpecificType catch (e)` to catch only what's actually expected.
2. **Not implementing `Exception` (or `implements Exception`) for custom exception classes**, instead throwing an arbitrary object or a bare `String`. While Dart technically allows `throw` on anything, conventionally implementing `Exception` (a marker interface) signals intent clearly and lets `on Exception catch` broadly catch application-level errors distinctly from `Error`s.
3. **Catching `Error` subtypes (`RangeError`, `TypeError`, `StateError`) as if they were routine, expected failures.** These generally represent programming bugs — catching and silently continuing can hide real problems; they're catchable mainly so a program can log/report gracefully before failing, not to paper over the underlying issue.
4. **Forgetting `finally` runs even if the `try` block returns early or an exception propagates uncaught through it** — code that must always execute (releasing a resource, closing a connection) belongs in `finally`, not duplicated at the end of both the `try` and each `catch` block.

## Exercise

Write a function `int? safeParseInt(String s)` that parses `s` as an integer, returning `null` if it isn't a valid integer string (using `int.tryParse`, which returns `null` instead of throwing).

Try it yourself first, then check [`solutions/exercise_1.dart`](./solutions/exercise_1.dart).

## Interview questions

1. **What's the difference between `Exception` and `Error` in Dart's throwable hierarchy?** — Both can be thrown and caught, but by convention `Exception` (and classes implementing it) represents application-level, often-expected failure conditions meant to be caught and handled; `Error` (and subclasses like `RangeError`, `TypeError`, `StateError`) represents programming mistakes or unrecoverable conditions, typically caught only for graceful logging/shutdown rather than routine handling.
2. **Why use `on SpecificType catch (e)` instead of a bare `catch (e)`?** — A bare `catch` matches anything thrown, regardless of type — including unrelated bugs that happen to throw during the same `try` block, silently swallowing them alongside the anticipated failure. `on SpecificType catch (e)` restricts the catch to only the type(s) actually expected, letting anything else propagate as an unhandled error that surfaces the real problem.

---
← [Previous: OOP](../08_oop/README.md) | [Next: Files and I/O →](../10_files/README.md)
