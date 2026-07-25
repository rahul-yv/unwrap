# Collections

C's only built-in collection is the array — fixed-size, contiguous, and (for a local array) stack-allocated. There's no growable array, hash map, or list in the language or a bundled standard library data structure — for anything that needs to grow at runtime, you manage heap memory yourself with `malloc`/`realloc`/`free` from `<stdlib.h>`. This is the central place C departs from every other language in this repo: memory management is manual, and getting it wrong is undefined behavior, not a caught exception.

## Example

```c
#include <stdlib.h>

int fixed[3] = {1, 2, 3};   // stack-allocated, fixed size, freed automatically

int *dynamic = malloc(3 * sizeof(int));   // heap-allocated, you own this memory
if (dynamic == NULL) {
	// malloc can fail — always check
}
dynamic[0] = 1;
dynamic[1] = 2;
dynamic[2] = 3;

int *grown = realloc(dynamic, 5 * sizeof(int));   // grow to 5 elements
if (grown == NULL) {
	// realloc failing does NOT free the original — don't lose the pointer
	free(dynamic);
} else {
	dynamic = grown;
}

free(dynamic);   // your responsibility — nothing frees this for you
```

See [`example.c`](./example.c) for the full runnable file.

## Common mistakes

1. **Forgetting to `free` heap memory** — a memory leak. Not a crash, just memory that's never returned to the system until the process exits; leaks accumulate in long-running programs.
2. **Using memory after `free`ing it ("use-after-free") or freeing the same pointer twice ("double-free").** Both are undefined behavior — the memory may already be reused for something else, corrupting unrelated data, or the allocator's internal bookkeeping may be corrupted outright.
3. **Not checking `malloc`/`realloc`'s return value for `NULL`.** Allocation can fail (out of memory); dereferencing a `NULL` pointer crashes immediately, but skipping the check means that crash happens at the *use* site, not the allocation site, making the actual cause harder to find.
4. **Reassigning the original pointer directly from `realloc`'s return value** (`ptr = realloc(ptr, newSize);`) — if `realloc` fails, it returns `NULL` *without freeing the original block*, so this overwrites your only reference to memory you still need to `free`. Assign to a temporary first, as shown above.

## Exercise

Write `int *make_range(int start, int end, int *out_len)` returning a heap-allocated array containing every integer from `start` to `end` inclusive, setting `*out_len` to the array's length. The caller is responsible for `free`ing the result.

Try it yourself first, then check [`solutions/exercise_1.c`](./solutions/exercise_1.c).

## Interview questions

1. **What's the difference between a memory leak and a dangling pointer?** — A leak is memory that's still allocated but no longer reachable (no pointer to it remains, so it can never be freed); a dangling pointer is a pointer that still points at memory that's already been freed (or otherwise invalidated) — using it is undefined behavior, unlike a leak, which just wastes memory.
2. **Why must `realloc`'s result be assigned to a different variable before overwriting the original pointer?** — If `realloc` fails, it returns `NULL` and leaves the original block untouched and still valid; overwriting the original pointer variable directly with that `NULL` loses the only reference to the still-allocated original memory, making it an unrecoverable leak.

---
← [Previous: Functions](../06_functions/README.md) | [Next: OOP →](../08_oop/README.md)
