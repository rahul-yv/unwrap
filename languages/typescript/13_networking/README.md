# Networking and APIs

`fetch` behaves exactly as in the JavaScript track's `13_networking`. TypeScript's addition is typing the JSON response: `response.json()` returns `Promise<any>` by default (the compiler can't know the shape of arbitrary JSON), so the idiomatic pattern is to assert or validate the expected shape explicitly rather than trusting an inferred `any`.

## Example

```typescript
interface EchoResponse {
  echo: { name: string };
}

async function postName(url: string, name: string): Promise<EchoResponse> {
  const response = await fetch(url, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ name }),
    signal: AbortSignal.timeout(5000),
  });
  if (!response.ok) {
    throw new Error(`request failed: ${response.status}`);
  }
  const body = (await response.json()) as EchoResponse; // asserting, not validating
  return body;
}
```

See [`example.ts`](./example.ts) for the full runnable file — it spins up a local `node:http` server and talks to it with `fetch`.

## Common mistakes

1. **Trusting `response.json() as MyType` as if it validated the data.** `as` is an assertion, not a check — if the server actually returns a different shape, the type checker still says it's `MyType`, and the mismatch only surfaces later (or not at all, as `undefined` property access). Use a runtime validation library (e.g. Zod) or manual checks when the response shape genuinely needs verifying.
2. **Forgetting `response.json()`'s inferred type is `any`** without an assertion, silently disabling type checking on everything derived from it — assign it to a typed variable or assert it immediately, don't let `any` propagate further into the codebase.
3. **Not checking `response.ok` before parsing the body as the expected success shape** — an error response's JSON body usually has a different shape (e.g. `{ error: string }`), and parsing it as the success type produces a value that type-checks but is semantically wrong.

## Exercise

Write an async function `fetchJson<T>(url: string): Promise<T>` that fetches `url`, throws if `!response.ok`, and returns `response.json()` typed as `T` (the caller specifies the expected shape via the type argument).

Try it yourself first, then check [`solutions/exercise_1.ts`](./solutions/exercise_1.ts).

## Interview questions

1. **Why is `response.json() as MyType` risky?** — `as` performs no runtime check; if the actual response doesn't match `MyType`, the type system still treats it as if it does, and the mismatch surfaces later as a runtime bug (or an incorrect value used silently) rather than a caught error at the fetch site.
2. **How would you make a `fetchJson` function reusable across different expected response shapes?** — Make it generic (`fetchJson<T>(url: string): Promise<T>`), letting each call site specify what shape it expects via the type argument, while the implementation stays the same.

---
← [Previous: Testing](../12_testing/README.md) | [Next: Databases →](../14_databases/README.md)
