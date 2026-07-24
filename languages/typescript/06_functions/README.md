# Functions

Function syntax matches JavaScript's (see the JavaScript track's `06_functions` for closures, defaults, rest params). TypeScript adds parameter/return type annotations, function overloads, and generics — a function whose types adapt to whatever type it's called with, while still being checked.

## Example

```typescript
function greet(name: string, greeting: string = "Hello"): string {
  return `${greeting}, ${name}!`;
}

function identity<T>(value: T): T {
  return value;
}

identity<number>(5);      // T = number, explicit
identity("hello");         // T = string, inferred from the argument

// overloads: different call shapes, one implementation
function parseInput(value: string): number;
function parseInput(value: number): number;
function parseInput(value: string | number): number {
  return typeof value === "string" ? parseInt(value, 10) : value;
}
```

See [`example.ts`](./example.ts) for the full runnable file.

## Common mistakes

1. **Typing a parameter as `any` to avoid writing the real type** — defeats the purpose of using TypeScript for that parameter; use `unknown` plus narrowing, or take the time to write the actual union/generic type.
2. **Writing a generic function without actually using the type parameter meaningfully** — `function wrap<T>(value: T): T[] { return [value] }` is a genuine use of `T` (return type depends on input type); `function log<T>(value: T): void { console.log(value) }` gains nothing from being generic since `T` is never used in a way that connects input and output.
3. **Forgetting that TypeScript function overloads need a single, more general implementation signature** that's compatible with every overload — the implementation signature itself isn't part of the public overload set.
4. **Not annotating a function's return type on public/exported functions.** Return type is usually inferable, but an explicit annotation catches the case where a future edit accidentally changes what's returned, turning a logic bug into a compile error at the definition site instead of a mismatch discovered elsewhere.

## Exercise

Write a generic function `firstOrDefault<T>(items: T[], defaultValue: T): T` that returns the first element of `items`, or `defaultValue` if the array is empty.

Try it yourself first, then check [`solutions/exercise_1.ts`](./solutions/exercise_1.ts).

## Interview questions

1. **What problem do generics solve that `any` doesn't?** — Generics preserve the relationship between input and output types (`identity<T>(value: T): T` guarantees the return type matches whatever was passed in), while `any` discards type information entirely, giving no compile-time guarantee about the return value's shape.
2. **How do function overloads differ from a single function with a union parameter type?** — Overloads let the return type depend on which specific input shape was passed (e.g. `string` in → `number` out via one overload, `Buffer` in → `string` out via another), which a single union-typed signature can't express as precisely.

---
← [Previous: Loops](../05_loops/README.md) | [Next: Collections →](../07_collections/README.md)
