# Data Types

The runtime values are the same as JavaScript's (see the JavaScript track's `02_datatypes` for `number`/`string`/`boolean`/etc.). What TypeScript adds is a compile-time type system on top: `interface`/`type` for shaping objects, tuples for fixed-length arrays with per-position types, literal types for exact values, and `enum` for named constants.

## Example

```typescript
interface User {
  id: number;
  name: string;
  email?: string;   // optional property
}

type Status = "pending" | "active" | "closed";   // union of string literals

const coordinates: [number, number] = [3, 4];     // tuple: exactly two numbers

enum Direction {
  Up,
  Down,
  Left,
  Right,
}

function describe(status: Status): string {
  return `status is ${status}`;
}
```

See [`example.ts`](./example.ts) for the full runnable file.

## Common mistakes

1. **Reaching for `enum` by default** when a union of string literals (`type Status = "pending" | "active"`) is usually simpler, has zero runtime footprint (pure `type`, erased at compile time — plain `enum` emits actual runtime code), and works better with plain JSON data.
2. **Using `interface` and `type` inconsistently across a codebase** without a reason — both can shape objects; `interface` supports declaration merging and is conventional for public object shapes, `type` is required for unions/tuples/mapped types. Pick a convention and stay consistent within a project.
3. **Marking a property optional (`email?:`) when it should always be present but nullable.** `email?: string` means the property can be *missing entirely*; `email: string | null` means it's always present but might be `null`. These communicate different contracts.
4. **Widening a tuple to a plain array by not annotating it.** `const point = [3, 4]` infers as `number[]` (any length), not `[number, number]` — annotate explicitly when you need the fixed-length guarantee.

## Exercise

Define an interface `Point` with `x: number` and `y: number`, and write `distance(a: Point, b: Point): number` computing the Euclidean distance between them.

Try it yourself first, then check [`solutions/exercise_1.ts`](./solutions/exercise_1.ts).

## Interview questions

1. **`interface` vs `type` — when does it actually matter which you use?** — `type` is required for unions, tuples, and mapped/conditional types; `interface` supports declaration merging (multiple `interface Foo` blocks combine) which `type` doesn't. For a plain object shape, either works — most teams pick one as a convention.
2. **Why might you prefer a string literal union over an `enum`?** — String literal unions are erased at compile time (zero runtime code), serialize naturally to/from JSON, and are simpler to reason about; numeric `enum`s emit a runtime object and can have surprising reverse-mapping behavior.

---
← [Previous: Variables](../01_variables/README.md) | [Next: Operators →](../03_operators/README.md)
