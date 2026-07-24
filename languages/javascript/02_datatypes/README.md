# Data Types

JavaScript has one numeric type for both integers and floats (`number`, a 64-bit float — plus `bigint` for arbitrary-precision integers), `string`, `boolean`, `undefined` (a declared-but-unassigned variable), `null` (an explicit "no value"), `object`, and `symbol`. `typeof` inspects the runtime type, with one famous historical quirk.

## Example

```javascript
const n = 10;              // number
const big = 10n;            // bigint
const s = "Ada";            // string
const ok = true;            // boolean
let nothing;                 // undefined
const empty = null;          // null, explicit "no value"

typeof n;        // "number"
typeof s;        // "string"
typeof nothing;  // "undefined"
typeof empty;    // "object" — a long-standing JS bug, kept for compatibility
```

See [`example.js`](./example.js) for the full runnable file.

## Common mistakes

1. **Using `==` instead of `===`.** `==` performs type coercion before comparing (`"5" == 5` is `true`), which produces surprising results. Use `===`/`!==` (strict equality) unless you specifically want coercion.
2. **Treating `null` and `undefined` as interchangeable.** `undefined` means "never assigned"; `null` means "explicitly set to nothing." `null == undefined` is `true` (loose), but `null === undefined` is `false`.
3. **Relying on `typeof x === "object"` to detect `null`.** `typeof null` is `"object"` — always check `x === null` explicitly first.
4. **Floating-point comparison with `===`.** Same underlying issue as other languages: `0.1 + 0.2 === 0.3` is `false`. Compare with a tolerance for float math.

## Exercise

Write `describe(value)` returning `"number"`, `"string"`, `"boolean"`, `"null"`, or `"undefined"` describing `value`'s type, correctly distinguishing `null` from `"object"`.

Try it yourself first, then check [`solutions/exercise_1.js`](./solutions/exercise_1.js).

## Interview questions

1. **Why is `typeof null === "object"`?** — A bug from the first JavaScript implementation (values were tagged, and the tag for `null` collided with the object tag); kept ever since for backward compatibility.
2. **What's the difference between `==` and `===`?** — `==` coerces operands to a common type before comparing; `===` compares both value and type with no coercion.

---
← [Previous: Variables](../01_variables/README.md) | [Next: Operators →](../03_operators/README.md)
