import assert from "node:assert";
import crypto from "node:crypto";

type HashedPassword = string & { readonly __brand: "HashedPassword" };

function hashPassword(plaintext: string): { salt: Buffer; hashed: HashedPassword } {
  const salt = crypto.randomBytes(16);
  const digest = crypto.scryptSync(plaintext, salt, 64).toString("hex");
  return { salt, hashed: digest as HashedPassword };
}

function verifyPassword(plaintext: string, salt: Buffer, hashed: HashedPassword): boolean {
  const candidate = crypto.scryptSync(plaintext, salt, 64).toString("hex");
  return crypto.timingSafeEqual(Buffer.from(candidate), Buffer.from(hashed));
}

function storeHashedPassword(hashed: HashedPassword): string {
  return hashed; // in real code, this would write to a database
}

function demo(): void {
  const { salt, hashed } = hashPassword("hunter2");

  storeHashedPassword(hashed); // fine: hashed is a HashedPassword
  // storeHashedPassword("hunter2" as string); // would be a compile error without the cast

  assert.strictEqual(verifyPassword("hunter2", salt, hashed), true);
  assert.strictEqual(verifyPassword("wrong", salt, hashed), false);

  const id = crypto.randomUUID();
  assert.match(id, /^[0-9a-f-]{36}$/);
}

demo();
console.log("ok");
