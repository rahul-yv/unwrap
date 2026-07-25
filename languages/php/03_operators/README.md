# Operators

PHP has the usual arithmetic, comparison, and logical operators, plus a distinctive spaceship operator (`<=>`, returns -1/0/1 for less/equal/greater, useful in sort callbacks), string concatenation with `.`, array union with `+` (keeps the left array's values for duplicate keys, unlike `array_merge`), and the null coalescing assignment `??=`.

## Example

```php
<?php
$sum = 3 + 4;
$remainder = 10 % 3;

$greeting = "Hello, " . "world";   // string concatenation with .

$a = ["x" => 1, "y" => 2];
$b = ["y" => 99, "z" => 3];
$union = $a + $b;   // ["x" => 1, "y" => 2, "z" => 3] — left array wins on duplicate keys

$cmp = 3 <=> 5;   // -1
usort($items, fn($a, $b) => $a["age"] <=> $b["age"]);

$config = [];
$config["retries"] ??= 3;   // sets to 3 only if not already set
```

See [`example.php`](./example.php) for the full runnable file.

## Common mistakes

1. **Confusing `+` (array union) with `array_merge()` for arrays.** `$a + $b` keeps `$a`'s value for any key present in both; `array_merge($a, $b)` lets `$b`'s value win for string keys but *renumbers* numeric keys instead of overwriting — the two are not interchangeable, and picking the wrong one silently produces the wrong result rather than erroring.
2. **Using `==` for the spaceship operator's job (custom sort comparisons)** instead of `<=>`, requiring a more verbose `if/elseif/else` returning -1/0/1 manually — `<=>` does exactly this comparison in one expression for any comparable pair.
3. **Forgetting string concatenation uses `.`, not `+`.** `"5" + "3"` performs numeric addition (coercing both to numbers, giving `8`), not concatenation — `.` is required for string joining, a common source of confusion coming from languages that overload `+` for both.
4. **Overusing `??=` where a real validation error should occur instead** — silently defaulting a missing required configuration value can mask a genuine misconfiguration that should fail loudly rather than be quietly papered over.

## Exercise

Write a function `function clamp(int $value, int $min, int $max): int` that returns `$value` clamped to the `[$min, $max]` range.

Try it yourself first, then check [`solutions/exercise_1.php`](./solutions/exercise_1.php).

## Interview questions

1. **What does the spaceship operator (`<=>`) return, and where is it most useful?** — It returns `-1` if the left operand is less than the right, `0` if equal, `1` if greater — exactly the contract `usort()`/`uasort()`/`uksort()` comparison callbacks expect, so `fn($a, $b) => $a <=> $b` (or comparing a derived field) is the idiomatic way to write a sort comparator without manual if/else branches.
2. **How does `+` differ from `array_merge()` when combining two arrays?** — `+` (array union) walks both arrays and, for any key present in both, keeps the *left* array's value, leaving numeric keys as-is; `array_merge()` lets the *right* array's value win for string keys, but renumbers (rather than preserves) numeric keys, effectively appending numerically-indexed elements. Choosing between them depends on whether keys are associative (where the "which side wins" distinction matters) or numeric (where `array_merge`'s renumbering usually is what's wanted).

---
← [Previous: Data Types](../02_datatypes/README.md) | [Next: Conditionals →](../04_conditions/README.md)
