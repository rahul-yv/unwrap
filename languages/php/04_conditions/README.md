# Conditionals

PHP has `if`/`elseif`/`else`, `switch` (loose `==` comparison, requires `break` to avoid fallthrough), and — since PHP 8.0 — `match`, a stricter, expression-based alternative to `switch`: `match` compares with `===` (no coercion), has no fallthrough, and returns a value directly, throwing `UnhandledMatchError` if nothing matches and there's no `default`.

## Example

```php
<?php
$age = 20;
$category = $age < 13 ? "child" : ($age < 20 ? "teen" : "adult");

$x = 5;
$description = match (true) {
	$x < 0 => "negative",
	$x === 0 => "zero",
	$x % 2 === 0 => "positive even",
	default => "positive odd",
};

function describe(mixed $value): string {
	return match (true) {
		is_int($value) => "an int: $value",
		is_string($value) => "a string of length " . strlen($value),
		default => "something else",
	};
}
```

See [`example.php`](./example.php) for the full runnable file.

## Common mistakes

1. **Using `switch` where `match` would be clearer and safer.** `switch` compares with loose `==` (so `case "0":` matches `0`, `false`, and `""` in surprising ways) and silently falls through to the next case without an explicit `break`; `match` uses strict `===`, never falls through, and is an expression — preferred for new code unless multiple cases genuinely need to share one block of statements.
2. **Forgetting `match` throws `UnhandledMatchError` when nothing matches and there's no `default`** — unlike `switch`, which silently does nothing if no case matches, an unmatched `match` is a runtime error, which is usually the safer default but needs a `default` arm added deliberately when "no match" is actually a valid, expected outcome.
3. **Writing `match ($x) { true => ..., false => ... }` when a boolean condition ladder was intended**, instead of `match (true) { $cond1 => ..., $cond2 => ... }` — the latter pattern (matching against boolean expressions with `match (true)`) is how `match` expresses arbitrary conditions, not just exact-value matching.
4. **Not using the null-safe operator (`?->`) and instead chaining verbose `isset()`/ternary checks** for a chain of potentially-null property accesses — `$user?->address?->city` short-circuits to `null` at the first `null` link, replacing a nested `isset` check.

## Exercise

Write a function `function grade(int $score): string` returning `"A"` for 90+, `"B"` for 80-89, `"C"` for 70-79, and `"F"` otherwise, using `match (true)`.

Try it yourself first, then check [`solutions/exercise_1.php`](./solutions/exercise_1.php).

## Interview questions

1. **What are the key differences between `switch` and `match`?** — `match` compares with strict `===` (no type coercion), has no fallthrough between arms (each arm is a single expression, not a block that needs a `break`), is itself an expression that returns a value, and throws `UnhandledMatchError` if no arm matches and there's no `default` — `switch` compares loosely, falls through without `break`, is a statement (not directly assignable), and silently does nothing if nothing matches.
2. **How does `match (true) { $cond => ... }` work, and why is it a common pattern?** — Each arm's left-hand side is itself evaluated and compared with `===` against the subject (`true`); writing boolean expressions as arms means each is checked as "is this condition `=== true`," effectively turning `match` into an expression-based if/elseif chain — useful when the cases aren't about one variable's exact value but a set of independent conditions.

---
← [Previous: Operators](../03_operators/README.md) | [Next: Loops →](../05_loops/README.md)
