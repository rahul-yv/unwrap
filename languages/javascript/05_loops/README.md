# Loops

JavaScript has the classic C-style `for (;;)`, `while`, `do...while`, and two flavors built for iterables: `for...of` (values) and `for...in` (enumerable keys — usually the wrong choice for arrays).

## Example

```javascript
for (let i = 0; i < 3; i++) {
  console.log(i);            // 0, 1, 2
}

for (const item of ["a", "b", "c"]) {
  console.log(item);          // values
}

const arr = ["a", "b", "c"];
for (const index in arr) {
  console.log(index);         // "0", "1", "2" — strings, and iterates enumerable props
}

let n = 0;
while (n < 3) n++;
```

See [`example.js`](./example.js) for the full runnable file.

## Common mistakes

1. **Using `for...in` to iterate an array.** It iterates enumerable property *keys* as strings (including any inherited/added properties), not array values in guaranteed order — use `for...of` or `.forEach()`/`.map()` for arrays instead.
2. **Declaring the loop variable with `var` in a closure-creating loop.** `for (var i = 0; i < 3; i++) setTimeout(() => console.log(i))` logs `3, 3, 3` because `var` is function-scoped and shared; `let` creates a fresh binding per iteration, logging `0, 1, 2`.
3. **Mutating an array while iterating it with `for...of` or `.forEach()`**, causing skipped or repeated elements — iterate a copy (`[...arr]`) if you need to remove items during the loop.
4. **Off-by-one errors in a classic `for` loop** — double-check `<` vs `<=` against the intended range.

## Exercise

Write `firstEven(numbers)` that returns the first even number in an array, or `undefined` if there isn't one, using `for...of` with an early `return`.

Try it yourself first, then check [`solutions/exercise_1.js`](./solutions/exercise_1.js).

## Interview questions

1. **Why does a `var`-based loop log the same final value in every closure, while a `let`-based loop logs each iteration's value?** — `var` is function-scoped, so every closure captures the same single variable, which has finished looping by the time the closures run; `let` creates a new binding scoped to each iteration.
2. **When would you use `for...in` instead of `for...of`?** — Rarely for arrays; `for...in` is for enumerating an object's own (and inherited) enumerable property keys, not for iterating array/iterable values.

---
← [Previous: Conditionals](../04_conditions/README.md) | [Next: Functions →](../06_functions/README.md)
