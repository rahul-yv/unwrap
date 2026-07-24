# Data Types

C's basic types (`char`, `int`, `float`, `double`, plus `short`/`long`/`long long` modifiers) have sizes that are only loosely guaranteed by the standard (`int` is *at least* 16 bits, in practice almost always 32 on modern platforms — but "in practice" isn't a guarantee). For a specific, portable size, use the fixed-width types from `<stdint.h>` (`int32_t`, `uint64_t`, ...). Signed integer overflow is undefined behavior; unsigned integer overflow is well-defined (wraps around modulo 2ⁿ).

## Example

```c
#include <stdint.h>

int n = 10;                 // "at least 16 bits," typically 32 on modern platforms
int32_t exact = 10;          // guaranteed exactly 32 bits, on any platform
uint8_t byte = 255;

printf("%zu\n", sizeof(int));  // size in bytes, platform-dependent but typically 4

unsigned int u = 0;
u = u - 1;                    // well-defined: wraps to UINT_MAX

int overflowed = INT_MAX;
// overflowed + 1;             // undefined behavior — don't rely on this wrapping
```

See [`example.c`](./example.c) for the full runnable file.

## Common mistakes

1. **Assuming `int` is always exactly 32 bits.** The C standard only guarantees *at least* 16 bits; it happens to be 32 on essentially all modern desktop/server platforms, but code that needs a guaranteed size should use `<stdint.h>`'s fixed-width types instead of relying on convention.
2. **Relying on signed integer overflow wrapping around.** Unlike unsigned overflow (well-defined modulo wraparound), signed overflow is undefined behavior — a compiler is allowed to assume it never happens and optimize accordingly, which can produce surprising results, not just "wraps like unsigned would."
3. **Using `%d` to print an `unsigned int` (or vice versa) in `printf`.** Mismatched format specifiers are undefined behavior — `%u` for `unsigned int`, `%d`/`%i` for `int`, `%zu` for `size_t`, etc.; modern compilers warn about this with `-Wformat` (part of `-Wall`).
4. **Comparing a signed and unsigned integer directly**, e.g. `int x = -1; unsigned int y = 0; if (x < y)` — `x` gets implicitly converted to `unsigned`, becoming a huge positive number, so the comparison doesn't do what it looks like; `-Wall`/`-Wextra` flags this as a sign-compare warning.

## Exercise

Write `int32_t safe_add(int32_t a, int32_t b, int *overflowed)` that adds `a` and `b`, setting `*overflowed` to `1` if the result would overflow `int32_t` (check before adding, using the range of `int32_t` — don't rely on actually overflowing), otherwise `0`.

Try it yourself first, then check [`solutions/exercise_1.c`](./solutions/exercise_1.c).

## Interview questions

1. **Why is signed integer overflow undefined behavior in C, while unsigned overflow is well-defined?** — The C standard permits signed integer representations other than two's complement (historically) and reserves the freedom for compilers to optimize assuming overflow never happens; unsigned arithmetic is explicitly specified to wrap modulo 2ⁿ, giving it defined, portable behavior.
2. **Why prefer `<stdint.h>` types over plain `int`/`long` when exact size matters?** — Plain types' sizes are only loosely constrained by the standard and vary by platform/compiler; `int32_t`, `uint64_t`, etc. guarantee an exact bit width everywhere they're supported, which matters for binary file formats, network protocols, or any code whose correctness depends on a specific size.

---
← [Previous: Variables](../01_variables/README.md) | [Next: Operators →](../03_operators/README.md)
