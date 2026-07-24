# Modules and Packages

Modern JavaScript uses ES Modules (`import`/`export`) — the standard used in browsers and bundlers. Node also supports the older CommonJS system (`require`/`module.exports`), which is still common in existing codebases and simpler for quick scripts. A file is treated as ESM if it ends in `.mjs` (or `.js` with `"type": "module"` in `package.json`); CommonJS otherwise.

## Example

```javascript
// mypackage/helpers.mjs
export function greet(name) {
  return `Hello, ${name}!`;
}
```

```javascript
// using it (ESM)
import { greet } from "./mypackage/helpers.mjs";
greet("Ada");   // "Hello, Ada!"
```

```javascript
// the CommonJS equivalent, still common in existing Node code
// helpers.js
function greet(name) { return `Hello, ${name}!`; }
module.exports = { greet };

// using it
const { greet } = require("./helpers.js");
```

See [`example.mjs`](./example.mjs) and [`mypackage/`](./mypackage/) for the full runnable ESM files.

## Common mistakes

1. **Mixing `require` and `import` in the same file** — they belong to different module systems and generally can't be combined directly; pick one per file (or per project) rather than switching mid-file.
2. **Wildcard-style `import * as everything`** used just to grab one or two names — same downside as Python's `from module import *`: it obscures which names actually came from where.
3. **Forgetting a default export vs. named exports are imported differently.** `export default function greet() {}` is imported as `import greet from "./file.mjs"` (no braces); `export function greet() {}` is imported as `import { greet } from "./file.mjs"` (with braces). Mixing these up is a very common early mistake.
4. **Circular imports** between ES modules — same problem as any language: module A importing from B which imports from A can leave one side with an incomplete/undefined binding depending on evaluation order.

## Exercise

Using `mypackage/helpers.mjs`'s `greet(name)`, write `exampleUsage()` in `solutions/exercise_1.mjs` that imports `greet` by name and returns `greet("World")`.

Try it yourself first, then check [`solutions/exercise_1.mjs`](./solutions/exercise_1.mjs).

## Interview questions

1. **What's the practical difference between CommonJS and ES Modules in Node?** — CommonJS (`require`) loads synchronously and resolves modules at call time; ES Modules (`import`) are statically analyzed (imports resolved before execution), enabling tree-shaking by bundlers and top-level `await`.
2. **Default export vs. named export — when would you use each?** — A default export suits a module with one primary thing to export (e.g. a single class/component); named exports suit a module offering several related, individually-importable utilities.

---
← [Previous: Files and I/O](../10_files/README.md) | [Next: Testing →](../12_testing/README.md)
