import assert from "node:assert";
import { greet } from "../mypackage/helpers.mjs";

function exampleUsage() {
  return greet("World");
}

assert.strictEqual(exampleUsage(), "Hello, World!");
console.log("ok");
