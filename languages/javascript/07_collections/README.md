# Collections

JavaScript's built-in collections: `Array` (ordered, mutable, rich method set), plain `Object` (string/symbol-keyed), `Map` (any key type, preserves insertion order, has `.size`), and `Set` (unique values, insertion-ordered). `Map`/`Set` were added specifically to fix `Object`'s awkwardness as a general-purpose dictionary (string-only keys, prototype pollution risk, no `.size`).

## Example

```javascript
const nums = [1, 2, 3, 4, 5];
const squares = nums.map((n) => n * n);
const evens = nums.filter((n) => n % 2 === 0);
const sum = nums.reduce((acc, n) => acc + n, 0);

const m = new Map();
m.set("a", 1);
m.get("a");        // 1
m.get("missing");  // undefined, no error

const s = new Set([1, 2, 2, 3]);
s.size;             // 3 — duplicates collapsed
```

See [`example.js`](./example.js) for the full runnable file.

## Common mistakes

1. **Using a plain `Object` as a general dictionary with untrusted string keys.** A key like `"__proto__"` can interact with the object's prototype chain in surprising ways. `Map` doesn't have this problem and is the safer choice for a dynamic key/value store.
2. **Forgetting array methods like `.map`/`.filter` return a new array** and don't mutate the original — but methods like `.push`/`.sort`/`.splice` *do* mutate in place. Know which category a method falls into before relying on either behavior.
3. **Using `.forEach` when you need the transformed result.** `.forEach` returns `undefined`; use `.map` when you want a new array back.
4. **Checking `array.indexOf(x) !== -1` for membership** when `array.includes(x)` says the same thing more directly (and correctly handles `NaN`, which `indexOf` cannot find).

## Exercise

Write `wordCounts(words)` returning a `Map` from each word to its occurrence count, using `Map`/`.reduce` — not a plain object.

Try it yourself first, then check [`solutions/exercise_1.js`](./solutions/exercise_1.js).

## Interview questions

1. **When would you choose `Map` over a plain object?** — When keys aren't simple strings, when insertion order matters and must be guaranteed, when you need `.size`, or when keys come from untrusted input (avoiding prototype-pollution-adjacent bugs).
2. **What's the time complexity of `Array.prototype.includes` vs `Set.prototype.has`?** — O(n) linear scan for an array; O(1) average for a `Set`'s hash-based lookup — prefer `Set` for repeated membership checks on non-trivial data.

---
← [Previous: Functions](../06_functions/README.md) | [Next: OOP →](../08_oop/README.md)
