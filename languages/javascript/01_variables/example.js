const assert = require("assert");

function demo() {
  let age = 25;
  const name = "Ada";
  age = age + 1;
  assert.strictEqual(age, 26);
  assert.strictEqual(name, "Ada");

  const point = { x: 1, y: 2 };
  point.x = 10; // allowed: const protects the binding, not the object
  assert.deepStrictEqual(point, { x: 10, y: 2 });

  const [a, b] = [1, 2];
  assert.deepStrictEqual([a, b], [1, 2]);

  const { x, y } = point;
  assert.strictEqual(x, 10);
  assert.strictEqual(y, 2);

  const frozen = Object.freeze({ value: 1 });
  frozen.value = 99; // silently ignored in non-strict mode
  assert.strictEqual(frozen.value, 1); // Object.freeze gives real immutability
}

demo();
console.log("ok");
