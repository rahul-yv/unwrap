# Networking and APIs

The `fetch` API (built into modern Node and every browser) is the standard way to make HTTP requests — no dependency needed. Node's `http` module can run a minimal server, useful for small tools or tests. Modern APIs are usually JSON over HTTP.

## Example

```javascript
const response = await fetch("http://example.com/api", {
  method: "POST",
  headers: { "Content-Type": "application/json" },
  body: JSON.stringify({ name: "Ada" }),
  signal: AbortSignal.timeout(5000),
});

if (!response.ok) {
  throw new Error(`request failed: ${response.status}`);
}
const body = await response.json();
```

See [`example.js`](./example.js) for the full runnable file — it spins up a local `http` server and talks to it with `fetch`, so it works with no internet access.

## Common mistakes

1. **Making a `fetch` call with no timeout.** A hung connection can wait indefinitely by default; use `AbortSignal.timeout(ms)` (or an `AbortController`) to cap it.
2. **Assuming `fetch` rejects on a non-2xx response.** It doesn't — a 404 or 500 still resolves successfully; check `response.ok` (or `response.status`) explicitly before trusting the body.
3. **Forgetting to set `Content-Type: application/json`** when sending a JSON body — some servers won't parse the request correctly without it.
4. **Calling `response.json()` twice**, or after already reading `.text()` — the response body stream can only be consumed once.

## Exercise

Write an async function `fetchJson(url, options)` that calls `fetch(url, options)`, throws an `Error` with a clear message if `!response.ok`, and otherwise returns the parsed JSON body.

Try it yourself first, then check [`solutions/exercise_1.js`](./solutions/exercise_1.js).

## Interview questions

1. **Why doesn't `fetch` reject on a 404 or 500 response?** — It only rejects on network-level failures (DNS, connection refused, aborted); an HTTP error status is still a "successful" fetch from the transport's point of view, so `response.ok` must be checked explicitly.
2. **How do you cancel/timeout a `fetch` request?** — Pass a `signal` from an `AbortController` (or `AbortSignal.timeout(ms)`); calling `.abort()` (or the timeout firing) rejects the pending fetch.

---
← [Previous: Testing](../12_testing/README.md) | [Next: Databases →](../14_databases/README.md)
