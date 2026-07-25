# Modules and Packages

PHP has no built-in module system at the language level — `require`/`require_once` (or `include`/`include_once`) pull another file's code into the current script at runtime. Real-world PHP projects use **namespaces** (`namespace App\Helpers;`) to avoid name collisions across files, and **Composer** (PHP's package manager) with PSR-4 autoloading to map namespaces to file paths automatically, so you rarely write manual `require` calls for your own classes — but the underlying mechanism is still just "load and execute this file."

## Example

```php
<?php
// mypackage/Helpers.php
namespace MyPackage;

function greet(string $name): string {
	return "Hello, $name!";
}
```

```php
<?php
// using it — example.php
require __DIR__ . "/mypackage/Helpers.php";

use function MyPackage\greet;

echo greet("Ada");
```

See [`example.php`](./example.php) and [`mypackage/`](./mypackage/) for the full runnable files.

## Common mistakes

1. **Using `require`/`include` instead of `require_once`/`include_once` for a file that might be loaded from multiple places**, causing "cannot redeclare function/class" fatal errors if the same file is pulled in twice through different code paths.
2. **Not namespacing code and relying on globally unique function/class names** — without namespaces, two files defining a function with the same name (e.g. two different libraries both defining `format()`) collide at load time; namespaces (`MyPackage\format()` vs `OtherPackage\format()`) prevent this entirely.
3. **Manually `require`-ing every dependency in large projects instead of using Composer's autoloader.** Composer's PSR-4 autoloading maps namespaces to directories once (in `composer.json`) and loads classes on demand as they're referenced — manual `require` chains become unmanageable and error-prone as a project grows past a handful of files.
4. **Confusing `use function MyPackage\greet;` (importing a namespaced function) with `use TraitName;` (using a trait inside a class body)** — `use` is heavily overloaded in PHP (namespace imports, trait inclusion, closure variable capture) and means something different depending on where it appears.

## Exercise

Using `mypackage/Helpers.php`'s `greet()`, write `function exampleUsage(): string` in `solutions/exercise_1.php` returning `greet("World")`.

Try it yourself first, then check [`solutions/exercise_1.php`](./solutions/exercise_1.php).

## Interview questions

1. **How does PHP resolve `require`d files, and what happens if the same file is required twice?** — `require` reads and executes the target file's code inline, immediately, at the point it's called — if the file declares a function or class and is `require`d twice (via two different `require` statements reachable in the same run), PHP fatally errors on "cannot redeclare." `require_once` tracks which files have already been loaded and skips re-loading them, avoiding the collision.
2. **What problem do namespaces solve in PHP?** — Before namespaces (PHP 5.3+), every function and class shared one global namespace — two libraries defining a function or class with the same name couldn't be used together at all. Namespaces (`namespace App\Models;`) scope names so `App\Models\User` and `Vendor\Package\User` can coexist without collision, and Composer's autoloading conventionally maps namespace segments to directory structure.

---
← [Previous: Files and I/O](../10_files/README.md) | [Next: Testing →](../12_testing/README.md)
