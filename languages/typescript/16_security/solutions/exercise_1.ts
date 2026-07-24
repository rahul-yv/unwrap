import assert from "node:assert";
import crypto from "node:crypto";

type HashedPassword = string & { readonly __brand: "HashedPassword" };

function hashPassword(plaintext: string): { salt: Buffer; hashed: HashedPassword } {
  const salt = crypto.randomBytes(16);
  const hashed = crypto.scryptSync(plaintext, salt, 64).toString("hex") as HashedPassword;
  return { salt, hashed };
}

function verifyPassword(plaintext: string, salt: Buffer, hashed: HashedPassword): boolean {
  const candidate = crypto.scryptSync(plaintext, salt, 64).toString("hex");
  return crypto.timingSafeEqual(Buffer.from(candidate), Buffer.from(hashed));
}

const { salt, hashed } = hashPassword("hunter2");
assert.strictEqual(verifyPassword("hunter2", salt, hashed), true);
assert.strictEqual(verifyPassword("wrong", salt, hashed), false);
console.log("ok");
