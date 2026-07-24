# Loops

C has the classic three-clause `for`, `while`, and `do...while` (body runs at least once). There's no enhanced for-each — iterating an array means manually indexing with a loop counter, since C arrays don't carry their own length at runtime (see `07_collections`).

## Example

```c
for (int i = 0; i < 3; i++) {
	printf("%d\n", i);
}

int arr[] = {10, 20, 30};
int len = sizeof(arr) / sizeof(arr[0]);   // no built-in length; compute it
for (int i = 0; i < len; i++) {
	printf("%d\n", arr[i]);
}

int n = 0;
while (n < 3) {
	n++;
}

int count = 0;
do {
	count++;
} while (count < 3);   // body runs at least once
```

See [`example.c`](./example.c) for the full runnable file.

## Common mistakes

1. **Off-by-one on the loop condition**, especially `<=` vs `<` against an array's length — `for (int i = 0; i <= len; i++)` reads one element past the end of the array, which is undefined behavior (not a caught error).
2. **Computing `sizeof(arr) / sizeof(arr[0])` on a pointer instead of an actual array.** This idiom only works on a real array in the scope where it's declared — once an array decays to a pointer (e.g. passed to a function), `sizeof` on the pointer just gives the pointer's size (8 bytes on a 64-bit platform), not the array's length; the length must be passed separately.
3. **Modifying the loop variable inside the loop body** in a way that interacts confusingly with the `for` loop's own increment — usually a sign the logic should be restructured rather than fighting the loop's control flow.
4. **Using `while (1) { ... if (cond) break; }`** when a `do...while (cond)` or a properly structured `while (cond)` expresses the same logic more directly — not wrong, but often a sign the natural loop condition wasn't identified.

## Exercise

Write `int first_even(const int *numbers, int len)` returning the first even number in the array, or `-1` if none, using a `for` loop over the array with its length passed explicitly.

Try it yourself first, then check [`solutions/exercise_1.c`](./solutions/exercise_1.c).

## Interview questions

1. **Why does C require the array length to be passed alongside the pointer in a function parameter, instead of the array "knowing" its own length?** — An array passed to a function decays to a pointer to its first element — the pointer carries no length information at all, so the function has no way to know how many elements follow unless the caller tells it explicitly (via a length parameter, or a sentinel value like a null terminator for strings).
2. **What's the difference between `while` and `do...while`?** — `while` checks the condition before the first iteration (may run zero times); `do...while` checks after the first iteration (always runs at least once) — useful when the loop body must execute before there's anything meaningful to check.

---
← [Previous: Conditionals](../04_conditions/README.md) | [Next: Functions →](../06_functions/README.md)
