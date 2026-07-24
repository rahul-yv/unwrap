const assert = require("assert");

function describe(value) {
  if (value === null) return "null";
  return typeof value;
}

assert.strictEqual(describe(5), "number");
assert.strictEqual(describe(null), "null");
assert.strictEqual(describe(undefined), "undefined");
assert.strictEqual(describe("hi"), "string");
assert.strictEqual(describe(true), "boolean");
console.log("ok");
