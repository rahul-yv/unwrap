import assert from "node:assert";

function sumEven(numbers: number[]): number {
  let total = 0;
  for (const n of numbers) {
    if (n % 2 === 0) total += n;
  }
  return total;
}

assert.strictEqual(sumEven([1, 2, 3, 4]), 6);
assert.strictEqual(sumEven([1, 3, 5]), 0);
console.log("ok");
