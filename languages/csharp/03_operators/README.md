# Operators

C# has the usual arithmetic/comparison/logical operators plus several null-focused ones that define its ergonomics: `??` (null-coalescing — fallback when null), `??=` (null-coalescing assignment — assign only if currently null), `?.` (null-conditional — safe member access that short-circuits to null). It also supports operator overloading (like C++) and the `is`/pattern-matching operators for type tests.

## Example

```csharp
string? name = null;
string display = name ?? "Anonymous";   // "Anonymous" — ?? falls back on null

name ??= "Default";                      // assigns "Default" since name was null

int[]? items = null;
int? count = items?.Length;              // null (not an exception) — ?. short-circuits

object value = "hello";
if (value is string s) {                 // is-pattern: type test + cast in one
	int len = s.Length;
}

int q = 7 / 2;                            // 3 — integer division
int r = 7 % 2;                            // 1
```

See [`example.cs`](./example.cs) for the full runnable file.

## Common mistakes

1. **Using `??` where the left side could be a valid non-null "empty" value.** `??` only falls back on `null` — for a string, `"" ?? "x"` is `""` (empty string isn't null); if you want to treat empty as absent too, check explicitly (`string.IsNullOrEmpty`).
2. **Chaining `?.` but forgetting the whole expression's type becomes nullable.** `items?.Length` is `int?`, not `int`, because the `?.` can produce `null` — assigning it to a plain `int` won't compile; keep the result nullable or supply a `?? fallback`.
3. **Confusing `is` (pattern/type test, returns bool) with `as` (safe cast, returns null on failure).** `value is string` tests and can bind a variable; `value as string` casts and yields `null` if the cast fails (no exception, unlike a direct `(string)value` cast which throws).
4. **Forgetting integer division truncates.** `7 / 2` is `3` (both operands are `int`); use a floating-point operand (`7.0 / 2`) for `3.5`, same as most C-family languages.

## Exercise

Write a method `string DisplayName(string? name)` returning `name` if it's non-null and non-empty, otherwise `"Anonymous"` (use `??` combined with an empty check, or `string.IsNullOrEmpty`).

Try it yourself first, then check [`solutions/exercise_1.cs`](./solutions/exercise_1.cs).

## Interview questions

1. **What's the difference between `is` and `as` for type conversion?** — `is` is a boolean type test (optionally binding the value to a new variable via pattern matching: `if (x is string s)`); `as` performs a cast that returns `null` if the conversion fails instead of throwing (only valid for reference/nullable types). A direct cast `(string)x` throws `InvalidCastException` on failure — so `as` is for "try to cast, null if not," `is` for "check, then use."
2. **What does the null-conditional operator `?.` do to an expression's type?** — It short-circuits to `null` if the left operand is `null` (avoiding a `NullReferenceException`), which means the overall expression's type becomes nullable — e.g. `obj?.Count` where `Count` is `int` yields `int?`, because the result can be `null` when `obj` is null.

---
← [Previous: Data Types](../02_datatypes/README.md) | [Next: Conditionals →](../04_conditions/README.md)
