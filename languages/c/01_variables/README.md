# Variables

C is statically typed with no type inference (before C23's `auto`, and even then it's rarely used) — every variable's type is written explicitly. There's no runtime type information and no garbage collector: a variable's storage is either on the stack (local variables, freed automatically when the function returns) or the heap (via `malloc`, freed manually with `free` — covered in `07_collections`). Uninitialized local variables hold garbage, not a predictable zero value.

## Example

```c
int age = 25;
double pi = 3.14159;
char grade = 'A';

age = age + 1;

const int MAX_RETRIES = 3;   // const: the compiler rejects reassignment
// MAX_RETRIES = 4;            // compile error

int uninitialized;             // holds indeterminate garbage, not 0
```

See [`example.c`](./example.c) for the full runnable file.

## Common mistakes

1. **Assuming an uninitialized local variable is zero.** Unlike some languages that guarantee a "zero value," a plain `int x;` at function scope holds whatever bits were already in that stack memory — reading it before assignment is undefined behavior. Always initialize.
2. **Confusing `const int *p` (pointer to a const int — the int can't change through `p`) with `int * const p` (a const pointer to an int — `p` itself can't be reassigned, but `*p` can be modified).** This distinction trips up even experienced C programmers; read the declaration right-to-left from the variable name.
3. **Shadowing a variable in a nested block and not realizing the outer one is unaffected** once the block ends — C has block scope like most C-family languages, so this is more a "watch for accidental reuse of a name" issue than a language quirk, but worth being deliberate about.
4. **Forgetting integer literals default to `int`**, causing unexpected overflow or truncation in expressions mixing types — e.g. `long x = 100000 * 100000;` overflows during the `int * int` multiplication *before* the result is widened to `long`; write `100000L * 100000L` to force the wider type early.

## Exercise

Write a function `void swap(int *a, int *b)` that swaps the values pointed to by `a` and `b`, using pointers (C has no multiple-return-value syntax, so pointers are the idiomatic way to give a function "output parameters").

Try it yourself first, then check [`solutions/exercise_1.c`](./solutions/exercise_1.c).

## Interview questions

1. **Why does C require explicit type declarations for every variable?** — C has no runtime type system and performs no type inference (historically) — the compiler needs to know a variable's exact size and representation at compile time to generate correct machine code, with no fallback to a runtime type check.
2. **What happens if you read an uninitialized local variable?** — Undefined behavior — the C standard makes no guarantee about the value (it's typically leftover data from whatever previously used that stack memory), and depending on the compiler/optimization level, the behavior can even be "unpredictable across runs of the same binary."

---
← Previous: (start) | [Next: Data Types →](../02_datatypes/README.md)
