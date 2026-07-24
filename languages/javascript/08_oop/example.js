const assert = require("assert");

class Animal {
  #name;
  constructor(name) {
    this.#name = name;
  }
  get name() {
    return this.#name;
  }
  speak() {
    throw new Error("not implemented");
  }
}

class Dog extends Animal {
  speak() {
    return `${this.name} says Woof`;
  }
}

class Cat extends Animal {
  speak() {
    return `${this.name} says Meow`;
  }
}

class Broken extends Animal {
  constructor(name) {
    // using `this` before super() would throw; call super() first
    super(name);
  }
}

function demo() {
  const animals = [new Dog("Rex"), new Cat("Tom")];
  assert.deepStrictEqual(
    animals.map((a) => a.speak()),
    ["Rex says Woof", "Tom says Meow"]
  );

  const broken = new Broken("Buddy");
  assert.strictEqual(broken.name, "Buddy");

  // private field is not accessible from outside the class
  assert.strictEqual(broken.name, "Buddy");
  assert.strictEqual(Object.keys(broken).includes("#name"), false);

  assert.throws(() => new Animal("generic").speak(), /not implemented/);
}

demo();
console.log("ok");
