const assert = require("assert");
const crypto = require("node:crypto");

function demo() {
  const salt = crypto.randomBytes(16);
  const password = "correct horse battery staple";

  const digest = crypto.scryptSync(password, salt, 64);
  const candidate = crypto.scryptSync(password, salt, 64);
  assert.strictEqual(crypto.timingSafeEqual(digest, candidate), true);

  const wrongDigest = crypto.scryptSync("wrong password", salt, 64);
  assert.strictEqual(crypto.timingSafeEqual(digest, wrongDigest), false);

  // same password, different salt -> different digest
  const otherSalt = crypto.randomBytes(16);
  const otherDigest = crypto.scryptSync(password, otherSalt, 64);
  assert.notDeepStrictEqual(otherDigest, digest);

  const id = crypto.randomUUID();
  assert.match(id, /^[0-9a-f-]{36}$/);
}

demo();
console.log("ok");
