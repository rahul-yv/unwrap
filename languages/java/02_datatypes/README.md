# Data Types

Java has eight primitive types: `byte`, `short`, `int`, `long`, `float`, `double`, `char`, `boolean` — fixed-size, not objects, can't be `null`. Everything else is a reference type (classes, arrays, `String`). `String` is immutable: every "modifying" method returns a new `String` rather than changing the original.

## Example

```java
int n = 10;
long big = 10_000_000_000L;   // L suffix required for long literals beyond int range
double pi = 3.14159;
char c = 'A';
boolean ok = true;

String s = "hello";
String upper = s.toUpperCase();   // returns a new String; s itself is unchanged

System.out.println(s == "hello");           // true: string literals are interned/pooled
System.out.println(new String("hello") == "hello");  // false: a new object, different reference
```

See [`Example.java`](./Example.java) for the full runnable file.

## Common mistakes

1. **Comparing `String`s with `==` instead of `.equals()`.** `==` compares references, not content; two strings with identical content are only guaranteed `==` if both are compile-time literals (interned in the string pool) — a string built at runtime (`new String(...)`, concatenation of variables, `.substring()`, etc.) is a distinct object even with equal content.
2. **Forgetting the `L` suffix on a `long` literal that exceeds `int`'s range.** `long big = 10000000000;` is a compile error — the literal itself is parsed as `int` first and overflows; `10000000000L` fixes it.
3. **Losing precision silently with a narrowing cast.** `int x = (int) 3.99;` truncates to `3` with no warning or error — casting between numeric types is a deliberate "trust me" that can silently drop data.
4. **Assuming `float`/`double` equality with `==` is exact**, same underlying binary floating-point issue as every language — `0.1 + 0.2 == 0.3` is `false` in Java too.

## Exercise

Write `boolean sameContent(String a, String b)` comparing two strings by content, correctly using `.equals()` (and handling `null` safely — return `false` if either is `null`, without throwing `NullPointerException`).

Try it yourself first, then check [`solutions/Exercise1.java`](./solutions/Exercise1.java).

## Interview questions

1. **Why can two equal-content strings fail a `==` comparison?** — `==` on reference types compares object identity, not content; only strings guaranteed to share the same pooled/interned object (typically compile-time literals) are `==`-equal — a string constructed at runtime is a separate object even with identical characters.
2. **Why is `String` immutable in Java, and what's the performance implication of building a string with repeated `+` in a loop?** — Immutability makes strings safe to share (e.g. as `HashMap` keys, across threads) without defensive copying; repeated `+` concatenation in a loop creates a new `String` object each time (O(n²) overall) — use `StringBuilder` for building a string incrementally.

---
← [Previous: Variables](../01_variables/README.md) | [Next: Operators →](../03_operators/README.md)
