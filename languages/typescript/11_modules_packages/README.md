# Modules and Packages

TypeScript uses standard ES module syntax (`import`/`export`), transpiled to whatever module system the `tsconfig.json` target specifies (CommonJS, ESM, etc.) — the source syntax is the same either way. TypeScript adds `import type`/`export type`: an import that's guaranteed to be erased at compile time, since it only exists for type-checking and has no runtime representation.

## Example

```typescript
// mypackage/helpers.ts
export interface Greeting {
  message: string;
}

export function greet(name: string): Greeting {
  return { message: `Hello, ${name}!` };
}
```

```typescript
// using it
import { greet } from "./mypackage/helpers";
import type { Greeting } from "./mypackage/helpers"; // erased entirely at compile time

const result: Greeting = greet("Ada");
```

See [`example.ts`](./example.ts) and [`mypackage/`](./mypackage/) for the full runnable files.

## Common mistakes

1. **Importing a type with a regular `import` when `import type` would be clearer and safer.** A regular `import { Greeting }` for a type-only usage still compiles fine (TypeScript elides unused-as-value imports automatically in most configs), but `import type` makes the intent explicit and guarantees no runtime import happens even if a bundler's tree-shaking doesn't catch it.
2. **Creating circular imports between modules that both need each other's types.** Runtime circular imports can cause real problems (partially-initialized modules); circular *type-only* imports (`import type`) are safe since they vanish before runtime entirely.
3. **Not re-exporting types alongside the values that use them** from a package's main entry point, forcing consumers to dig into internal file paths to import a type they need.
4. **Wildcard `import * as helpers`** used just to grab one or two named exports — obscures which names actually came from where, same downside as in plain JavaScript.

## Exercise

Using `mypackage/helpers.ts`'s `greet(name: string): Greeting`, write `exampleUsage(): string` that imports `greet` (and the `Greeting` type, via `import type`) and returns `greet("World").message`.

Try it yourself first, then check [`solutions/exercise_1.ts`](./solutions/exercise_1.ts).

## Interview questions

1. **What does `import type` guarantee that a regular `import` doesn't?** — That the import is erased entirely at compile time with no runtime trace, even in edge cases (like re-exports) where a bundler might otherwise struggle to prove an import is unused at the value level.
2. **Is a circular import between two `.ts` files always a problem?** — Only if it involves runtime values; circular imports of only types are completely safe since types don't exist after compilation — the risk is specific to circular value (function/class/variable) imports.

---
← [Previous: Files and I/O](../10_files/README.md) | [Next: Testing →](../12_testing/README.md)
