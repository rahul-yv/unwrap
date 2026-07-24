import assert from "node:assert";
import { greet } from "../mypackage/helpers";
import type { Greeting } from "../mypackage/helpers";

function exampleUsage(): string {
  const result: Greeting = greet("World");
  return result.message;
}

assert.strictEqual(exampleUsage(), "Hello, World!");
console.log("ok");
