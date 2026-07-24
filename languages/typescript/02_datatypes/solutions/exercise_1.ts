import assert from "node:assert";

interface Point {
  x: number;
  y: number;
}

function distance(a: Point, b: Point): number {
  return Math.sqrt((a.x - b.x) ** 2 + (a.y - b.y) ** 2);
}

assert.strictEqual(distance({ x: 0, y: 0 }, { x: 3, y: 4 }), 5);
assert.strictEqual(distance({ x: 1, y: 1 }, { x: 1, y: 1 }), 0);
console.log("ok");
