import assert from "node:assert";

interface Circle {
  kind: "circle";
  radius: number;
}
interface Square {
  kind: "square";
  side: number;
}
type Shape = Circle | Square;

function area(shape: Shape): number {
  switch (shape.kind) {
    case "circle":
      return Math.PI * shape.radius ** 2;
    case "square":
      return shape.side ** 2;
    default: {
      const exhaustive: never = shape;
      throw new Error(`unhandled shape: ${exhaustive}`);
    }
  }
}

function demo(): void {
  const circle: Shape = { kind: "circle", radius: 2 };
  const square: Shape = { kind: "square", side: 3 };

  assert.ok(Math.abs(area(circle) - Math.PI * 4) < 1e-9);
  assert.strictEqual(area(square), 9);
}

demo();
console.log("ok");
