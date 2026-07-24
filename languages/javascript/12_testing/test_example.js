const test = require("node:test");
const assert = require("node:assert");
const { add } = require("./example.js");

test("adds positive numbers", () => {
  assert.strictEqual(add(2, 3), 5);
});

test("adds negative numbers", () => {
  assert.strictEqual(add(-2, -3), -5);
});

test("adds zero", () => {
  assert.strictEqual(add(0, 0), 0);
});
