# Error Handling

`try`/`catch`/`finally` behaves like JavaScript's (see the JavaScript track's `09_errors`). TypeScript's distinctive addition: a caught error's type is `unknown` (not `any`) under `strict` mode, which forces you to narrow it before accessing any property — `any` would let unchecked code compile and fail at runtime instead.

## Example

```typescript
class InsufficientFundsError extends Error {
  constructor(
    public balance: number,
    public amount: number
  ) {
    super(`cannot withdraw ${amount}, balance is ${balance}`);
    this.name = "InsufficientFundsError";
  }
}

try {
  throw new InsufficientFundsError(10, 50);
} catch (err) {
  // err is typed `unknown` — must narrow before use
  if (err instanceof InsufficientFundsError) {
    console.log(err.balance, err.amount);
  } else if (err instanceof Error) {
    console.log(err.message);
  }
}
```

See [`example.ts`](./example.ts) for the full runnable file.

## Common mistakes

1. **Annotating the catch variable as `any`** (`catch (err: any)`) to skip the narrowing step — this throws away the exact safety `unknown` is designed to provide, letting `err.someProperty` compile even if it doesn't exist.
2. **Assuming everything thrown is an `Error` instance.** JavaScript allows throwing any value (`throw "oops"`, `throw 42`); a caught `unknown` might not be an `Error` at all, so `instanceof Error` should be checked before assuming `.message` exists.
3. **Widening a custom error hierarchy's catch handling to `Error` only**, losing the ability to branch on the specific subclass — check the most specific type first (`instanceof InsufficientFundsError`) before falling back to the general `instanceof Error`.
4. **Forgetting `strict` mode is what makes `catch` variables `unknown` by default.** Under non-strict TypeScript settings, caught errors default to `any`, silently reintroducing the unsafe behavior — always keep `strict: true` (or at minimum `useUnknownInCatchVariables`) enabled.

## Exercise

Write `describeError(err: unknown): string` that returns `err.message` if `err instanceof Error`, or `String(err)` otherwise — safely narrowing an `unknown` caught value.

Try it yourself first, then check [`solutions/exercise_1.ts`](./solutions/exercise_1.ts).

## Interview questions

1. **Why does TypeScript type caught errors as `unknown` instead of `any` or `Error`?** — JavaScript permits throwing any value, not just `Error` instances, so assuming `Error` would be unsound; `unknown` forces an explicit check before any property access, catching the "not actually an Error" case at compile time instead of at runtime.
2. **How do you safely extract a message from an `unknown` caught value?** — Narrow it first: check `err instanceof Error` (or a custom error subclass) before accessing `.message`; for anything else, fall back to `String(err)` or a generic message.

---
← [Previous: OOP](../08_oop/README.md) | [Next: Files and I/O →](../10_files/README.md)
