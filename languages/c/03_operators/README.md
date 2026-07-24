# Operators

Beyond the usual arithmetic/comparison/logical operators, C has bitwise operators (`& | ^ ~ << >>`) used pervasively for flags and low-level manipulation, the ternary `?:`, and pointer operators (`&` address-of, `*` dereference). A classic C gotcha: modifying the same variable more than once between "sequence points" (roughly, statement boundaries) without a defined order is undefined behavior — not just "compiler-dependent," genuinely unspecified.

## Example

```c
int a = 6, b = 3;             // 0b0110, 0b0011
int and = a & b;               // 0b0010 = 2
int or = a | b;                 // 0b0111 = 7
int xor = a ^ b;                 // 0b0101 = 5
int left_shift = a << 1;          // 0b1100 = 12

int max = (a > b) ? a : b;         // ternary

int i = 0;
int result = i++ + i++;              // undefined behavior: don't do this
```

See [`example.c`](./example.c) for the full runnable file.

## Common mistakes

1. **Writing `i++ + i++` (or any expression that modifies the same variable twice with no sequence point between the modifications) and expecting a specific result.** This is undefined behavior in C — different compilers (or the same compiler at different optimization levels) can produce different results; never write code that depends on the order of side effects within a single expression like this.
2. **Confusing `&` (bitwise AND) with `&&` (logical AND)**, or `|` with `||` — a single-character typo that still compiles (since both are valid operators) but does something entirely different: bitwise operators work on individual bits, logical operators short-circuit and produce a boolean-ish `0`/`1`.
3. **Using `=` when `==` was meant** in a condition — `if (x = 5)` compiles (it assigns `5` to `x`, then tests the nonzero result as true) and is a classic C bug; `-Wall` warns about this (`-Wparentheses`), which is one more reason to always compile with warnings enabled.
4. **Assuming `<<`/`>>` on signed integers behaves consistently.** Left-shifting a negative number, or shifting by more than the type's width, is undefined behavior — bit-shifting tricks should generally use unsigned types.

## Exercise

Write `int is_power_of_two(unsigned int n)` returning `1` if `n` is a power of two (and nonzero), `0` otherwise, using the bit trick `n & (n - 1)`.

Try it yourself first, then check [`solutions/exercise_1.c`](./solutions/exercise_1.c).

## Interview questions

1. **Why is `i++ + i++` undefined behavior in C?** — The C standard doesn't define the order of side effects (the increments) relative to each other when there's no intervening sequence point — different compilers can legally evaluate this differently, so no "correct" answer exists to reason about; the fix is to never write expressions that modify the same variable more than once without an intervening sequence point.
2. **How does the bit trick `n & (n - 1)` detect a power of two?** — For a power of two, exactly one bit is set (e.g. `1000`); subtracting 1 flips that bit and sets all lower bits (`0111`), so ANDing the two gives `0` — this only happens for powers of two (and, as an edge case, for `0`, which must be excluded separately).

---
← [Previous: Data Types](../02_datatypes/README.md) | [Next: Conditionals →](../04_conditions/README.md)
