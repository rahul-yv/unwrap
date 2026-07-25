# Functions

PHP functions support default parameter values, named arguments (since PHP 8.0), variadic parameters (`...$args`), and closures (`function() use ($x) {}` or the terser arrow function `fn($x) => ...`, which auto-captures by value). Arrow functions can only be a single expression; regular closures with `use` can hold a full block and choose to capture by value or by reference (`use (&$x)`).

## Example

```php
<?php
function greet(string $name, string $greeting = "Hello"): string {
	return "$greeting, $name!";
}

greet("Ada");                       // "Hello, Ada!"
greet("Ada", greeting: "Hi");        // "Hi, Ada!" — named argument

function sum(int ...$numbers): int {
	return array_sum($numbers);
}
sum(1, 2, 3);                        // 6 — variadic parameter

$addFive = fn($x) => $x + 5;         // arrow function, auto-captures $x is a param not a capture
$addFive(3);                          // 8

function makeCounter(): callable {
	$count = 0;
	return function () use (&$count) {   // capture by reference — persists across calls
		return ++$count;
	};
}
```

See [`example.php`](./example.php) for the full runnable file.

## Common mistakes

1. **Forgetting a regular closure (`function() use ($x) {}`) captures `$x` by value by default**, so mutating `$x` inside the closure doesn't affect the outer variable, and later mutations to the outer `$x` after the closure is created aren't seen by the closure either — `use (&$x)` is required for either direction of persistence.
2. **Using an arrow function (`fn`) when a closure that mutates captured state was actually needed.** Arrow functions auto-capture by value only (never by reference) and can only contain a single expression — reach for `function() use (&$x) {}` when the closure needs to read live outer state or accumulate across calls.
3. **Mixing positional and named arguments incorrectly** — named arguments must come after all positional arguments in a call; and once using named arguments, the parameter names become part of the function's effective public contract (renaming a parameter is a breaking change for callers using named arguments).
4. **Not type-declaring variadic parameters or default values where a stricter contract would catch bugs earlier** — PHP won't enforce a variadic parameter's element types beyond the declared type hint (`int ...$numbers` does check each argument is an `int`), but omitting the type entirely accepts anything, deferring a would-be `TypeError` to wherever the value is eventually misused.

## Exercise

Write a function `function makeCounter(): callable` returning a closure; each call to the returned closure returns an incrementing count starting at 1 (use `use (&$count)`).

Try it yourself first, then check [`solutions/exercise_1.php`](./solutions/exercise_1.php).

## Interview questions

1. **What's the difference between capturing a variable by value versus by reference in a PHP closure?** — `use ($x)` copies `$x`'s current value into the closure at creation time — later changes to the outer `$x` (or inside the closure, to its own copy) don't cross that boundary in either direction. `use (&$x)` captures a reference — the closure and the outer scope share the same underlying variable, so changes made by either side are visible to the other, and the closure can accumulate state across multiple calls (as in `makeCounter`).
2. **When would you choose a regular closure over an arrow function (`fn`)?** — Arrow functions are limited to a single expression and can only capture by value (automatically, without an explicit `use`) — convenient for short, pure transformations passed to something like `array_map`. A regular closure is needed for a multi-statement body, or when the closure must capture by reference to mutate outer state or retain state across repeated calls (a counter, an accumulator).

---
← [Previous: Loops](../05_loops/README.md) | [Next: Collections →](../07_collections/README.md)
