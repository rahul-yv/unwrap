# Functions

C passes every argument by value — a function receives a *copy*, and can never modify the caller's variable directly. To let a function modify the caller's data, pass a pointer explicitly (the function then dereferences it). C has no function overloading, no default parameters, and no closures — but it does have function pointers, which let you pass a function as a value and are the mechanism behind callbacks. `static` on a function restricts it to the current file (internal linkage) — C's rough equivalent of "private."

## Example

```c
void increment(int x) {
	x = x + 1;   // modifies the local copy only
}

void increment_via_pointer(int *x) {
	*x = *x + 1;   // modifies the caller's variable through the pointer
}

int add(int a, int b) { return a + b; }
int multiply(int a, int b) { return a * b; }

int apply(int (*op)(int, int), int a, int b) {   // function pointer parameter
	return op(a, b);
}

apply(add, 2, 3);        // 5
apply(multiply, 2, 3);    // 6

static int internal_helper(int x) { return x * 2; }   // only visible within this file
```

See [`example.c`](./example.c) for the full runnable file.

## Common mistakes

1. **Expecting a function to modify its argument when it was passed by value.** `void increment(int x)` can never change the caller's variable — only a pointer parameter (`int *x`, dereferenced with `*x = ...`) can.
2. **Returning a pointer to a local (stack) variable.** Once the function returns, that stack memory is no longer valid — the returned pointer dangles, and using it is undefined behavior. Return by value, or have the caller pass in memory to write into, or allocate on the heap (and document who's responsible for freeing it).
3. **Misreading a function pointer declaration.** `int (*op)(int, int)` is "a pointer to a function taking two ints and returning int" — the parentheses around `*op` are required; `int *op(int, int)` means something entirely different (a function returning `int *`).
4. **Forgetting recursive functions need a correct base case reachable from every recursive call** — same as any language, but C gives you no stack-overflow-friendly error message beyond a crash, since there's no runtime to catch it gracefully.

## Exercise

Write `int apply_twice(int (*fn)(int), int x)` that calls `fn` on `x` twice, returning `fn(fn(x))`.

Try it yourself first, then check [`solutions/exercise_1.c`](./solutions/exercise_1.c).

## Interview questions

1. **Why does C need pointers to implement "output parameters" or "pass by reference"?** — Every argument in C is passed by value (a copy); the only way for a function to affect the caller's actual variable is to receive its address (a pointer) and write through it — there's no reference-parameter syntax like some other languages provide.
2. **What's the danger of returning a pointer to a local variable?** — The local variable's stack memory is reclaimed the moment the function returns; the returned pointer points at memory that may be immediately overwritten by whatever runs next, making any use of it undefined behavior.

---
← [Previous: Loops](../05_loops/README.md) | Next: Collections (coming soon)
