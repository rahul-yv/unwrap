const assert = require("assert");

function demo() {
  const count = 0;
  assert.strictEqual(count || 10, 10);
  assert.strictEqual(count ?? 10, 0);

  const user = { profile: null };
  assert.strictEqual(user.profile?.name, undefined);

  const nums = [1, 2, 3];
  const more = [...nums, 4, 5];
  assert.deepStrictEqual(more, [1, 2, 3, 4, 5]);

  const [first, ...rest] = more;
  assert.strictEqual(first, 1);
  assert.deepStrictEqual(rest, [2, 3, 4, 5]);
}

demo();
console.log("ok");
