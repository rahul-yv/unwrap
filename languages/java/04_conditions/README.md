# Conditionals

Java has `if`/`else if`/`else`, the ternary `?:`, and `switch` — both as a classic fall-through *statement* and, since Java 14, a *switch expression* with arrow syntax (`case X ->`) that doesn't fall through and can directly produce a value.

## Example

```java
int score = 85;
String grade;
if (score >= 90) {
	grade = "A";
} else if (score >= 80) {
	grade = "B";
} else {
	grade = "C";
}

// modern switch expression with pattern guards (Java 21+): no break needed,
// no fallthrough, yields a value directly
Integer boxedScore = score; // guarded patterns need a reference type selector
String grade2 = switch (boxedScore) {
	case Integer i when i >= 90 -> "A";
	case Integer i when i >= 80 -> "B";
	default -> "C";
};
```

See [`Example.java`](./Example.java) for the full runnable file.

## Common mistakes

1. **Forgetting `break` in a classic `switch` statement**, falling through into the next case unintentionally — this is why the switch *expression* (arrow syntax) exists: it never falls through, removing the whole bug category.
2. **Using a chain of `if`/`else if` for a value that switches on `case` naturally**, missing exhaustiveness — a `switch` over an `enum`, with the compiler flagging missing cases, catches what an `if` chain silently allows to fall through to nothing.
3. **Boxed `Boolean`/`Integer` in a condition throwing `NullPointerException`** — `if (someBoxedBoolean)` unboxes automatically, but throws if the value is `null`; check for `null` explicitly first when the boxed type might not have been set.
4. **Nesting ternaries until they're unreadable.** Same guidance as other languages — one level is fine, a chain should become `if`/`else if` or a `switch` expression.

## Exercise

Write `String grade(int score)` returning `"A"` for `score >= 90`, `"B"` for `>= 80`, `"C"` for `>= 70`, `"F"` otherwise, using a `switch` expression.

Try it yourself first, then check [`solutions/Exercise1.java`](./solutions/Exercise1.java).

## Interview questions

1. **What's the difference between a `switch` statement and a `switch` expression?** — A `switch` statement executes code and can fall through between cases without `break`; a `switch` expression (arrow syntax, Java 14+) directly evaluates to a value, never falls through, and the compiler requires it to be exhaustive (a `default` or covering every `enum` value).
2. **Why does unboxing a `null` `Boolean` in an `if` condition throw?** — `if (someBoxedBoolean)` implicitly calls `.booleanValue()` to unbox it; calling any method on a `null` reference throws `NullPointerException`, and unboxing is just a method call under the hood.

---
← [Previous: Operators](../03_operators/README.md) | [Next: Loops →](../05_loops/README.md)
