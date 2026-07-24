import assert from "node:assert";

interface Speaker {
  speak(): string;
}

abstract class Animal implements Speaker {
  constructor(protected name: string) {}
  abstract speak(): string;
}

class Dog extends Animal {
  speak(): string {
    return `${this.name} says Woof`;
  }
}

class BankAccount {
  #balance: number;
  constructor(
    private owner: string,
    initial: number
  ) {
    this.#balance = initial;
  }
  get balance(): number {
    return this.#balance;
  }
  getOwner(): string {
    return this.owner;
  }
}

function demo(): void {
  const dog = new Dog("Rex");
  assert.strictEqual(dog.speak(), "Rex says Woof");
  assert.ok(dog instanceof Animal);

  const account = new BankAccount("Ada", 100);
  assert.strictEqual(account.balance, 100);
  assert.strictEqual(account.getOwner(), "Ada");

  // TypeScript's `private`/`protected` are compile-time only; the compiled
  // JS has no runtime enforcement — this cast bypasses the type checker
  // to demonstrate that #balance (real private) still can't be reached,
  // while `owner` (TS `private`, not `#owner`) is a normal property at runtime.
  const asAny = account as any;
  assert.strictEqual(asAny.owner, "Ada"); // TS `private` field, visible at runtime
  assert.strictEqual(asAny["#balance"], undefined); // real #private is not accessible this way
}

demo();
console.log("ok");
