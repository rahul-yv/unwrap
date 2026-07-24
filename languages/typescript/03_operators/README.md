# Operators

Runtime operators are the same as JavaScript's (see the JavaScript track's `03_operators` for `??`, `?.`, spread/rest). TypeScript adds compile-time-only operators: type guards for narrowing a union, `as` for type assertions, the non-null assertion `!`, and `satisfies` for checking a value against a type without widening its inferred type.

## Example

```typescript
function printLength(value: string | string[]): number {
  if (typeof value === "string") {
    return value.length;       // narrowed to string here
  }
  return value.length;          // narrowed to string[] here
}

const input = document.getElementById("app") as HTMLElement; // type assertion — no runtime check
const maybeUser: { name: string } | undefined = { name: "Ada" };
const name = maybeUser!.name;   // non-null assertion: "trust me, this isn't undefined"

const config = { mode: "dark" } satisfies { mode: "dark" | "light" };
// config.mode is still inferred as "dark" (the literal), not widened to "dark" | "light"
```

See [`example.ts`](./example.ts) for the full runnable file.

## Common mistakes

1. **Using `as` to force a type past a real mismatch** instead of fixing the underlying issue. `as` doesn't check anything at runtime or compile time beyond "is this plausible" — it can hide genuine bugs (`value as unknown as Foo` compiles even when clearly wrong).
2. **Reaching for the non-null assertion `!`** as a quick fix for a strict-null-checks error, without being sure the value truly can't be `null`/`undefined` at that point — if the assumption is wrong, it fails at runtime with no compile-time warning, the opposite of what type-checking is for.
3. **Confusing `as SomeType` (assertion, unchecked) with `satisfies SomeType` (validated, but keeps the narrower inferred type).** `satisfies` catches mismatches at compile time and preserves literal types for later use; `as` does neither.
4. **Narrowing with `typeof` on values that aren't primitives**, e.g. `typeof value === "object"` doesn't distinguish `null`, arrays, or different object shapes — combine with `Array.isArray()`, `in`, or a discriminant property for real object unions.

## Exercise

Write `getLength(value: string | number[]): number` that uses a `typeof` type guard to return `.length` for a string or an array, without using `as`.

Try it yourself first, then check [`solutions/exercise_1.ts`](./solutions/exercise_1.ts).

## Interview questions

1. **Does `as` perform any runtime check?** — No — it's purely a compile-time instruction telling the type checker to treat a value as a different (compatible-looking) type; it can't change or validate the actual runtime value.
2. **What does `satisfies` give you that a type annotation doesn't?** — It validates the value against the type (compile error on mismatch) while keeping the more specific inferred (often literal) type for the variable, rather than widening it to the annotated type.

---
← [Previous: Data Types](../02_datatypes/README.md) | [Next: Conditionals →](../04_conditions/README.md)
