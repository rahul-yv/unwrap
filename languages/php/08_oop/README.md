# Object-Oriented Programming

PHP classes support single inheritance, interfaces (multiple implementation), traits (reusable method sets mixed into a class, PHP's answer to the lack of multiple inheritance), and — since PHP 8.1 — `enum` (including backed enums with a scalar value, and enums that can implement interfaces). Constructor property promotion (declaring and assigning a property directly in the constructor signature) removes a lot of boilerplate.

## Example

```php
<?php
interface Greetable {
	public function greet(): string;
}

class Person implements Greetable {
	public function __construct(
		private readonly string $name   // constructor property promotion
	) {}

	public function greet(): string {
		return "Hello, {$this->name}!";
	}
}

enum Status: string {
	case Active = "active";
	case Inactive = "inactive";
}

trait Loggable {
	public function log(string $message): string {
		return "[" . static::class . "] $message";
	}
}

class Service {
	use Loggable;
}
```

See [`example.php`](./example.php) for the full runnable file.

## Common mistakes

1. **Not marking a property `readonly` when it's set once in the constructor and never meant to change** — `readonly` (PHP 8.1+) makes that intent enforced by the language, throwing an error on any attempt to reassign it after construction, rather than relying on convention alone.
2. **Reaching for a trait to share state (properties) between unrelated classes**, rather than for genuinely reusable *behavior*. Traits are best for cross-cutting method implementations (like `Loggable` above); classes that need to share meaningful state usually indicate a missing shared class or interface-based composition instead.
3. **Using a plain `class` with constants for a fixed set of named values, instead of `enum`.** Class constants (`const ACTIVE = 'active';`) don't prevent an arbitrary string from being used where the constant was expected; a backed `enum` restricts values to its declared cases, and `enum`-typed parameters are checked at the type level.
4. **Forgetting an interface only declares method signatures, not implementation** — a class must still provide its own body for every interface method; PHP doesn't have default interface methods (traits are the mechanism for sharing actual implementation across classes).

## Exercise

Write an `enum Shape` (backed by `string`) with cases `Circle` and `Square`, and a function `function describe(Shape $shape): string` using `match` to return a description for each case.

Try it yourself first, then check [`solutions/exercise_1.php`](./solutions/exercise_1.php).

## Interview questions

1. **What problem do traits solve, and how do they differ from interfaces?** — PHP classes support only single inheritance; traits let a class incorporate a set of concrete method implementations from multiple sources (`use TraitA, TraitB;`), which single inheritance alone can't provide. An interface only declares a contract (method signatures) with no implementation — a class must implement each method itself (or via a trait) to satisfy an interface.
2. **What does `readonly` guarantee, and what doesn't it guarantee?** — A `readonly` property can be assigned at most once, from within the declaring class's scope (typically the constructor) — any later reassignment throws an `Error`. It does *not* make the property's value itself deeply immutable: if the readonly property holds an array or object, that array's contents or object's mutable properties can still change, even though the property binding itself can't be reassigned.

---
← [Previous: Collections](../07_collections/README.md) | [Next: Error Handling →](../09_errors/README.md)
