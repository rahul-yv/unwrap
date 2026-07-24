# Error Handling

Java has a distinctive split: **checked exceptions** (subclasses of `Exception` but not `RuntimeException`) must be either caught or declared in the method signature with `throws` — the compiler enforces this. **Unchecked exceptions** (`RuntimeException` and its subclasses) need no such declaration. `try`-with-resources automatically closes anything implementing `AutoCloseable`, replacing manual `finally`-based cleanup.

## Example

```java
class InsufficientFundsException extends Exception {   // checked: must be declared or caught
	InsufficientFundsException(String message) { super(message); }
}

static void withdraw(double balance, double amount) throws InsufficientFundsException {
	if (amount > balance) {
		throw new InsufficientFundsException("insufficient funds");
	}
}

try {
	withdraw(10, 50);
} catch (InsufficientFundsException e) {
	System.out.println(e.getMessage());
} finally {
	System.out.println("always runs");
}

try (var resource = new SomeAutoCloseable()) {
	// resource.close() is called automatically, even if an exception is thrown
}
```

See [`Example.java`](./Example.java) for the full runnable file.

## Common mistakes

1. **Catching `Exception` broadly** to sidestep declaring specific checked exceptions — hides which failures are actually possible and can accidentally swallow bugs that should have propagated.
2. **"Swallowing" a checked exception with an empty catch block** just to satisfy the compiler, instead of actually handling it or wrapping it in an unchecked exception and rethrowing — silently discards real failure information.
3. **Forgetting `finally` runs even when the `try` block returns**, and that a `return` inside `finally` silently overrides a `return` from `try` — almost always an unintentional bug when it happens.
4. **Manually closing resources in a `finally` block** instead of try-with-resources — more verbose and easy to get wrong (e.g. forgetting a `null` check on the resource if it failed to open); try-with-resources handles this correctly by construction.

## Exercise

Write `double safeDivide(double a, double b)` returning `a / b`, or `Double.NaN` if `b == 0` — catching an `ArithmeticException` you deliberately throw for the zero case (practice the pattern, even though floating-point division by zero doesn't actually throw in Java — it produces infinity).

Try it yourself first, then check [`solutions/Exercise1.java`](./solutions/Exercise1.java).

## Interview questions

1. **What's the difference between a checked and an unchecked exception?** — Checked exceptions (extending `Exception`, not `RuntimeException`) must be declared with `throws` or caught — the compiler enforces this; unchecked exceptions (extending `RuntimeException`) need no declaration and typically represent programming errors rather than expected, recoverable conditions.
2. **What does try-with-resources guarantee, and what must a resource implement to use it?** — The resource's `.close()` is called automatically when the `try` block exits, whether normally or via an exception — the resource type must implement `AutoCloseable` (or the more specific `Closeable`).

---
← [Previous: OOP](../08_oop/README.md) | [Next: Files and I/O →](../10_files/README.md)
