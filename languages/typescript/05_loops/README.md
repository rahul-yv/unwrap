# Loops

Loop syntax is identical to JavaScript's (see the JavaScript track's `05_loops`). What TypeScript adds is that the loop variable's type flows from the collection: `for (const x of numbers)` infers `x: number` from `numbers: number[]`, and the compiler will reject operations on `x` that don't make sense for that type — this catches a whole class of bugs at compile time that JavaScript would only surface at runtime.

## Example

```typescript
const numbers: number[] = [1, 2, 3];
let total = 0;
for (const n of numbers) {
  total += n;    // n is typed as number — total += "x" would be a compile error
}

const entries = new Map<string, number>([["a", 1], ["b", 2]]);
for (const [key, value] of entries) {
  console.log(key, value);   // key: string, value: number — inferred from the Map's type
}
```

See [`example.ts`](./example.ts) for the full runnable file.

## Common mistakes

1. **Widening an array's type unintentionally**, e.g. `const items = []` infers `any[]` without `noImplicitAny`-safe context, silently losing type checking inside the loop — annotate empty arrays explicitly (`const items: number[] = []`) when the type can't be inferred from usage.
2. **Iterating a `Record<string, T>`/plain object with `for...in` expecting typed values.** `for (const key in obj)` types `key` as `string`, not as `keyof typeof obj`, and doesn't narrow `obj[key]` — use `Object.entries(obj)` or `for...of Object.keys(obj) as (keyof typeof obj)[]` when precise typing matters.
3. **Assuming array index access is always defined.** With `strict` mode (specifically `noUncheckedIndexedAccess`, if enabled) `numbers[i]` is typed `number | undefined`, catching an out-of-bounds read at compile time that plain JavaScript would only surface as `undefined` at runtime.

## Exercise

Write `sumEven(numbers: number[]): number` that sums only the even numbers in the array, using `for...of`.

Try it yourself first, then check [`solutions/exercise_1.ts`](./solutions/exercise_1.ts).

## Interview questions

1. **How does TypeScript infer the loop variable's type in `for (const x of collection)`?** — From the collection's element type: `T[]` gives `x: T`, `Map<K, V>` gives `[K, V]` pairs, `Set<T>` gives `x: T`, and any custom iterable's declared `Iterator<T>` return type.
2. **Why might `noUncheckedIndexedAccess` change how you write loop bodies?** — Without it, `arr[i]` is typed as the element type even for out-of-bounds indices (silently `undefined` at runtime); with it enabled, `arr[i]` is typed `T | undefined`, forcing an explicit check before use.

---
← [Previous: Conditionals](../04_conditions/README.md) | [Next: Functions →](../06_functions/README.md)
