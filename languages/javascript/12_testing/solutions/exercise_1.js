const test = require("node:test");
const assert = require("node:assert");
const { add } = require("../example.js");

test("adds zero", () => {
  assert.strictEqual(add(0, 0), 0);
});

test("adds cancelling values", () => {
  assert.strictEqual(add(-1, 1), 0);
});
