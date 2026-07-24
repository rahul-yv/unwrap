import test from "node:test";
import assert from "node:assert";
import { add } from "./example";

test("adds positive numbers", () => {
  assert.strictEqual(add(2, 3), 5);
});

test("adds negative numbers", () => {
  assert.strictEqual(add(-2, -3), -5);
});

test("adds zero", () => {
  assert.strictEqual(add(0, 0), 0);
});
