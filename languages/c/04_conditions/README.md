# Conditionals

C has `if`/`else if`/`else`, the ternary `?:`, and `switch` (fall-through by default, like most C-family languages — `break` is required to prevent it). Before C99/C23, there was no `bool` type — `0` is false, any nonzero value is true; `<stdbool.h>` (C99+) adds `bool`/`true`/`false` as more readable aliases over the same underlying `int`-based truthiness.

## Example

```c
#include <stdbool.h>

int score = 85;
char grade;
if (score >= 90) {
	grade = 'A';
} else if (score >= 80) {
	grade = 'B';
} else {
	grade = 'C';
}

bool passed = score >= 60;   // stdbool.h: true/false, still just 0/1 underneath

switch (grade) {
	case 'A':
	case 'B':
		printf("good\n");
		break;
	default:
		printf("needs improvement\n");
}
```

See [`example.c`](./example.c) for the full runnable file.

## Common mistakes

1. **Forgetting `break` in a `switch` case**, falling through into the next case unintentionally — same classic bug as other C-family languages (JavaScript, Java, C#) that inherited `switch` from C.
2. **Testing floating-point equality with `==`** (`if (x == 0.3)`), hitting the same binary floating-point precision issue as every language — compare with a tolerance instead (`fabs(x - 0.3) < epsilon`).
3. **Forgetting `<stdbool.h>` is needed for `bool`/`true`/`false`** in C (unlike C++, where they're built-in keywords) — without it, code written assuming `bool` exists won't compile in strict C mode.
4. **Assigning instead of comparing in a condition** (`if (x = 0)`) — covered in `03_operators`, but it bears repeating since it's specifically dangerous in `if` conditions: the condition silently becomes "was the assignment's result nonzero," not "does x equal this value."

## Exercise

Write `char grade(int score)` returning `'A'` for `score >= 90`, `'B'` for `>= 80`, `'C'` for `>= 70`, `'F'` otherwise.

Try it yourself first, then check [`solutions/exercise_1.c`](./solutions/exercise_1.c).

## Interview questions

1. **Does C's `switch` fall through by default?** — Yes — the opposite of some newer languages; each `case` executes until it hits a `break` (or the end of the `switch`), so falling into the next case is the default unless explicitly prevented.
2. **What counts as "true" in a C condition, before or without `<stdbool.h>`?** — Any nonzero value is true, `0` is false — there's no distinct boolean type at the language's core; `bool` from `<stdbool.h>` (C99+) is essentially an `int`-based type restricted to `0`/`1`, added for readability, not a fundamentally different mechanism.

---
← [Previous: Operators](../03_operators/README.md) | [Next: Loops →](../05_loops/README.md)
