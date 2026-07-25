# Variables

Dart is statically typed with type inference: `var` infers the type from the initializer and stays that type (unlike JavaScript's `var`); `final` declares a single-assignment variable (the reference can't be reassigned, but the object can still mutate if it's mutable); `const` is a compile-time constant — deeper than `final`, since a `const` object's entire value must be knowable at compile time, and `const` collections are truly immutable.

## Example

```dart
var age = 25;              // inferred as int
String name = "Ada";        // explicit type
age = age + 1;

final maxRetries = 3;       // cannot be reassigned
// maxRetries = 4;           // compile error

const List<int> point = [3, 4];   // compile-time constant, deeply immutable
// point[0] = 99;                  // compile error — const lists can't be mutated

var mutablePoint = [3, 4];
var copy = mutablePoint;    // lists are reference types — copy aliases mutablePoint
copy[0] = 99;
// mutablePoint is now [99, 4] too
```

See [`example.dart`](./example.dart) for the full runnable file.

## Common mistakes

1. **Confusing `final` with `const`.** `final` means "this variable can only be assigned once," but the value can be computed at runtime and, if it's a mutable collection, its *contents* can still change; `const` means the entire value must be known at compile time and, for collections, makes the whole structure deeply immutable — `final List<int> x = [1,2,3]` allows `x.add(4)`, but `const List<int> x = [1,2,3]` does not.
2. **Assuming `var list2 = list1` makes an independent copy.** Dart's collections (`List`, `Map`, `Set`) are reference types — assignment shares the same underlying object; use `List.from(list1)` or the spread operator (`[...list1]`) for an actual copy.
3. **Using `dynamic` where a more specific type (or `var` with inference) would catch bugs at compile time.** `dynamic` opts a variable out of static type checking entirely — any operation on it is deferred to runtime, silently accepting type errors that `var`/explicit types would catch immediately.
4. **Not using `late` for a variable that's definitely initialized before use but not at declaration time** — Dart's null safety requires non-nullable variables to be initialized, but `late` defers that requirement (and the corresponding null-check) to first use, trading a compile-time guarantee for flexibility; using it defensively for variables that might not actually be initialized reintroduces the runtime null risk null safety was meant to prevent.

## Exercise

Write a function `List<int> swap(int a, int b)` that returns `[b, a]`.

Try it yourself first, then check [`solutions/exercise_1.dart`](./solutions/exercise_1.dart).

## Interview questions

1. **What's the difference between `final` and `const` in Dart?** — `final` allows the value to be computed at runtime and assigned once; the variable can't be reassigned, but if it holds a mutable object, that object's contents can still change. `const` requires the entire value to be a compile-time constant, and for collections, produces a canonicalized, deeply immutable value — attempting to mutate a `const` list/map throws (compile error for direct literal mutation, or an `Unsupported operation` exception at runtime for a stored `const` reference).
2. **Why are Dart's `List`/`Map`/`Set` reference types, and what's the practical implication?** — Like most object-oriented languages (Java, C#, Kotlin, JS), Dart's collections are objects, and assigning one variable to another copies the *reference*, not the contents — two variables can end up pointing at (and mutating) the same underlying collection. Use `List.of(...)`/`.toList()`/the spread operator (`[...list]`) to make an explicit copy when independence is needed.

---
← Previous: (start) | [Next: Data Types →](../02_datatypes/README.md)
