import assert from "node:assert";
import { greet } from "./mypackage/helpers";
import type { Greeting } from "./mypackage/helpers";

function demo(): void {
  const result: Greeting = greet("Ada");
  assert.strictEqual(result.message, "Hello, Ada!");
}

demo();
console.log("ok");
