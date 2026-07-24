# Operators

Java's operators are mostly C-family familiar (`+ - * / % == != && || !`), plus the ternary `?:`, and the `instanceof` pattern-matching form (since Java 16) that combines a type check with a cast in one expression. There's no operator overloading in Java (except `+` for `String` concatenation, built into the language, not user-definable).

## Example

```java
int q = 7 / 2;      // 3 — integer division truncates toward zero
int r = 7 % 2;       // 1
double half = 7.0 / 2;  // 3.5 — at least one operand must be floating-point

String label = q > 0 ? "pass" : "fail";   // ternary

Object value = "hello";
if (value instanceof String s) {           // pattern matching: type-checks AND casts to `s`
    System.out.println(s.length());
}
```

See [`Example.java`](./Example.java) for the full runnable file.

## Common mistakes

1. **Expecting `/` between two `int`s to produce a fractional result.** `7 / 2` is `3` (integer division); at least one operand needs to be `double`/`float` for `3.5`.
2. **Using the classic `instanceof` + explicit cast** (`if (value instanceof String) { String s = (String) value; ... }`) when pattern matching (`if (value instanceof String s)`) does both in one step and is the modern idiom since Java 16.
3. **Chaining `&&`/`||` without understanding short-circuit evaluation**, then relying on a side effect in the second operand that doesn't run because the first operand already determined the result — `a() || b()` skips calling `b()` entirely if `a()` is `true`.
4. **Trying to overload `+` (or any operator) for a custom class.** Java doesn't support operator overloading (`String`'s `+` is a special compiler case, not something user classes can replicate) — use a named method (`add(...)`) instead.

## Exercise

Write `int clamp(int value, int low, int high)` restricting `value` to `[low, high]`, using `Math.max`/`Math.min`.

Try it yourself first, then check [`solutions/Exercise1.java`](./solutions/Exercise1.java).

## Interview questions

1. **What does pattern-matching `instanceof` (`if (value instanceof String s)`) save you from writing?** — A separate explicit cast statement after the type check; the checked-and-cast variable (`s`) is available directly inside the `if` block once the type check succeeds.
2. **Can Java classes overload operators like `+`?** — No — Java deliberately omits general operator overloading (unlike C++/Kotlin); `String`'s `+` for concatenation is a special case built into the compiler, not something available to user-defined types.

---
← [Previous: Data Types](../02_datatypes/README.md) | [Next: Conditionals →](../04_conditions/README.md)
