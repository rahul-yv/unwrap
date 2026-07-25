# Data Types

Dart's core types are `int`, `double`, `String`, `bool`, `List`, `Map`, `Set`. Dart has **sound null safety**: every type is non-nullable by default (`String`), and `?` suffixes a type to allow `null` (`String?`) — the compiler enforces that a nullable value is checked or handled before use. `??` (if-null) provides a default, `?.` (null-aware access) short-circuits to `null`, and `!` (the "bang" operator) asserts a value is non-null, throwing if it's actually `null`.

## Example

```dart
int i = 42;
double d = 3.14;
String s = "hello";
bool b = true;

String? name;                       // explicitly nullable
int length = name?.length ?? 0;      // null-aware access + if-null: 0 since name is null

int? maybeAge = 25;
int definiteAge = maybeAge!;         // asserts non-null — throws if maybeAge were actually null

int ratio = 3 ~/ 2;    // 1 — integer division (~/)
double exact = 3 / 2;   // 1.5 — / always produces a double
```

See [`example.dart`](./example.dart) for the full runnable file.

## Common mistakes

1. **Using `!` (the bang operator) as a habitual shortcut instead of a deliberate assertion.** `name!.length` throws `TypeError`/`Null check operator used on a null value` immediately if `name` is actually `null` — it bypasses the compiler's null-safety guarantee rather than handling the case; prefer `?.`, `??`, or an explicit `if (name != null)` check (which Dart's type promotion narrows automatically within that block).
2. **Forgetting `/` always returns a `double`, even for two `int` operands.** `3 / 2` is `1.5`, not `1` — use `~/` (integer/truncating division) when an `int` result is specifically wanted.
3. **Confusing `late` with nullable.** `late String name;` promises the non-nullable `String` will be initialized before first use (deferring the null-safety check to runtime) — it's not the same as `String? name;`, which genuinely allows `null` as a valid value throughout the variable's lifetime.
4. **Not using type promotion after a null check.** Inside `if (name != null) { ... }`, Dart automatically treats `name` as the non-nullable `String` type within that block — no need for a separate `!` inside the check; the compiler already proved it can't be `null` there.

## Exercise

Write a function `int safeLength(String? s)` that returns the string's length, or `0` if it's `null`, using `?.` and `??`.

Try it yourself first, then check [`solutions/exercise_1.dart`](./solutions/exercise_1.dart).

## Interview questions

1. **What does "sound" null safety mean in Dart, and how does `!` fit in?** — "Sound" means the compiler can *guarantee* a non-nullable-typed variable never holds `null` at runtime — there's no way to circumvent it accidentally, unlike some languages' "best-effort" nullable annotations. The `!` operator is an explicit escape hatch: it tells the compiler "trust me, this is non-null right now," converting a nullable type to non-nullable — if that assertion is wrong, it throws immediately at that point, rather than silently propagating a `null` that could crash somewhere far less obvious later.
2. **Why does `/` always return a `double` in Dart, and what's the alternative for integer division?** — Dart's `/` (unlike C-family languages) always performs floating-point division regardless of operand types, avoiding the classic "silent truncation" surprise. `~/` (truncating division) explicitly returns an `int`, truncating toward zero — the operator to reach for when integer division is specifically intended.

---
← [Previous: Variables](../01_variables/README.md) | [Next: Operators →](../03_operators/README.md)
