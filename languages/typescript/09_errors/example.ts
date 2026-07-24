import assert from "node:assert";

class InsufficientFundsError extends Error {
  constructor(
    public balance: number,
    public amount: number
  ) {
    super(`cannot withdraw ${amount}, balance is ${balance}`);
    this.name = "InsufficientFundsError";
  }
}

function demo(): void {
  try {
    throw new InsufficientFundsError(10, 50);
  } catch (err) {
    // err is `unknown` here; must narrow before use
    assert.ok(err instanceof InsufficientFundsError);
    if (err instanceof InsufficientFundsError) {
      assert.strictEqual(err.balance, 10);
      assert.strictEqual(err.amount, 50);
    }
  }

  try {
    throw "a plain string, not an Error";
  } catch (err) {
    assert.strictEqual(err instanceof Error, false);
    assert.strictEqual(typeof err, "string");
  }

  try {
    throw new Error("generic failure");
  } catch (err) {
    assert.ok(err instanceof Error);
    if (err instanceof Error) {
      assert.strictEqual(err.message, "generic failure");
    }
  }
}

demo();
console.log("ok");
