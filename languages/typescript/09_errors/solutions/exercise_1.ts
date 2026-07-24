import assert from "node:assert";

function describeError(err: unknown): string {
  if (err instanceof Error) {
    return err.message;
  }
  return String(err);
}

assert.strictEqual(describeError(new Error("boom")), "boom");
assert.strictEqual(describeError("plain string"), "plain string");
assert.strictEqual(describeError(42), "42");
console.log("ok");
