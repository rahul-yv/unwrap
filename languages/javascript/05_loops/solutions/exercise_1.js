const assert = require("assert");

function firstEven(numbers) {
  for (const n of numbers) {
    if (n % 2 === 0) return n;
  }
  return undefined;
}

assert.strictEqual(firstEven([1, 3, 4, 5]), 4);
assert.strictEqual(firstEven([1, 3, 5]), undefined);
console.log("ok");
