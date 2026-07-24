# Files and I/O

Node's `fs` module has synchronous (`fs.readFileSync`), callback-based (`fs.readFile`), and Promise-based (`fs.promises` / `node:fs/promises`) APIs for the same operations. Prefer the Promise-based API with `async`/`await` in new code — it avoids callback nesting and composes cleanly with error handling.

## Example

```javascript
const fs = require("node:fs/promises");
const path = require("node:path");
const os = require("node:os");

const filePath = path.join(os.tmpdir(), "notes.txt");
await fs.writeFile(filePath, "line one\nline two\n", "utf8");

const content = await fs.readFile(filePath, "utf8");
const lines = content.split("\n").filter(Boolean);

await fs.unlink(filePath);
```

See [`example.js`](./example.js) for the full runnable file.

## Common mistakes

1. **Using the synchronous `fs` API (`readFileSync`) in a server request handler.** It blocks the entire event loop until the disk operation completes, stalling every other concurrent request. Use the async API in server code; sync is fine for one-off scripts/CLI tools.
2. **Forgetting to await/catch a Promise-based `fs` call.** An unhandled rejection (e.g. file not found) silently fails or crashes depending on Node's configuration — always `try`/`catch` around `await fs.readFile(...)`.
3. **Not specifying an encoding**, getting a `Buffer` back instead of a `string`, then being confused when string methods aren't available on it. Pass `"utf8"` explicitly when you want text.
4. **Building file paths with string concatenation (`dir + "/" + file`)** instead of `path.join(dir, file)` — breaks on Windows and mishandles trailing slashes.

## Exercise

Write an async function `countLines(filePath)` that reads the file at `filePath` and returns the number of non-empty lines.

Try it yourself first, then check [`solutions/exercise_1.js`](./solutions/exercise_1.js).

## Interview questions

1. **Why avoid `fs.readFileSync` in a server's request-handling path?** — Node is single-threaded for JS execution; a blocking sync call stalls the event loop, delaying every other in-flight request until the disk operation finishes.
2. **What's the difference between the callback-based and Promise-based `fs` APIs?** — Same underlying operations; the Promise-based API (`fs.promises` / `node:fs/promises`) returns promises instead of taking a callback, so it composes with `async`/`await` and standard promise error handling instead of nested callbacks.

---
← [Previous: Error Handling](../09_errors/README.md) | [Next: Modules and Packages →](../11_modules_packages/README.md)
