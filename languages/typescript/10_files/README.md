# Files and I/O

Runtime behavior matches Node's `fs/promises` API from the JavaScript track's `10_files`. TypeScript's `@types/node` gives `fs` functions precise overloaded types: `readFile(path, "utf8")` types the result as `string`, while `readFile(path)` (no encoding) types it as `Buffer` — the type follows which overload matches your call, catching a missed encoding argument at compile time instead of at runtime when string methods fail on a `Buffer`.

## Example

```typescript
import fs from "node:fs/promises";

async function readNotes(path: string): Promise<string[]> {
	const content: string = await fs.readFile(path, "utf8"); // string, because of "utf8"
	return content.split("\n").filter((line) => line.length > 0);
}

async function readRaw(path: string): Promise<Buffer> {
	return fs.readFile(path); // Buffer, because no encoding was given
}
```

See [`example.ts`](./example.ts) for the full runnable file.

## Common mistakes

1. **Calling `.split()` or other string methods on the result of `readFile(path)` without an encoding**, expecting a `string` — without `"utf8"`, the return type is `Buffer`, and the compiler correctly rejects string-only methods on it.
2. **Typing `JSON.parse(await fs.readFile(...))`'s result as a specific interface without validation.** `JSON.parse` returns `any` — casting or annotating it as `MyConfig` doesn't verify the file actually matches that shape; malformed data still passes the type checker and fails later, unexpectedly.
3. **Not narrowing a caught filesystem error before reading `.code`.** `NodeJS.ErrnoException` (with a `code` like `"ENOENT"`) isn't guaranteed — the caught value is `unknown`; check `err instanceof Error` (and often also that it has a `code` property) before relying on it.

## Exercise

Write an async function `countLines(path: string): Promise<number>` returning the number of non-empty lines in the file at `path`, correctly typed to read as `string`.

Try it yourself first, then check [`solutions/exercise_1.ts`](./solutions/exercise_1.ts).

## Interview questions

1. **Why does `fs.readFile(path, "utf8")` and `fs.readFile(path)` have different TypeScript return types?** — `@types/node` declares `readFile` with function overloads keyed on the encoding argument; passing `"utf8"` (or any `BufferEncoding`) matches the overload returning `string`, while omitting it matches the one returning `Buffer` — the compiler picks the overload based on the actual call.
2. **Does `JSON.parse` give you type safety?** — No — its return type is `any`; TypeScript doesn't validate the parsed data's shape against any type you might annotate it with, so malformed JSON that happens to still be valid JSON syntax will pass silently until something downstream fails.

---
← [Previous: Error Handling](../09_errors/README.md) | [Next: Modules and Packages →](../11_modules_packages/README.md)
