# Loops

Java has the classic C-style `for (;;)`, `while`, `do...while`, and the enhanced for-each `for (Type x : collection)` for iterating arrays/`Iterable`s without manual indexing.

## Example

```java
for (int i = 0; i < 3; i++) {
	System.out.println(i);
}

for (String item : new String[] {"a", "b", "c"}) {
	System.out.println(item);      // enhanced for-each
}

int n = 0;
while (n < 3) {
	n++;
}

int count = 0;
do {
	count++;
} while (count < 3);   // body runs at least once, condition checked after
```

See [`Example.java`](./Example.java) for the full runnable file.

## Common mistakes

1. **Modifying a `List` while iterating it with a for-each loop.** Throws `ConcurrentModificationException` — the enhanced for-each uses an `Iterator` internally, which detects the collection changed underneath it. Use `Iterator.remove()`, or iterate a copy, or build a new list instead.
2. **Reaching for a classic indexed `for` loop when a for-each expresses the intent more clearly** and avoids off-by-one errors — use for-each whenever the index itself isn't needed.
3. **Confusing `while` and `do...while`.** `do...while` always runs the body at least once before checking the condition; `while` checks first and may never run the body at all if the condition starts `false`.
4. **Off-by-one errors with `<` vs `<=`** in a classic `for` loop — always double-check the intended range against the actual comparison operator used.

## Exercise

Write `int firstEven(int[] numbers)` returning the first even number, or `-1` if there isn't one, using an enhanced for-each loop.

Try it yourself first, then check [`solutions/Exercise1.java`](./solutions/Exercise1.java).

## Interview questions

1. **Why does modifying a `List` during a for-each loop throw `ConcurrentModificationException`?** — The enhanced for-each is sugar over calling `.iterator()` and repeatedly `.next()`; most standard collection iterators track a modification count and fail fast if the underlying collection changed during iteration, rather than silently producing wrong/skipped results.
2. **What's the difference between `while` and `do...while`?** — `while` checks the condition before the first iteration (may run zero times); `do...while` checks after the first iteration (always runs at least once).

---
← [Previous: Conditionals](../04_conditions/README.md) | [Next: Functions →](../06_functions/README.md)
