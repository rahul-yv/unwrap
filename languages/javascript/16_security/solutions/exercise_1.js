const assert = require("assert");
const crypto = require("node:crypto");

function hashPassword(password) {
  const salt = crypto.randomBytes(16);
  const digest = crypto.scryptSync(password, salt, 64);
  return { salt, digest };
}

function verifyPassword(password, salt, digest) {
  const candidate = crypto.scryptSync(password, salt, 64);
  return crypto.timingSafeEqual(candidate, digest);
}

const { salt, digest } = hashPassword("hunter2");
assert.strictEqual(verifyPassword("hunter2", salt, digest), true);
assert.strictEqual(verifyPassword("wrong", salt, digest), false);
console.log("ok");
