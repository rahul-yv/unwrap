# Error Handling

Kotlin has `try`/`catch`/`finally` like Java, but all exceptions are **unchecked** — there's no `throws` declaration or compiler-enforced catching, so a function's signature doesn't tell you what it might throw. `try` is also an expression, usable as a value. For expected, recoverable failures, `Result<T>` (from the standard library) or a custom sealed class models success/failure explicitly in the return type instead of relying on exceptions for control flow.

## Example

```kotlin
fun divide(a: Int, b: Int): Int {
	if (b == 0) throw ArithmeticException("division by zero")
	return a / b
}

val result = try {
	divide(10, 0)
} catch (e: ArithmeticException) {
	-1                                    // try-as-expression: the catch branch's value
} finally {
	// always runs
}

fun safeDivide(a: Int, b: Int): Result<Int> =
	if (b == 0) Result.failure(ArithmeticException("division by zero"))
	else Result.success(a / b)

val outcome = safeDivide(10, 0)
outcome.fold(
	onSuccess = { value -> "got $value" },
	onFailure = { error -> "failed: ${error.message}" }
)
```

See [`example.kt`](./example.kt) for the full runnable file.

## Common mistakes

1. **Assuming Kotlin has checked exceptions like Java.** All exceptions are unchecked — the compiler never forces a `catch` or `throws` declaration, so a call that can throw looks identical to one that can't. Documentation (and, for expected failures, `Result<T>` or a sealed class) has to communicate what a function can fail with.
2. **Using exceptions for expected, common failure paths** (like "value not found") instead of returning `null`, a `Result`, or a sealed class representing the outcome. Exceptions are best reserved for genuinely exceptional, unexpected situations — throwing for routine "not found" cases makes normal control flow expensive and obscures the function's real contract.
3. **Swallowing an exception with an empty `catch` block.** `catch (e: Exception) {}` silently discards the failure, making bugs invisible; at minimum log it, or let it propagate if there's no meaningful recovery.
4. **Catching a broad `Exception` when only a specific exception type is actually expected**, masking unrelated bugs (a `NullPointerException` from a real programming error gets treated the same as the anticipated failure).

## Exercise

Write a function `fun safeParseInt(s: String): Result<Int>` that parses `s` as an `Int`, returning `Result.success` or `Result.failure` (catching `NumberFormatException`) instead of letting the exception propagate.

Try it yourself first, then check [`solutions/exercise_1.kt`](./solutions/exercise_1.kt).

## Interview questions

1. **Why doesn't Kotlin have checked exceptions, and what's the tradeoff?** — The language designers considered Java's checked exceptions to cause more boilerplate (try/catch or throws-propagation at every call site) than the safety they provide, especially since developers often catch-and-ignore or catch-and-wrap them anyway. The tradeoff is that a function's signature no longer documents what it can throw — that information has to come from documentation, tests, or an explicit `Result`/sealed-class return type instead.
2. **When would you use `Result<T>` instead of throwing an exception?** — For failures that are a normal, expected part of a function's contract (parsing invalid input, a lookup that might not find anything) — modeling failure as a return value forces callers to handle it explicitly via `.fold`/`.getOrElse`/`.map`, rather than it propagating silently until some (possibly distant) `try`/`catch`. Exceptions remain appropriate for truly unexpected conditions that shouldn't be part of normal control flow.

---
← [Previous: OOP](../08_oop/README.md) | [Next: Files and I/O →](../10_files/README.md)
