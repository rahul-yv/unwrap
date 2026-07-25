# Functions

Dart functions support optional positional parameters (`[int x]`), named parameters (`{int x}`, optionally `required`), default values, and arrow-body syntax (`int square(int x) => x * x`) for single-expression bodies. Functions are first-class values (`int Function(int)` is a function type), and closures capture variables from their enclosing scope by reference.

## Example

```dart
String greet(String name, {String greeting = "Hello"}) => "$greeting, $name!";

greet("Ada");                          // "Hello, Ada!"
greet("Ada", greeting: "Hi");           // "Hi, Ada!" — named argument

int Function(int) makeAdder(int n) {
	return (x) => x + n;                  // closure over n
}
final addTen = makeAdder(10);
addTen(5);                              // 15

int Function() makeCounter() {
	int count = 0;
	return () => ++count;                 // closure over count, persists across calls
}
```

See [`example.dart`](./example.dart) for the full runnable file.

## Common mistakes

1. **Forgetting named parameters must be `required` to be mandatory.** `{String greeting}` alone is optional and defaults to `null` unless typed as non-nullable with a default value (`{String greeting = "Hello"}`) or explicitly marked `{required String greeting}` — omitting `required` on a non-defaulted named parameter that's actually mandatory is a common oversight caught by the type checker, but worth being deliberate about.
2. **Mixing positional optional (`[int x]`) and named optional (`{int x}`) parameters in ways that make call sites ambiguous or hard to read** — Dart allows either style (not both for the same parameter), but named parameters are generally preferred for anything beyond one or two optional values, since they self-document at the call site.
3. **Assuming a closure captures a variable's value at creation time rather than a live reference.** `makeCounter`'s returned closure keeps a live reference to `count`, not a snapshot — each call sees (and mutates) the same captured variable, which is exactly what makes the counter pattern work, but can surprise if you expected each closure to get an independent copy.
4. **Overusing optional/named parameters where a dedicated class (or a Dart 3 record) would communicate a set of related values more clearly** — a function with many optional parameters called positionally-adjacent-to-named is harder to read than a well-named parameter object.

## Exercise

Write a function `int Function() makeCounter()` returning a closure; each call to the returned closure returns an incrementing count starting at 1.

Try it yourself first, then check [`solutions/exercise_1.dart`](./solutions/exercise_1.dart).

## Interview questions

1. **What's the difference between positional optional parameters (`[int x]`) and named parameters (`{int x}`) in Dart?** — Positional optional parameters are provided (or omitted) by position, in square brackets, without a name at the call site (`greet("Ada", "Hi")`); named parameters are provided by name in curly braces (`greet("Ada", greeting: "Hi")`), can be reordered freely at the call site, and can be marked `required` to make them mandatory despite being named — named parameters are generally preferred once there's more than one or two optional values, for readability.
2. **What does it mean for a closure to "capture" a variable, and how does `makeCounter` use it?** — The closure keeps a live reference to the variable from its enclosing scope (not a copy of its value at creation time), so it can read and mutate that variable across multiple calls, even after the enclosing function has returned. `makeCounter`'s returned closure captures `count`; each invocation increments and returns that same captured variable, which is how the counter accumulates state between calls.

---
← [Previous: Loops](../05_loops/README.md) | Next: Collections (coming soon)
