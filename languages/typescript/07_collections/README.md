# Collections

Runtime behavior matches JavaScript's `Array`/`Map`/`Set` (see the JavaScript track's `07_collections`). TypeScript adds generic typing over them (`Array<T>`/`T[]`, `Map<K, V>`, `Set<T>`) plus `readonly` arrays/tuples that reject mutation at compile time — useful for signaling "this function won't modify what you pass in."

## Example

```typescript
const nums: number[] = [1, 2, 3, 4, 5];
const squares: number[] = nums.map((n) => n * n);   // map's return type is inferred as number[]

const scores: Map<string, number> = new Map([["a", 1]]);
const unique: Set<number> = new Set([1, 2, 2, 3]);

function sumReadonly(values: readonly number[]): number {
	// values.push(1);   // compile error: push doesn't exist on readonly number[]
	return values.reduce((acc, n) => acc + n, 0);
}

const frozenPoint: readonly [number, number] = [3, 4];
```

See [`example.ts`](./example.ts) for the full runnable file.

## Common mistakes

1. **Annotating a parameter as a mutable array (`number[]`) when the function has no business mutating it.** `readonly number[]` documents the contract and lets the compiler catch an accidental `.push()`/`.sort()` inside the function.
2. **Forgetting `readonly` is compile-time only.** `readonly number[]` doesn't freeze the array at runtime (unlike `Object.freeze`) — a caller who still has a reference typed as mutable `number[]` can still mutate the same underlying array; it only stops *this* function's code from doing so through this typed reference.
3. **Using a plain object (`{ [key: string]: number }`) where a `Map<string, number>` fits better** — `Map` has a real `.size`, preserves insertion order guaranteed, and avoids the string-coercion/prototype quirks of using an object as a dictionary.
4. **Widening a tuple return type by not annotating the function's return type**, e.g. a function meant to return `[string, number]` infers as `(string | number)[]` if not annotated, losing the fixed-position guarantee.

## Exercise

Write `wordCounts(words: string[]): Map<string, number>` returning a `Map` from each word to its occurrence count.

Try it yourself first, then check [`solutions/exercise_1.ts`](./solutions/exercise_1.ts).

## Interview questions

1. **Does `readonly number[]` prevent mutation at runtime?** — No — it's a compile-time-only restriction on what operations the type checker allows through that reference; the underlying array is an ordinary mutable JS array at runtime, and other references to it without the `readonly` type can still mutate it.
2. **Why prefer `Map<K, V>` over a plain object for a dynamic key/value store?** — Real `.size`, guaranteed insertion order, any key type (not just strings), and no risk of key collisions with inherited `Object.prototype` properties.

---
← [Previous: Functions](../06_functions/README.md) | [Next: OOP →](../08_oop/README.md)
