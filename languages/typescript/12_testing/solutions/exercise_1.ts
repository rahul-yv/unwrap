import test from "node:test";
import assert from "node:assert";
import { add } from "../example";

test("adds zero", () => {
  assert.strictEqual(add(0, 0), 0);
});

test("adds cancelling values", () => {
  assert.strictEqual(add(-1, 1), 0);
});
