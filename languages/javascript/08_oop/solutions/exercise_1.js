const assert = require("assert");

class Rectangle {
  #width;
  #height;

  constructor(width, height) {
    this.#width = width;
    this.#height = height;
  }

  area() {
    return this.#width * this.#height;
  }

  equals(other) {
    return this.#width === other.#width && this.#height === other.#height;
  }
}

assert.strictEqual(new Rectangle(3, 4).area(), 12);
assert.strictEqual(new Rectangle(3, 4).equals(new Rectangle(3, 4)), true);
assert.strictEqual(new Rectangle(3, 4).equals(new Rectangle(4, 3)), false);
console.log("ok");
