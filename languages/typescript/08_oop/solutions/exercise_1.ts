import assert from "node:assert";

interface Shape {
  area(): number;
}

class Rectangle implements Shape {
  constructor(
    public readonly width: number,
    public readonly height: number
  ) {}

  area(): number {
    return this.width * this.height;
  }
}

const rect = new Rectangle(3, 4);
assert.strictEqual(rect.area(), 12);
assert.strictEqual(rect.width, 3);
console.log("ok");
