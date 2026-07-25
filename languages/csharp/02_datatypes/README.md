# Data Types

C#'s built-in types map to .NET types: `int` (`System.Int32`), `double`, `bool`, `char`, `string`, plus `decimal` (128-bit, base-10 — for money, where `double`'s binary rounding is unacceptable). The key type-system feature is **nullable types**: value types can't normally be `null`, but `int?` (shorthand for `Nullable<int>`) allows it, and C# 8+ adds nullable *reference* types (`string?`) with compiler null-flow analysis to catch null-dereference bugs at compile time.

## Example

```csharp
int n = 10;
double pi = 3.14159;
decimal price = 19.99m;      // m suffix for decimal — exact base-10, ideal for money
bool ok = true;

int? maybe = null;           // nullable value type
if (maybe.HasValue) {
	int x = maybe.Value;
}
int fallback = maybe ?? 0;   // null-coalescing: 0 if maybe is null

#nullable enable
string? nullableRef = null;   // nullable reference type; compiler tracks null-flow
string nonNull = "always";    // compiler warns if this could be null
```

See [`example.cs`](./example.cs) for the full runnable file.

## Common mistakes

1. **Using `double` for money.** Binary floating point can't represent most decimal fractions exactly (`0.1 + 0.2 != 0.3`), so financial math accumulates rounding errors — use `decimal` (base-10, exact for the values money takes) for currency and any calculation where decimal precision is required.
2. **Calling `.Value` on a nullable that's `null`.** `((int?)null).Value` throws `InvalidOperationException`; check `.HasValue` (or use `??` / pattern matching) first — the same discipline as unwrapping an optional in other languages.
3. **Ignoring nullable-reference-type warnings.** With `#nullable enable`, the compiler flags potential null dereferences — treating these warnings as noise defeats a feature specifically designed to prevent `NullReferenceException`, the most common .NET runtime error.
4. **Confusing the null-coalescing operator `??` with `||`-style fallback in other languages.** `??` returns the right operand only when the left is `null` (not for other "falsy" values like `0` or `""`) — it's precisely a null check, similar to Rust's/Kotlin's null-handling operators.

## Exercise

Write a method `int Describe(int? value)` that returns `value` doubled if it has a value, or `-1` if it's `null`, using nullable handling (not a raw `.Value` that could throw).

Try it yourself first, then check [`solutions/exercise_1.cs`](./solutions/exercise_1.cs).

## Interview questions

1. **When should you use `decimal` instead of `double`, and why?** — For monetary values and any calculation requiring exact decimal representation: `double` is binary floating point and can't represent values like `0.1` exactly, so repeated arithmetic accumulates rounding error; `decimal` is a base-10 128-bit type that represents decimal fractions exactly (within its precision), avoiding those errors at the cost of a larger, slower type.
2. **What problem do nullable reference types (`string?`) solve?** — They let the compiler distinguish references that may be `null` from those that shouldn't be, and perform null-flow analysis to warn when a possibly-null reference is dereferenced without a check — catching a large class of `NullReferenceException` bugs at compile time rather than at runtime.

---
← [Previous: Variables](../01_variables/README.md) | [Next: Operators →](../03_operators/README.md)
