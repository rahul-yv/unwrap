const assert = require("assert");

function makeCounter() {
  let count = 0;
  return () => ++count;
}

const counter = makeCounter();
assert.strictEqual(counter(), 1);
assert.strictEqual(counter(), 2);
assert.strictEqual(counter(), 3);

const other = makeCounter();
assert.strictEqual(other(), 1);

console.log("ok");
