# Object-Oriented Programming

Class syntax and runtime behavior match JavaScript's (see the JavaScript track's `08_oop`). TypeScript adds compile-time access modifiers (`private`/`protected`/`public`), `abstract` classes, `implements` for checking a class satisfies an interface, and constructor parameter properties — a shorthand that declares and assigns a field in one place.

## Example

```typescript
interface Speaker {
  speak(): string;
}

abstract class Animal implements Speaker {
  constructor(protected name: string) {}   // parameter property: declares + assigns `name`
  abstract speak(): string;                 // must be implemented by subclasses
}

class Dog extends Animal {
  speak(): string {
    return `${this.name} says Woof`;        // `protected` name is visible to subclasses
  }
}

class BankAccount {
  #balance: number;                         // real private field (ES2022)
  constructor(private owner: string, initial: number) {
    this.#balance = initial;
  }
  get balance(): number {
    return this.#balance;
  }
}
```

See [`example.ts`](./example.ts) for the full runnable file.

## Common mistakes

1. **Relying on `private` for real encapsulation.** TypeScript's `private`/`protected` are compile-time only — erased at compile time, the emitted JavaScript has no runtime enforcement, so a caller who bypasses the type checker (e.g. via `as any`) can still access a `private` field. Use `#field` (real private, ES2022) when actual runtime privacy matters.
2. **Instantiating an `abstract` class directly** — the compiler rejects `new Animal(...)` if `Animal` is `abstract`; only concrete subclasses that implement every `abstract` member can be instantiated.
3. **Confusing `implements` (a class satisfies an interface's shape) with `extends` (inherits an implementation)** — a class can `implement` many interfaces but `extend` only one class; `implements` checks the shape matches, it doesn't share any code.
4. **Overusing parameter properties for fields that need more than trivial assignment** — `constructor(private x: number)` is great for simple "store this argument" fields, but obscures logic if the constructor body would otherwise need to validate or transform the value before storing it.

## Exercise

Write a `Rectangle` class implementing a `Shape` interface (`area(): number`), using constructor parameter properties for `width`/`height`, with a `readonly` modifier on both.

Try it yourself first, then check [`solutions/exercise_1.ts`](./solutions/exercise_1.ts).

## Interview questions

1. **Are `private`/`protected` enforced at runtime in TypeScript?** — No — they're purely compile-time checks, erased in the emitted JavaScript; real runtime privacy requires `#field` (a genuine ES2022 private class field).
2. **What's the difference between `implements` and `extends`?** — `extends` inherits from a base class (implementation and shape); `implements` only checks that a class's shape satisfies an interface's contract — it shares no code, and a class can implement multiple interfaces but extend only one class.

---
← [Previous: Collections](../07_collections/README.md) | [Next: Error Handling →](../09_errors/README.md)
