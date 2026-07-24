const assert = require("assert");

function swap([a, b]) {
  return [b, a];
}

assert.deepStrictEqual(swap([1, 2]), [2, 1]);
console.log("ok");
