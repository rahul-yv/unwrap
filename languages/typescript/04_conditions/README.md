# Conditionals

`if`/`else`/ternary/`switch` work exactly as in JavaScript (see the JavaScript track's `04_conditions`). TypeScript's distinctive addition is **discriminated unions**: a union of object types sharing a common literal-typed field (the "discriminant"), which `switch`/`if` can narrow on — and the compiler can verify every case is handled.

## Example

```typescript
interface Circle {
  kind: "circle";
  radius: number;
}
interface Square {
  kind: "square";
  side: number;
}
type Shape = Circle | Square;

function area(shape: Shape): number {
  switch (shape.kind) {
    case "circle":
      return Math.PI * shape.radius ** 2;   // narrowed to Circle here
    case "square":
      return shape.side ** 2;                // narrowed to Square here
    default: {
      const exhaustive: never = shape;       // compile error if a case is missing
      throw new Error(`unhandled shape: ${exhaustive}`);
    }
  }
}
```

See [`example.ts`](./example.ts) for the full runnable file.

## Common mistakes

1. **Adding a new variant to a discriminated union without a `default: never` check** in every `switch` over it — without that, the compiler won't warn you about unhandled new cases, and the omission becomes a runtime bug instead of a compile error.
2. **Narrowing on a non-literal field.** The discriminant must be a literal type (a string/number/boolean literal, not a general `string`) for the compiler to narrow correctly — `kind: string` doesn't let TypeScript distinguish variants.
3. **Using `any` in the default branch** instead of `never`, silently losing the exhaustiveness check that's the entire point of the pattern.
4. **Forgetting each `case` needs its own block scope (`{ }`)** when declaring a `const`/`let` inside it — without braces, a `case` further down in the same `switch` can't redeclare the same name, causing a compile error.

## Exercise

Add a `Triangle` variant (`{ kind: "triangle"; base: number; height: number }`) to the `Shape` union and update `area` to handle it, keeping the exhaustiveness (`never`) check intact.

Try it yourself first, then check [`solutions/exercise_1.ts`](./solutions/exercise_1.ts).

## Interview questions

1. **What is a discriminated union, and why is the discriminant field required to be a literal type?** — A union of object types sharing a common field with distinct literal values (the discriminant); because it's a literal (not a general `string`/`number`), the compiler can narrow the union to the exact variant based on a runtime check of that field.
2. **How does the `never`-typed default case catch missing cases at compile time?** — If every variant is handled, the value remaining in the `default` branch has type `never` (nothing left it could be); assigning it to a `never`-typed variable only compiles if that's true — adding a new unhandled variant makes the assignment a type error, catching the gap before runtime.

---
← [Previous: Operators](../03_operators/README.md) | [Next: Loops →](../05_loops/README.md)
