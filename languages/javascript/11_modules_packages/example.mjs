import assert from "node:assert";
import { greet } from "./mypackage/helpers.mjs";

function demo() {
  assert.strictEqual(greet("Ada"), "Hello, Ada!");
}

demo();
console.log("ok");
