const assert = require("assert");

function demo() {
  const n = 10;
  const big = 10n;
  const s = "Ada";
  const ok = true;
  let nothing;
  const empty = null;

  assert.strictEqual(typeof n, "number");
  assert.strictEqual(typeof big, "bigint");
  assert.strictEqual(typeof s, "string");
  assert.strictEqual(typeof ok, "boolean");
  assert.strictEqual(typeof nothing, "undefined");
  assert.strictEqual(typeof empty, "object"); // the famous quirk

  assert.strictEqual("5" == 5, true); // coercion
  assert.strictEqual("5" === 5, false); // no coercion

  assert.strictEqual(null == undefined, true);
  assert.strictEqual(null === undefined, false);

  assert.strictEqual(0.1 + 0.2 === 0.3, false);
  assert.ok(Math.abs(0.1 + 0.2 - 0.3) < Number.EPSILON * 10);
}

demo();
console.log("ok");
