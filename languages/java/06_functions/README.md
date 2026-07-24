# Functions

Java has no standalone functions — every method belongs to a class (`static` methods belong to the class itself, instance methods to objects). Method overloading lets a class define multiple methods with the same name but different parameter lists. Since Java 8, lambdas (`(a, b) -> a + b`) and functional interfaces (an interface with exactly one abstract method) give Java function-values and closures.

## Example

```java
static String greet(String name) {
	return greet(name, "Hello");   // overload with a default-like pattern
}

static String greet(String name, String greeting) {
	return greeting + ", " + name + "!";
}

static int sum(int... nums) {   // varargs: caller can pass any number of ints
	int total = 0;
	for (int n : nums) total += n;
	return total;
}

Function<Integer, Integer> doubleIt = x -> x * 2;   // lambda, a functional interface value
```

See [`Example.java`](./Example.java) for the full runnable file.

## Common mistakes

1. **Assuming Java has default parameter values.** It doesn't — the common workaround is method overloading (a shorter overload calling the fuller one with a default), unlike languages with native default parameters.
2. **Capturing a mutable local variable in a lambda.** Java only allows capturing local variables that are effectively final (never reassigned after initialization) — a lambda can't close over a variable it (or anything else) reassigns later; use an array or a field for mutable shared state instead.
3. **Overloading ambiguously**, e.g. two overloads that both match a given call equally well (`f(int, long)` vs `f(long, int)` called with `f(1, 1)` — actually resolvable, but many near-identical overload sets aren't) — the compiler rejects genuinely ambiguous calls, but overload sets that are *almost* ambiguous are a readability trap even when they compile.
4. **Choosing the wrong functional interface** for a lambda's shape — `Function<T, R>` (takes one, returns one), `Supplier<T>` (takes none, returns one), `Consumer<T>` (takes one, returns nothing), `Predicate<T>` (takes one, returns boolean) each fit a specific shape; picking the wrong one is a compile error, but knowing which one to reach for is worth memorizing.

## Exercise

Write a method `Supplier<Integer> makeCounter()` returning a `Supplier<Integer>` (a functional interface with a `get()` method taking no arguments); each call to `.get()` returns an incrementing count starting at 1. Since a lambda can't close over a reassigned local, use a single-element `int[]` to hold the mutable count.

Try it yourself first, then check [`solutions/Exercise1.java`](./solutions/Exercise1.java).

## Interview questions

1. **Why can't a lambda capture a local variable that gets reassigned?** — Java requires captured locals to be effectively final so the lambda (which might outlive the method call, e.g. if stored and invoked later) has a stable, unambiguous value to close over — allowing reassignment would create a mismatch between what the lambda "sees" and what the enclosing method's variable currently holds.
2. **What's the difference between `Function<T, R>`, `Supplier<T>`, `Consumer<T>`, and `Predicate<T>`?** — Standard functional interfaces for common lambda shapes: `Function` takes one argument and returns a value, `Supplier` takes none and returns a value, `Consumer` takes one and returns nothing (used for side effects), `Predicate` takes one and returns `boolean` (used for filtering/testing).

---
← [Previous: Loops](../05_loops/README.md) | [Next: Collections →](../07_collections/README.md)
