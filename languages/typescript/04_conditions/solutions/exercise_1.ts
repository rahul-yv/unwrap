import assert from "node:assert";

interface Circle {
  kind: "circle";
  radius: number;
}
interface Square {
  kind: "square";
  side: number;
}
interface Triangle {
  kind: "triangle";
  base: number;
  height: number;
}
type Shape = Circle | Square | Triangle;

function area(shape: Shape): number {
  switch (shape.kind) {
    case "circle":
      return Math.PI * shape.radius ** 2;
    case "square":
      return shape.side ** 2;
    case "triangle":
      return 0.5 * shape.base * shape.height;
    default: {
      const exhaustive: never = shape;
      throw new Error(`unhandled shape: ${exhaustive}`);
    }
  }
}

assert.strictEqual(area({ kind: "triangle", base: 4, height: 5 }), 10);
assert.strictEqual(area({ kind: "square", side: 3 }), 9);
console.log("ok");
