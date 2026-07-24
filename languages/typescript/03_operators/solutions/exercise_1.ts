import assert from "node:assert";

function getLength(value: string | number[]): number {
  if (typeof value === "string") {
    return value.length;
  }
  return value.length;
}

assert.strictEqual(getLength("hello"), 5);
assert.strictEqual(getLength([1, 2, 3]), 3);
console.log("ok");
