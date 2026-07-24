const assert = require("assert");

class InsufficientFundsError extends Error {
  constructor(balance, amount) {
    super(`cannot withdraw ${amount}, balance is ${balance}`);
    this.name = "InsufficientFundsError";
    this.balance = balance;
    this.amount = amount;
  }
}

function divide(a, b) {
  if (b === 0) throw new Error("cannot divide by zero");
  return a / b;
}

async function fetchData() {
  try {
    return await Promise.reject(new Error("network down"));
  } catch (err) {
    return null;
  }
}

async function demo() {
  assert.strictEqual(divide(10, 2), 5);

  let finallyRan = false;
  try {
    divide(10, 0);
    assert.fail("expected an error");
  } catch (err) {
    assert.strictEqual(err.message, "cannot divide by zero");
    assert.ok(err instanceof Error);
  } finally {
    finallyRan = true;
  }
  assert.strictEqual(finallyRan, true);

  try {
    throw new InsufficientFundsError(10, 50);
  } catch (err) {
    assert.ok(err instanceof InsufficientFundsError);
    assert.ok(err instanceof Error);
    assert.strictEqual(err.balance, 10);
    assert.strictEqual(err.amount, 50);
  }

  const result = await fetchData();
  assert.strictEqual(result, null);
}

demo().then(() => console.log("ok"));
