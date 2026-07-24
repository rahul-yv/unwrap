# Networking and APIs

`net/http` covers both client and server — no external dependency needed for basic HTTP work, unlike most languages where the standard library client is minimal. `encoding/json` handles marshaling structs to/from JSON, driven by struct tags (`json:"name"`).

## Example

```go
type EchoRequest struct {
	Name string `json:"name"`
}

http.HandleFunc("/api", func(w http.ResponseWriter, r *http.Request) {
	var req EchoRequest
	json.NewDecoder(r.Body).Decode(&req)
	json.NewEncoder(w).Encode(map[string]string{"echo": req.Name})
})

client := &http.Client{Timeout: 5 * time.Second}
resp, err := client.Post(url, "application/json", body)
```

See [`example.go`](./example.go) for the full runnable file — it starts a local `httptest.Server` and talks to it, so it works with no internet access.

## Common mistakes

1. **Using `http.Get`/`http.Post` directly instead of a `http.Client` with a `Timeout`.** The package-level helpers use `http.DefaultClient`, which has no timeout by default — a hung connection blocks forever. Always construct a `Client` with an explicit `Timeout` (or a context with a deadline) for real code.
2. **Forgetting to close the response body.** `resp.Body` must be closed (`defer resp.Body.Close()`) even on a successful request, or the underlying connection can't be reused/released, leaking resources over many requests.
3. **Not checking `resp.StatusCode` before trusting the body.** Like other languages' HTTP clients, a non-2xx response doesn't return an error from `client.Do` — that's a separate check against `resp.StatusCode`.
4. **Forgetting exported struct fields are required for `encoding/json`.** A struct field must start with an uppercase letter to be marshaled/unmarshaled at all — a lowercase field is silently skipped, not an error.

## Exercise

Write `fetchJSON(url string, target any) error` that GETs `url` with a 5-second timeout, checks the status is 200, and decodes the JSON body into `target` (a pointer).

Try it yourself first, then check [`solutions/exercise_1.go`](./solutions/exercise_1.go).

## Interview questions

1. **Why does `net/http`'s package-level `http.Get` risk hanging indefinitely?** — It uses `http.DefaultClient`, which has no `Timeout` set; a slow or stalled server can block the call forever unless the caller constructs its own `Client` with an explicit timeout or uses a context deadline.
2. **Why must a JSON-tagged struct field be exported (capitalized)?** — `encoding/json` uses reflection, which can only see exported fields from outside the package; an unexported field is invisible to the encoder/decoder regardless of its `json:` tag.

---
← [Previous: Testing](../12_testing/README.md) | [Next: Databases →](../14_databases/README.md)
