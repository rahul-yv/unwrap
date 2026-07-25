# Object-Oriented Programming

Dart classes support single inheritance (`extends`), interfaces implicitly (any class can be used as an interface via `implements`, with no separate `interface` keyword), and mixins (`with`) for sharing behavior across unrelated class hierarchies. `abstract class` can't be instantiated directly and may declare methods without bodies. Since Dart 3, `sealed class` restricts subtypes to those declared in the same library, enabling exhaustive `switch` over them (as seen in the conditionals topic).

## Example

```dart
abstract class Greetable {
	String get name;
	String greet() => "Hello, $name!";   // abstract classes can still provide concrete methods
}

class Person extends Greetable {
	@override
	final String name;
	Person(this.name);
}

mixin Loggable {
	String log(String message) => "[$runtimeType] $message";
}

class Service with Loggable {}

sealed class Shape {}
class Circle extends Shape {
	final double radius;
	Circle(this.radius);
}
class Square extends Shape {
	final double side;
	Square(this.side);
}

double area(Shape shape) => switch (shape) {   // exhaustive: no default needed for a sealed class
	Circle(:final radius) => 3.14159 * radius * radius,
	Square(:final side) => side * side,
};
```

See [`example.dart`](./example.dart) for the full runnable file.

## Common mistakes

1. **Reaching for `extends` where `implements` or `with` (a mixin) would better express the relationship.** `extends` implies a genuine "is-a" hierarchy with a single superclass; `implements` treats a class purely as an interface contract (its own implementation isn't inherited, only its method signatures must be satisfied); `with` mixes in behavior from multiple sources without a linear inheritance chain — using `extends` for what's really "shares this behavior" forces an artificial hierarchy.
2. **Not using `sealed class` for a closed set of variants, missing out on exhaustiveness checking.** A `switch` over a `sealed class`'s subtypes is checked for exhaustiveness by the compiler — adding a new subtype without updating every relevant `switch` becomes a compile error at each incomplete site, catching the gap immediately rather than at runtime.
3. **Confusing `implements` (must reimplement every member) with `extends` (inherits the implementation).** A class that `implements` another gets *only* the interface (method signatures) — it must provide its own body for every method, even ones the "interface" class already implemented; `extends` inherits actual working implementations that can optionally be overridden.
4. **Forgetting Dart requires `@override` on overriding methods for compiler verification** — while not strictly required by the language for correctness, omitting it loses a compile-time check that the method genuinely overrides something in the superclass (catching typos in a method name that was meant to override, but doesn't).

## Exercise

Write a `sealed class Shape` with subclasses `Circle` (radius) and `Rectangle` (width, height), and a function `double perimeter(Shape shape)` covering both with an exhaustive `switch` expression.

Try it yourself first, then check [`solutions/exercise_1.dart`](./solutions/exercise_1.dart).

## Interview questions

1. **What's the difference between `extends`, `implements`, and `with` in Dart?** — `extends` establishes single inheritance from one superclass, inheriting its implementation and allowing overrides. `implements` treats the named class purely as an interface — the implementing class must provide its own implementation for every member, inheriting nothing. `with` (mixins) incorporates a set of concrete method implementations from one or more mixin declarations into a class, without a linear "is-a" inheritance relationship — Dart's answer to sharing behavior across otherwise-unrelated class hierarchies.
2. **What does `sealed class` add, and how does it interact with `switch`?** — All direct subtypes of a `sealed class` must be declared in the same library (file, or a small group of files in the same library), so the compiler knows the complete, closed set of possible subtypes. A `switch` expression over that sealed type can then be exhaustive without a `default`/`_` wildcard — and if a new subtype is added later, every such `switch` that doesn't handle it becomes a compile error, catching the gap immediately.

---
← [Previous: Collections](../07_collections/README.md) | [Next: Error Handling →](../09_errors/README.md)
