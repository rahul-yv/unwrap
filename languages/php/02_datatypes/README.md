# Data Types

PHP's scalar types are `int`, `float`, `string`, `bool`, plus `array`, `object`, and `null`. PHP is loosely typed by default: `==` performs type coercion (`"5" == 5` is `true`), while `===` compares both value and type without coercion — almost always the right choice. Nullable types are written `?Type` in type declarations, and `??` (null coalescing) provides a default for `null`.

## Example

```php
<?php
$i = 42;
$f = 3.14;
$s = "hello";
$b = true;
$n = null;

$loose = ("5" == 5);     // true — coercion
$strict = ("5" === 5);   // false — different types

$name = null;
$length = $name ?? "default";   // null coalescing: "default" since $name is null

function greet(?string $name): string {
	return "Hello, " . ($name ?? "stranger");
}

$ratio = 3 / 2;    // 1.5 — PHP's `/` always does floating-point division
$intdiv = intdiv(3, 2);   // 1 — explicit integer division
```

See [`example.php`](./example.php) for the full runnable file.

## Common mistakes

1. **Using `==` where `===` was intended.** PHP's loose comparison has famously surprising coercion rules (historically, `0 == "abc"` was `true` in PHP < 8; PHP 8 fixed several of the worst cases, but `==` still coerces types in ways that can surprise) — `===` avoids the whole category of bugs by never coercing.
2. **Forgetting `/` always returns a float (or int, if evenly divisible with both ints — actually PHP's `/` returns `int` only when the result is a whole number and both operands are `int`; otherwise `float`), unlike languages where integer division truncates by default.** Use `intdiv()` when integer division (truncating toward zero) is specifically wanted.
3. **Not using `?Type`/nullable type declarations and relying on PHP's automatic `null`-to-default-value coercion**, which can silently accept unintended `null`s where a real value was expected — being explicit about which parameters can be `null` documents intent and lets static analysis catch misuse.
4. **Using `is_null($x)` and `$x === null` inconsistently across a codebase** — both work identically; pick one convention (most style guides prefer `=== null` since it reads consistently with other strict comparisons).

## Exercise

Write a function `function safeLength(?string $s): int` that returns the string's length, or `0` if it's `null`, using the null coalescing operator.

Try it yourself first, then check [`solutions/exercise_1.php`](./solutions/exercise_1.php).

## Interview questions

1. **What's the difference between `==` and `===` in PHP?** — `==` (loose equality) coerces operands to a common type before comparing, following a set of rules that have changed (and been tightened) across PHP versions and can still surprise; `===` (strict equality) requires both the value and the type to match, with no coercion — the recommended default for almost all comparisons.
2. **What does `??` do, and how does it differ from `?:` (the short ternary)?** — `??` (null coalescing) returns its left operand if it is set and not `null`, otherwise the right operand — it specifically checks for `null`/unset, without emitting a warning for undefined variables. `?:` (short ternary, `$a ?: $b`) returns `$a` if it's truthy, otherwise `$b` — it triggers PHP's normal truthiness rules (so `0`, `""`, and `[]` are also treated as "use the fallback"), which is a broader check than just "is it `null`."

---
← [Previous: Variables](../01_variables/README.md) | [Next: Operators →](../03_operators/README.md)
