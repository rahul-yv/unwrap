# Variables

PHP variables are dynamically typed and always prefixed with `$`. No declaration keyword is needed — assigning to a name creates it. PHP 7+ supports optional type declarations for function parameters/returns and typed class properties, but plain variables stay dynamically typed regardless. Variables are copied by value on assignment for scalars and arrays; objects are assigned by reference to the object (though the variable itself still holds a handle, not the object directly — reassigning the variable doesn't affect other references).

## Example

```php
<?php
$age = 25;              // dynamically typed, no keyword needed
$name = "Ada";
$age = $age + 1;

const MAX_RETRIES = 3;   // a true constant — cannot be reassigned, must be a compile-time value

$point = [3, 4];         // arrays are copied by value on assignment
$copy = $point;
$copy[0] = 99;
// $point is still [3, 4]
```

See [`example.php`](./example.php) for the full runnable file.

## Common mistakes

1. **Confusing `const` with a `define()`d constant or a variable.** `const` (used at file/class scope) requires a compile-time constant expression and is resolved at compile time; `define('NAME', value)` can use a runtime-computed value and is resolved at runtime; neither is a `$variable` and neither can be reassigned once set.
2. **Assuming arrays are reference types like in Java/JS.** PHP arrays are value types — `$copy = $point` makes a full (copy-on-write, so cheap until mutated) copy; mutating `$copy` never affects `$point`. This is the opposite of most C-family languages' arrays.
3. **Forgetting variable variables (`$$name`) exist and can make code needlessly hard to follow.** `$name = 'age'; $$name = 25;` sets `$age = 25` — legal, but usually a sign an array (`$vars['age']`) would be clearer.
4. **Using `global $var` inside functions to reach out to outer scope**, instead of passing values as parameters — PHP functions don't capture the enclosing scope automatically (unlike closures with `use`), and reaching for `global` couples the function to specific external state, making it harder to test and reason about.

## Exercise

Write a function `function swap($a, $b): array` that returns `[$b, $a]`.

Try it yourself first, then check [`solutions/exercise_1.php`](./solutions/exercise_1.php).

## Interview questions

1. **Are PHP arrays passed/assigned by value or by reference?** — By value (with copy-on-write internally for efficiency) — assigning an array to another variable, or passing it to a function without an `&` parameter, copies it; mutating the copy doesn't affect the original. Explicit reference assignment (`$b = &$a`) or a `&$param` function parameter opts into reference semantics.
2. **What's the difference between `const` and `define()`?** — `const` is resolved at compile time, must be a scalar/constant expression, and (when used inside a class) is inherited by subclasses like a class member; `define()` is a runtime function call, can compute its value dynamically, and is always in the global namespace regardless of surrounding class/namespace context.

---
← Previous: (start) | [Next: Data Types →](../02_datatypes/README.md)
