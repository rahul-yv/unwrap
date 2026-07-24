const assert = require("assert");

function grade(score) {
  if (score >= 90) return "A";
  if (score >= 80) return "B";
  if (score >= 70) return "C";
  return "F";
}

assert.strictEqual(grade(95), "A");
assert.strictEqual(grade(72), "C");
assert.strictEqual(grade(40), "F");
console.log("ok");
