# Variables

TypeScript adds static types on top of JavaScript's `let`/`const`/`var`. Types are usually inferred, not required — write `const age = 25` and TypeScript infers `number` without an annotation. Annotations (`const age: number = 25`) matter most for function parameters/returns and for widening cases the compiler can't infer on its own.

## Example

```typescript
let age = 25;              // inferred as number
const name: string = "Ada"; // explicit annotation
age = age + 1;

const point = { x: 1, y: 2 };   // inferred as { x: number; y: number }
point.x = 10;                    // fine: const prevents rebinding, not mutation

let value: number | string = 5;  // union type: number OR string
value = "now a string";           // also fine
```

See [`example.ts`](./example.ts) for the full runnable file.

## Common mistakes

1. **Annotating every variable explicitly** (`const age: number = 25`) when TypeScript already infers it correctly — adds noise without adding safety. Let inference do the work; annotate where inference can't (function signatures, empty array/object literals, `any`-prone spots).
2. **Using `any` to silence a type error** instead of fixing the actual type mismatch. `any` opts a value out of type checking entirely — prefer `unknown` (forces a check before use) when the type genuinely isn't known yet.
3. **Assuming `const` gives immutability**, same trap as plain JavaScript — `const` prevents rebinding the variable, not mutating the object it points to. Use `readonly` (for object properties) or `as const` (for literals) for real immutability guarantees at the type level.
4. **Confusing a union type (`number | string`) with an intersection type (`A & B`).** Union means "one of these"; intersection means "has all of these" (mostly used to combine object types).

## Exercise

Write a function `swap<T>(pair: [T, T]): [T, T]` that returns the pair reversed, generic over the element type `T`.

Try it yourself first, then check [`solutions/exercise_1.ts`](./solutions/exercise_1.ts).

## Interview questions

1. **Does TypeScript add any runtime behavior over JavaScript?** — No — types are fully erased at compile time; the emitted JavaScript has no type information or runtime checks. TypeScript only catches mismatches during compilation.
2. **When would you use `unknown` instead of `any`?** — `unknown` still requires narrowing (a type check) before you can operate on the value, preserving type safety; `any` disables checking entirely and can propagate silently through the codebase.

---
← Previous: (start) | [Next: Data Types →](../02_datatypes/README.md)
