# Variables

Java is statically typed: every variable's type is fixed at declaration and checked at compile time. `var` (since Java 10) infers the type from the initializer for local variables — it's still statically typed, just with less typing on your part; it doesn't work for fields or method parameters. `final` prevents reassignment, Java's equivalent of `const` for the binding (not the object).

## Example

```java
int age = 25;              // explicit type
var name = "Ada";          // inferred as String
age = age + 1;

final int MAX_RETRIES = 3; // cannot be reassigned
// MAX_RETRIES = 4;         // compile error

int[] point = {3, 4};      // arrays are reference types with a fixed size
```

See [`Example.java`](./Example.java) for the full runnable file.

## Common mistakes

1. **Confusing `final` with deep immutability.** `final List<Integer> list = new ArrayList<>();` prevents reassigning `list` to a different object, but the list's *contents* can still be mutated (`list.add(1)` is fine). Use `Collections.unmodifiableList` or an immutable collection type for real immutability.
2. **Using `var` where the inferred type isn't obvious from the right-hand side**, hurting readability — `var` is best when the type is already clear from context (`var name = "Ada"`), not when it obscures what a method call actually returns.
3. **Mixing up primitive types and their boxed wrapper classes** (`int` vs `Integer`) — boxed types can be `null` and are compared by reference with `==` (use `.equals()`), while primitives can't be `null` and compare by value with `==`. Autoboxing hides the conversion but not the semantic difference.
4. **Forgetting Java has no unsigned integer types** (except via specific `Integer`/`Long` static methods added later) — all integer types are signed; a value that would overflow a signed type wraps around rather than erroring.

## Exercise

Write a method `int[] swap(int a, int b)` that returns a two-element array `{b, a}`.

Try it yourself first, then check [`solutions/Exercise1.java`](./solutions/Exercise1.java).

## Interview questions

1. **What's the difference between `int` and `Integer`?** — `int` is a primitive (fixed-size value, can't be `null`, compared by value); `Integer` is its boxed wrapper class (an object, can be `null`, compared by reference with `==` unless using `.equals()`), used where a reference type is required (e.g. generic collections).
2. **Does `final` make an object immutable?** — No — it only prevents the variable from being reassigned to a different reference; the object it points to can still be mutated through its own methods if the object itself is mutable.

---
← Previous: (start) | [Next: Data Types →](../02_datatypes/README.md)
