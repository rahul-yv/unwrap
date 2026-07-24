const assert = require("assert");

function gradeIf(score) {
  if (score >= 90) return "A";
  else if (score >= 80) return "B";
  else return "C";
}

function gradeSwitch(score) {
  switch (true) {
    case score >= 90:
      return "A";
    case score >= 80:
      return "B";
    default:
      return "C";
  }
}

function fallthroughDemo(n) {
  const hit = [];
  switch (n) {
    case 1:
      hit.push(1);
    // intentional fallthrough
    case 2:
      hit.push(2);
      break;
    case 3:
      hit.push(3);
      break;
  }
  return hit;
}

function demo() {
  assert.strictEqual(gradeIf(95), "A");
  assert.strictEqual(gradeIf(85), "B");
  assert.strictEqual(gradeIf(50), "C");

  assert.strictEqual(gradeSwitch(95), "A");
  assert.strictEqual(gradeSwitch(85), "B");
  assert.strictEqual(gradeSwitch(50), "C");

  const score = 85;
  const label = score >= 60 ? "pass" : "fail";
  assert.strictEqual(label, "pass");

  assert.deepStrictEqual(fallthroughDemo(1), [1, 2]); // falls through into case 2
  assert.deepStrictEqual(fallthroughDemo(3), [3]);
}

demo();
console.log("ok");
