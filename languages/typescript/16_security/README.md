# Security Basics

`node:crypto` behaves the same as in the JavaScript track's `16_security`. A TypeScript-specific pattern worth knowing here: **branded types**, which stop a plain `string` holding a plaintext password from being accidentally passed where a hashed digest was expected (or vice versa) — a mistake the type checker can't catch if both are just `string`.

## Example

```typescript
type HashedPassword = string & { readonly __brand: "HashedPassword" };

function hashPassword(plaintext: string): { salt: Buffer; hashed: HashedPassword } {
	const salt = crypto.randomBytes(16);
	const digest = crypto.scryptSync(plaintext, salt, 64).toString("hex");
	return { salt, hashed: digest as HashedPassword };  // the only place allowed to "create" this type
}

function storeHashedPassword(hashed: HashedPassword): void {
	/* ... */
}

const { hashed } = hashPassword("hunter2");
storeHashedPassword(hashed);        // fine
// storeHashedPassword("hunter2");  // compile error: plain string isn't HashedPassword
```

See [`example.ts`](./example.ts) for the full runnable file.

## Common mistakes

1. **Using `Math.random()` for tokens/passwords** — same as JavaScript; use `crypto.randomBytes`/`crypto.randomUUID`. TypeScript's typing doesn't change which function is cryptographically appropriate, only that you called *some* function correctly.
2. **Skipping the branded-type pattern and using plain `string` for both plaintext and hashed values**, relying on variable naming alone (`hashedPw` vs `plainPw`) to keep them apart — naming conventions aren't enforced; a brand is.
3. **Comparing secrets with `===`** instead of `crypto.timingSafeEqual` — the type system doesn't distinguish a timing-safe comparison from a naive one; this remains a runtime-behavior concern regardless of typing.
4. **Casting a `string` to a branded type outside the one function meant to produce it** (`"whatever" as HashedPassword` sprinkled around the codebase) — defeats the entire purpose; the cast should be centralized to the function that actually performs the hashing.

## Exercise

Define `type HashedPassword = string & { readonly __brand: "HashedPassword" }`, then write `hashPassword(plaintext: string): HashedPassword` and `verifyPassword(plaintext: string, hashed: HashedPassword): boolean` using `crypto.scryptSync`/`crypto.timingSafeEqual`.

Try it yourself first, then check [`solutions/exercise_1.ts`](./solutions/exercise_1.ts).

## Interview questions

1. **What problem do branded types solve that a plain `string` type alias doesn't?** — A type alias (`type HashedPassword = string`) is just a name — any `string` is still assignable to it with no error. A brand (`string & { __brand: ... }`) makes the type structurally distinct, so a plain `string` can't be used where the branded type is expected without an explicit (and visible) cast.
2. **Are branded types a runtime safety mechanism?** — No — the brand field doesn't exist at runtime (it's a compile-time-only marker); it only prevents *accidental* misuse during development, not malicious bypassing, since `as` can always force the cast.

---
← [Previous: Concurrency](../15_concurrency/README.md) | [Next: Mini Projects →](../17_projects/README.md)
