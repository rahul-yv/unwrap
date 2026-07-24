# Networking and APIs

`urllib.request` (stdlib) makes basic HTTP requests without any dependency; in real projects the third-party `requests` library is the de facto standard for its friendlier API. `http.server` (stdlib) can run a minimal HTTP server, useful for testing or small tools. Modern APIs are usually JSON over HTTP — `json.dumps`/`json.loads` (stdlib) handles the encoding.

## Example

```python
import json
import urllib.request

req = urllib.request.Request(
    "http://example.com/api",
    data=json.dumps({"name": "Ada"}).encode(),
    headers={"Content-Type": "application/json"},
    method="POST",
)
with urllib.request.urlopen(req, timeout=5) as resp:
    body = json.loads(resp.read())
```

See [`example.py`](./example.py) for a full runnable file — it spins up a local `http.server` instance and talks to it, so it works with no internet access and no external services.

## Common mistakes

1. **Making a network call with no timeout.** A hung connection blocks forever by default; always pass `timeout=...`.
2. **Not handling non-2xx responses.** `urllib.request.urlopen` raises `HTTPError` on 4xx/5xx — catch it explicitly rather than assuming every request succeeds.
3. **Building query strings or JSON bodies by hand with string formatting** instead of `urllib.parse.urlencode` / `json.dumps` — easy to produce invalid encoding or open an injection risk.
4. **Retrying failed requests with no backoff**, hammering a struggling server harder. Use exponential backoff for retries in real code.

## Exercise

Write a function `fetch_json(url, timeout=5)` that calls `urllib.request.urlopen(url, timeout=timeout)` and returns the parsed JSON body, raising a `ValueError` with a clear message if the response isn't valid JSON.

Try it yourself first, then check [`solutions/exercise_1.py`](./solutions/exercise_1.py).

## Interview questions

1. **What's the difference between REST and RPC-style APIs, broadly?** — REST models operations as HTTP verbs on resources (`GET /users/1`, `POST /users`); RPC-style APIs expose named remote procedures (`POST /getUser`), often more verb-agnostic.
2. **Why always set a request timeout?** — Without one, a stalled connection can block the calling thread indefinitely, which in a server context can exhaust worker threads under load.
3. **What status code ranges mean what?** — 2xx success, 3xx redirect, 4xx client error (bad request, the caller's fault), 5xx server error (the server's fault).

---
← [Previous: Testing](../12_testing/README.md) | [Next: Databases →](../14_databases/README.md)
