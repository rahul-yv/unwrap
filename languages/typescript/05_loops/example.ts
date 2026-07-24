import assert from "node:assert";

function demo(): void {
  const numbers: number[] = [1, 2, 3];
  let total = 0;
  for (const n of numbers) {
    total += n;
  }
  assert.strictEqual(total, 6);

  const entries = new Map<string, number>([
    ["a", 1],
    ["b", 2],
  ]);
  const collected: Array<[string, number]> = [];
  for (const [key, value] of entries) {
    collected.push([key, value]);
  }
  assert.deepStrictEqual(collected, [
    ["a", 1],
    ["b", 2],
  ]);

  const items: number[] = []; // explicit annotation, not left to widen
  for (let i = 0; i < 3; i++) {
    items.push(i * i);
  }
  assert.deepStrictEqual(items, [0, 1, 4]);
}

demo();
console.log("ok");
