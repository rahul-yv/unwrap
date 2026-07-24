const assert = require("assert");

function demo() {
  const nums = [1, 2, 3, 4, 5];
  const squares = nums.map((n) => n * n);
  assert.deepStrictEqual(squares, [1, 4, 9, 16, 25]);

  const evens = nums.filter((n) => n % 2 === 0);
  assert.deepStrictEqual(evens, [2, 4]);

  const sum = nums.reduce((acc, n) => acc + n, 0);
  assert.strictEqual(sum, 15);

  const m = new Map();
  m.set("a", 1);
  assert.strictEqual(m.get("a"), 1);
  assert.strictEqual(m.get("missing"), undefined);

  const s = new Set([1, 2, 2, 3]);
  assert.strictEqual(s.size, 3);

  assert.strictEqual(nums.includes(3), true);
  assert.strictEqual(nums.indexOf(3) !== -1, true);

  assert.strictEqual([NaN].includes(NaN), true); // includes finds NaN
  assert.strictEqual([NaN].indexOf(NaN), -1); // indexOf cannot

  const original = [3, 1, 2];
  const mapped = original.map((n) => n * 10);
  assert.deepStrictEqual(original, [3, 1, 2]); // .map does not mutate
  assert.deepStrictEqual(mapped, [30, 10, 20]);

  const sorted = [...original].sort();
  assert.deepStrictEqual(original, [3, 1, 2]); // sorted a copy, original untouched
  assert.deepStrictEqual(sorted, [1, 2, 3]);
}

demo();
console.log("ok");
