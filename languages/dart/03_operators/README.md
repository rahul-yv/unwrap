# Operators

Dart has the usual arithmetic, comparison, and logical operators, plus null-aware operators (`??`, `?.`, `??=`), the cascade operator (`..`, chains multiple calls/assignments on the same object without repeating its name), and operator overloading via special method syntax (`operator +(other)`). `~/` is truncating integer division, distinct from `/`'s always-double result.

## Example

```dart
int sum = 3 + 4;
int remainder = 10 % 3;

int? x;
int y = x ?? -1;          // -1 — if-null: x is null
x ??= 5;                   // assigns 5 only because x was null
x ??= 99;                  // no-op — x is already non-null

class Point {
  final int x, y;
  const Point(this.x, this.y);
  Point operator +(Point other) => Point(x + other.x, y + other.y);   // operator overloading

  @override
  bool operator ==(Object other) => other is Point && x == other.x && y == other.y;
  @override
  int get hashCode => Object.hash(x, y);
}
final p = const Point(1, 2) + const Point(3, 4);   // Point(4, 6)

final buffer = StringBuffer()
  ..write("Hello")     // cascade: each .. calls a method on buffer, returning buffer itself
  ..write(", ")
  ..write("world!");
```

See [`example.dart`](./example.dart) for the full runnable file.

## Common mistakes

1. **Overriding `==` without also overriding `hashCode`.** Dart (like Java) requires equal objects to produce equal hash codes — a `Point` where `==` compares `x`/`y` but `hashCode` uses the default identity-based hash breaks `Set`/`Map` usage (two "equal" points might land in different hash buckets and never be recognized as duplicates).
2. **Using `.` chains where the cascade operator (`..`) would eliminate repetition.** `buffer.write("a"); buffer.write("b");` repeats `buffer` twice; `buffer..write("a")..write("b")` reads as "on buffer, do this, then this" without repeating the receiver, and is idiomatic Dart for object configuration/builder-style code.
3. **Confusing `??=` with a plain `=`.** `x ??= 5` only assigns if `x` is currently `null` — if `x` already has a value, `??=` is a no-op, unlike `=` which always overwrites.
4. **Forgetting `/` always returns a `double` even when both operands are `int`**, and reaching for `/` when integer (truncating) division was actually intended — `~/` is the operator for that.

## Exercise

Write a function `int clamp(int value, int min, int max)` that returns `value` clamped to the `[min, max]` range.

Try it yourself first, then check [`solutions/exercise_1.dart`](./solutions/exercise_1.dart).

## Interview questions

1. **Why must `hashCode` be overridden whenever `==` is overridden?** — Hash-based collections (`Set`, `Map`) use `hashCode` to decide which bucket to place/look up an object in, then use `==` to confirm equality among objects that landed in the same bucket. If two objects are `==` but have different `hashCode`s, they can end up in different buckets and never be compared with `==` at all — breaking `Set.contains`, `Map` key lookups, and deduplication silently.
2. **What does the cascade operator (`..`) do?** — It lets you invoke a sequence of methods/property assignments on the *same* object without repeating a reference to it, and the whole cascaded expression evaluates to the original object (not the last call's return value) — useful for builder-style configuration (`Path()..moveTo(0,0)..lineTo(10,10)`) where you'd otherwise write the receiver's name on every line.

---
← [Previous: Data Types](../02_datatypes/README.md) | [Next: Conditionals →](../04_conditions/README.md)
