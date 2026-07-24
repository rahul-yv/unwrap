const assert = require("assert");

function safeDivide(a, b) {
  try {
    if (b === 0) throw new Error("division by zero");
    return a / b;
  } catch (err) {
    return null;
  }
}

assert.strictEqual(safeDivide(10, 2), 5);
assert.strictEqual(safeDivide(10, 0), null);
console.log("ok");
