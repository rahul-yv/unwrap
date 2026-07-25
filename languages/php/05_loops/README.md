# Loops

PHP has `for`, `while`, `do-while`, and `foreach` — the idiomatic choice for iterating arrays, supporting both `foreach ($arr as $value)` and `foreach ($arr as $key => $value)`. `foreach` iterates a *copy* of the array by default; iterating by reference (`foreach ($arr as &$value)`) lets the loop body modify the original array in place, but the reference must be unset afterward to avoid a subtle bug.

## Example

```php
<?php
for ($i = 0; $i < 5; $i++) {
	// 0, 1, 2, 3, 4
}

$items = ["a", "b", "c"];
foreach ($items as $index => $value) {
	// 0 => "a", 1 => "b", 2 => "c"
}

$numbers = [1, 2, 3];
foreach ($numbers as &$n) {
	$n *= 2;
}
unset($n);   // break the reference after the loop — see "Common mistakes"
// $numbers is now [2, 4, 6]

$count = 0;
while ($count < 3) {
	$count++;
}
```

See [`example.php`](./example.php) for the full runnable file.

## Common mistakes

1. **Forgetting to `unset()` a by-reference loop variable after `foreach ($arr as &$value)`.** The variable keeps referencing the array's last element after the loop ends; a *subsequent* `foreach` reusing the same variable name (without `&`) then silently overwrites that last element instead of assigning a fresh loop variable — a classic, hard-to-spot PHP bug.
2. **Mutating an array while iterating it with `foreach` by value** (adding/removing keys mid-loop) and expecting the loop to see the changes — `foreach` (without `&`) iterates a snapshot copy made at the start, so mutations to the original during the loop aren't reflected in that iteration.
3. **Using `for` with `count($array)` recomputed on every iteration** instead of caching it in a variable before the loop — for a large array this recomputes the count unnecessarily each time (minor in practice since `count()` is O(1) for PHP arrays, but caching is still the clearer idiom and matters if `count()` were replaced by something more expensive).
4. **Reaching for a `for` loop with manual indexing where `foreach` would be simpler and safer** — `foreach` handles PHP arrays' arbitrary key types (string or int, in any order) correctly, while a `for` loop assumes sequential integer keys starting at 0, which isn't guaranteed for arrays built via `unset()` or associative insertion.

## Exercise

Write a function `function sumEvens(int $n): int` that returns the sum of all even numbers from `0` to `$n` inclusive.

Try it yourself first, then check [`solutions/exercise_1.php`](./solutions/exercise_1.php).

## Interview questions

1. **Why must a by-reference `foreach` loop variable be `unset()` after the loop?** — `foreach ($arr as &$value)` makes `$value` an alias for each array element, and after the loop ends, `$value` still refers to (aliases) the last element. If the same variable name is reused in a later `foreach ($arr2 as $value)` (without `&`), PHP assigns each new element to that same aliased variable — which, because it's still bound to the original array's last slot, silently corrupts the original array. `unset($value)` breaks the alias so this can't happen.
2. **Does `foreach` see mutations made to the array during iteration?** — By default (iterating by value, without `&`), no — `foreach` works over an internal copy taken when the loop starts, so additions/removals during the loop don't affect that iteration's results. Iterating by reference (`as &$value`) iterates the live array directly, which can then be affected by mutations, though modifying an array's structure (adding/removing keys) while iterating by reference is still fragile and best avoided.

---
← [Previous: Conditionals](../04_conditions/README.md) | [Next: Functions →](../06_functions/README.md)
