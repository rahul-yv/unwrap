const assert = require("assert");

function demo() {
  const seen = [];
  for (let i = 0; i < 3; i++) seen.push(i);
  assert.deepStrictEqual(seen, [0, 1, 2]);

  const values = [];
  for (const item of ["a", "b", "c"]) values.push(item);
  assert.deepStrictEqual(values, ["a", "b", "c"]);

  const keys = [];
  for (const index in ["a", "b", "c"]) keys.push(index);
  assert.deepStrictEqual(keys, ["0", "1", "2"]); // strings, not numbers

  let n = 0;
  while (n < 3) n++;
  assert.strictEqual(n, 3);

  // var closures over the loop variable share one binding
  const varResults = [];
  for (var i = 0; i < 3; i++) {
    varResults.push(() => i);
  }
  assert.deepStrictEqual(
    varResults.map((f) => f()),
    [3, 3, 3]
  );

  // let gives each iteration its own binding
  const letResults = [];
  for (let j = 0; j < 3; j++) {
    letResults.push(() => j);
  }
  assert.deepStrictEqual(
    letResults.map((f) => f()),
    [0, 1, 2]
  );
}

demo();
console.log("ok");
