import assert from "node:assert";

function firstOrDefault<T>(items: T[], defaultValue: T): T {
  return items.length > 0 ? items[0] : defaultValue;
}

assert.strictEqual(firstOrDefault([1, 2, 3], 0), 1);
assert.strictEqual(firstOrDefault([], 0), 0);
assert.strictEqual(firstOrDefault(["a"], "z"), "a");
console.log("ok");
