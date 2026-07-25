# Conditionals

Dart has `if`/`else if`/`else`, and — since Dart 3.0 — `switch` **expressions** (in addition to the older `switch` statement), which support pattern matching on values, types, and destructured records/objects, and require exhaustiveness when used as an expression. The conditional (ternary) operator `cond ? a : b` covers simple two-branch value selection inline.

## Example

```dart
int age = 20;
String category = age < 13 ? "child" : (age < 20 ? "teen" : "adult");

int x = 5;
String description = switch (x) {
	< 0 => "negative",
	0 => "zero",
	int n when n.isEven => "positive even",
	_ => "positive odd",
};

String describe(Object? value) => switch (value) {
	int i => "an int: $i",
	String s => "a String of length ${s.length}",
	null => "null",
	_ => "something else",
};
```

See [`example.dart`](./example.dart) for the full runnable file.

## Common mistakes

1. **Forgetting a `switch` expression must be exhaustive.** Every possible input must be covered by some pattern (or a `_` wildcard as a catch-all) — the compiler rejects a `switch` expression with a gap, unlike the older `switch` statement, which silently does nothing if no case matches and no `default` exists.
2. **Using the old `switch` statement's `case`/`break` syntax where a `switch` expression would be more concise and safer.** The statement form requires `break` (or `return`) to avoid unintended fallthrough between cases and doesn't produce a value directly; the expression form (`switch (x) { pattern => value, ... }`) is terser, produces a value, and can't accidentally fall through.
3. **Not using pattern matching's type-check-and-bind in one step.** `case int i when i > 0:` (or `int i => ...` in an expression) both checks the type *and* binds a correctly-typed local variable in one pattern — writing a separate `is int` check followed by a manual cast duplicates what the pattern already does atomically.
4. **Comparing floating-point values for exact equality in a condition** (`if (x == 0.3)`) — the same rounding-error trap as any language; compare against a small tolerance instead when the value comes from computation rather than a literal.

## Exercise

Write a function `String grade(int score)` returning `"A"` for 90+, `"B"` for 80-89, `"C"` for 70-79, and `"F"` otherwise, using a `switch` expression with relational patterns.

Try it yourself first, then check [`solutions/exercise_1.dart`](./solutions/exercise_1.dart).

## Interview questions

1. **What does it mean for a `switch` expression to be exhaustive, and how does Dart enforce it?** — Exhaustive means every possible value of the switched-on type is handled by some pattern. For `switch` used as an *expression* (producing a value), the compiler requires this — either by covering every case of a sealed/enum type, or via a `_` wildcard pattern that matches anything not otherwise covered; a non-exhaustive `switch` expression is a compile error.
2. **How does Dart's pattern matching (`case int i when i > 0`) improve on a manual `is`-check-then-cast?** — A pattern like `int i` both verifies the value's runtime type *and* binds it to a correctly-typed local variable (`i`) in one step; a manual `if (value is int) { int i = value as int; ... }` duplicates that work across two statements and risks the cast becoming inconsistent with the check if the code is edited later. Patterns also compose (destructuring records, lists, and objects), which manual type checks can't express as directly.

---
← [Previous: Operators](../03_operators/README.md) | [Next: Loops →](../05_loops/README.md)
