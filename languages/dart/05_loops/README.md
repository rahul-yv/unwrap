# Loops

Dart has `for`, `for-in` (iterating any `Iterable`), `while`/`do-while`, and collection-for (`for` used directly inside a list/set/map literal to build it). Labeled `break`/`continue` (`outer: for (...) { break outer; }`) let a nested loop control an outer one. Dart has no built-in `range`/`step` like Python or Kotlin — index-based `for` or `Iterable.generate` fill that role.

## Example

```dart
int total = 0;
for (int i = 0; i < 5; i++) {
	total += i;
}

final items = ["a", "b", "c"];
for (final (index, value) in items.indexed) {
	// (0, "a"), (1, "b"), (2, "c") — record pattern destructuring
}

int count = 0;
while (count < 3) {
	count++;
}

final doubled = [for (final n in [1, 2, 3]) n * 2];   // collection-for: [2, 4, 6]

outer:
for (int i = 0; i < 3; i++) {
	for (int j = 0; j < 3; j++) {
		if (j == 1) continue outer;   // labeled continue: skip to the next i
	}
}
```

See [`example.dart`](./example.dart) for the full runnable file.

## Common mistakes

1. **Reaching for a manual index-based `for` loop when `for-in` or `.indexed` would be clearer.** `for (final item in list)` (or `for (final (i, item) in list.indexed)` when the index is genuinely needed) reads closer to intent than manual bounds-checking with `list[i]`.
2. **Not using collection-for to build a list/map/set directly**, instead pre-declaring an empty collection and pushing into it in a loop — `[for (final n in numbers) n * 2]` builds the transformed list in one expression, without a separate mutable accumulator variable.
3. **Using an unlabeled `break`/`continue` inside nested loops and expecting it to affect the outer loop.** An unlabeled `break`/`continue` only affects the innermost enclosing loop — a label is needed to affect an outer loop from inside a nested one.
4. **Assuming Dart has a Python/Kotlin-style `range` or `step` function.** There isn't one in core Dart — index-based `for (int i = start; i < end; i += step)` or `Iterable.generate(count, (i) => ...)` cover that need instead.

## Exercise

Write a function `int sumEvens(int n)` that returns the sum of all even numbers from `0` to `n` inclusive.

Try it yourself first, then check [`solutions/exercise_1.dart`](./solutions/exercise_1.dart).

## Interview questions

1. **What does collection-for (`[for (final x in xs) transform(x)]`) provide over a manual loop with an accumulator?** — It builds the resulting list/set/map directly as a single expression — no need to pre-declare an empty mutable collection and push into it across loop iterations. It composes with `if` inside the same literal too (`[for (final x in xs) if (cond) x]`), covering map+filter in one concise construct.
2. **What does a labeled break/continue do, and when is it needed?** — By default, `break`/`continue` affects only the innermost loop it's directly inside. A label (`outer: for (...) { ... }`) lets `break outer`/`continue outer` from a nested loop affect the labeled outer loop instead — needed when a nested loop needs to abort or skip the outer iteration based on something found inside it.

---
← [Previous: Conditionals](../04_conditions/README.md) | [Next: Functions →](../06_functions/README.md)
