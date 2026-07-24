# Operators

Beyond the usual arithmetic/comparison/logical operators, JavaScript has a few that solve specific real problems: the nullish coalescing operator `??` (fallback only for `null`/`undefined`, unlike `||`), optional chaining `?.` (safe property access on possibly-`null`/`undefined` values), and the spread/rest operator `...`.

## Example

```javascript
const count = 0;
count || 10;    // 10 — `||` falls back on ANY falsy value, including 0
count ?? 10;    // 0  — `??` only falls back on null/undefined

const user = { profile: null };
user.profile?.name;         // undefined, no TypeError

const nums = [1, 2, 3];
const more = [...nums, 4, 5];   // spread: [1, 2, 3, 4, 5]
const [first, ...rest] = more;  // rest: [2, 3, 4, 5]
```

See [`example.js`](./example.js) for the full runnable file.

## Common mistakes

1. **Using `||` for a default value when `0`, `""`, or `false` are valid inputs.** `count || 10` replaces a legitimate `0` with `10`. Use `??` when only `null`/`undefined` should trigger the fallback.
2. **Chaining property access without `?.` on data that might be missing**, causing a `TypeError: Cannot read properties of undefined`. `user.profile?.name` short-circuits to `undefined` instead of throwing.
3. **Confusing `??` with `||` as if they were interchangeable** — they behave identically only when the left side is never `0`/`""`/`false`.
4. **Mixing `??` directly with `||`/`&&` without parentheses** — `a || b ?? c` is a `SyntaxError`; JavaScript requires explicit parentheses to disambiguate.

## Exercise

Write `getPort(config)` that returns `config.port` if it's a number (including `0`), or `8080` as a default if `config.port` is `null`/`undefined`. Use `??`, not `||`.

Try it yourself first, then check [`solutions/exercise_1.js`](./solutions/exercise_1.js).

## Interview questions

1. **What's the difference between `??` and `||`?** — `||` falls back on any falsy value (`0`, `""`, `false`, `NaN`, `null`, `undefined`); `??` falls back only on `null`/`undefined`, leaving other falsy values intact.
2. **What does `?.` do, and why is it useful?** — Optional chaining: returns `undefined` instead of throwing if the object before it is `null`/`undefined`, avoiding manual `&&`-chained existence checks before deep property access.

---
← [Previous: Data Types](../02_datatypes/README.md) | [Next: Conditionals →](../04_conditions/README.md)
