# Variables

JavaScript has three ways to declare a variable: `let` (block-scoped, reassignable), `const` (block-scoped, cannot be reassigned), and `var` (function-scoped, hoisted — legacy, avoid in new code). Prefer `const` by default, `let` only when the binding must change.

## Example

```javascript
let age = 25;
const name = "Ada";
age = age + 1;          // reassignment allowed

const point = { x: 1, y: 2 };
point.x = 10;            // allowed: const prevents reassigning the binding, not mutating the object

const [a, b] = [1, 2];   // array destructuring
const { x, y } = point;  // object destructuring
```

See [`example.js`](./example.js) for the full runnable file.

## Common mistakes

1. **Assuming `const` makes an object immutable.** `const` only prevents *reassigning the variable itself*; the object it points to can still be mutated. Use `Object.freeze()` for real immutability.
2. **Using `var` in new code.** `var` is function-scoped (not block-scoped) and hoisted with `undefined`, causing bugs like a loop variable leaking outside the loop or being shared unexpectedly across closures. Use `let`/`const`.
3. **Redeclaring a `let`/`const` in the same scope**, which throws a `SyntaxError` — unlike `var`, which silently allows redeclaration.
4. **Using a variable before its `let`/`const` declaration executes** — this throws a `ReferenceError` (the "temporal dead zone"), unlike `var`, which would silently be `undefined`.

## Exercise

Write a function `swap(pair)` that takes a two-element array `[a, b]` and returns `[b, a]` using array destructuring, not manual indexing.

Try it yourself first, then check [`solutions/exercise_1.js`](./solutions/exercise_1.js).

## Interview questions

1. **What's the difference between `let`, `const`, and `var`?** — Scope (block vs function), hoisting behavior, and whether reassignment is allowed; `const`/`let` are block-scoped and live in the temporal dead zone until declared, `var` is function-scoped and hoisted as `undefined`.
2. **Does `const` make an object immutable?** — No — it only prevents rebinding the variable name to a different value; the object's own properties remain mutable unless explicitly frozen.

---
← Previous: (start) | [Next: Data Types →](../02_datatypes/README.md)
