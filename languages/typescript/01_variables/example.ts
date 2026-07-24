import assert from "node:assert";

function demo(): void {
  let age = 25;
  const name: string = "Ada";
  age = age + 1;
  assert.strictEqual(age, 26);
  assert.strictEqual(name, "Ada");

  const point = { x: 1, y: 2 };
  point.x = 10; // allowed: const protects the binding, not the object
  assert.deepStrictEqual(point, { x: 10, y: 2 });

  let value: number | string = 5;
  assert.strictEqual(typeof value, "number");
  value = "now a string";
  assert.strictEqual(typeof value, "string");

  const frozen = Object.freeze({ value: 1 });
  // frozen.value = 99; // would be a compile error: readonly via Object.freeze's return type
  assert.strictEqual(frozen.value, 1);
}

demo();
console.log("ok");
