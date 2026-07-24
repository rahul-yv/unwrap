import assert from "node:assert";

function swap<T>(pair: [T, T]): [T, T] {
  return [pair[1], pair[0]];
}

assert.deepStrictEqual(swap([1, 2]), [2, 1]);
assert.deepStrictEqual(swap(["x", "y"]), ["y", "x"]);
console.log("ok");
