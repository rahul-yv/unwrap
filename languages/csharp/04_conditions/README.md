# Conditionals

C# has `if`/`else if`/`else`, the ternary `?:`, the classic `switch` statement, and — the modern highlight — the **`switch` expression** (C# 8+): a concise, expression-valued form using `=>` arms and rich **pattern matching** (type patterns, relational patterns like `>= 90`, property patterns, tuple patterns). The compiler also checks switch expressions for exhaustiveness and warns on unhandled cases.

## Example

```csharp
int score = 85;

// switch expression with relational patterns — evaluates to a value
string grade = score switch {
	>= 90 => "A",
	>= 80 => "B",
	>= 70 => "C",
	_     => "F",           // discard pattern: the default
};

// type + property patterns
object shape = new { Kind = "circle", Radius = 2.0 };
string label = shape switch {
	string s        => $"text: {s}",
	int n when n > 0 => "positive int",
	_               => "something else",
};

string result = score >= 60 ? "pass" : "fail";   // ternary still available
```

See [`example.cs`](./example.cs) for the full runnable file.

## Common mistakes

1. **Forgetting the discard arm `_` in a switch expression.** Without a catch-all (and without covering every possible value), the expression isn't exhaustive — the compiler warns, and at runtime an unmatched value throws `SwitchExpressionException`. Include `_ =>` for the default case.
2. **Falling through in a classic `switch` statement.** C# does *not* allow implicit fall-through between non-empty cases (unlike C/Java) — each case must end with `break`, `return`, or `goto case`; the compiler enforces this, which prevents the classic missing-`break` bug. (Empty cases can still stack: `case 1: case 2:`.)
3. **Writing a long `if`/`else if` chain where a switch expression is clearer** — the switch expression with relational/pattern arms is both more concise and compiler-checked for exhaustiveness.
4. **Ordering switch-expression arms wrong.** Arms are evaluated top to bottom; a broader pattern (`>= 70`) placed before a narrower one (`>= 90`) will match first and shadow it — order from most specific to least.

## Exercise

Write `string Grade(int score)` returning `"A"` for `score >= 90`, `"B"` for `>= 80`, `"C"` for `>= 70`, `"F"` otherwise, using a `switch` expression with relational patterns.

Try it yourself first, then check [`solutions/exercise_1.cs`](./solutions/exercise_1.cs).

## Interview questions

1. **What advantages does a `switch` expression have over a chain of `if`/`else if`?** — It's an expression (evaluates directly to a value, so no repeated assignments), supports rich pattern matching (type, relational, property, tuple patterns) concisely, and is checked by the compiler for exhaustiveness — warning when a case might be unhandled, which an `if`/`else if` chain never does.
2. **Does C#'s `switch` statement allow fall-through between cases like C or Java?** — No — C# disallows implicit fall-through from one non-empty case into the next; each case must explicitly end with `break`, `return`, `throw`, or `goto case`. This eliminates the accidental missing-`break` bug that fall-through languages are prone to (empty cases can still be stacked to share a body).

---
← [Previous: Operators](../03_operators/README.md) | [Next: Loops →](../05_loops/README.md)
