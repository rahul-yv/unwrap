const assert = require("assert");

function greet(name, greeting = "Hello") {
  return `${greeting}, ${name}!`;
}

const double = (x) => x * 2;

function total(...args) {
  return args.reduce((sum, n) => sum + n, 0);
}

function makeCounter() {
  let count = 0;
  return () => ++count;
}

const obj = {
  label: "widget",
  regularMethodThis() {
    // arrow function here captures the enclosing `this` (the object)
    const getLabel = () => this.label;
    return getLabel();
  },
};

function demo() {
  assert.strictEqual(greet("Ada"), "Hello, Ada!");
  assert.strictEqual(greet("Ada", "Hi"), "Hi, Ada!");

  assert.strictEqual(double(5), 10);
  assert.strictEqual(total(1, 2, 3), 6);

  const counter = makeCounter();
  assert.strictEqual(counter(), 1);
  assert.strictEqual(counter(), 2);
  assert.strictEqual(counter(), 3);

  const other = makeCounter();
  assert.strictEqual(other(), 1); // independent state

  assert.strictEqual(obj.regularMethodThis(), "widget");

  function mutatesInput(arr) {
    arr.push(99);
  }
  function doesNotMutateInput(arr) {
    const copy = [...arr];
    copy.push(99);
    return copy;
  }
  const original = [1, 2, 3];
  mutatesInput(original);
  assert.deepStrictEqual(original, [1, 2, 3, 99]); // caller's array changed

  const safeOriginal = [1, 2, 3];
  const result = doesNotMutateInput(safeOriginal);
  assert.deepStrictEqual(safeOriginal, [1, 2, 3]); // untouched
  assert.deepStrictEqual(result, [1, 2, 3, 99]);
}

demo();
console.log("ok");
