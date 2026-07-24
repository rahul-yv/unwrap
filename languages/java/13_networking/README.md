# Networking and APIs

`java.net.http.HttpClient` (since Java 11) is the modern stdlib HTTP client — synchronous or async, with a fluent builder API. `com.sun.net.httpserver.HttpServer` is a small built-in HTTP server (despite the package name, it's a standard, documented part of the JDK) — good for tests and small tools without pulling in a real framework.

## Example

```java
HttpClient client = HttpClient.newBuilder()
	.connectTimeout(Duration.ofSeconds(5))
	.build();

HttpRequest request = HttpRequest.newBuilder()
	.uri(URI.create(url))
	.timeout(Duration.ofSeconds(5))
	.POST(HttpRequest.BodyPublishers.ofString(jsonBody))
	.header("Content-Type", "application/json")
	.build();

HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());
if (response.statusCode() != 200) {
	throw new RuntimeException("request failed: " + response.statusCode());
}
```

See [`Example.java`](./Example.java) for the full runnable file — it starts a local `HttpServer` and talks to it, so it works with no internet access.

## Common mistakes

1. **Not setting a timeout on the `HttpClient` or the request.** Without one, a stalled connection can hang the calling thread indefinitely — set both `connectTimeout` on the client and `timeout` on the request.
2. **Assuming `client.send` throws on a non-2xx response.** It doesn't — a 404 or 500 still returns a normal `HttpResponse`; check `response.statusCode()` explicitly before trusting the body.
3. **Blocking on `client.send` in a context where the async `sendAsync` (returning a `CompletableFuture`) would avoid tying up a thread** — fine for scripts and simple tools, but worth knowing the async variant exists for higher-throughput server code.
4. **Forgetting `HttpClient` instances are meant to be reused**, not created per-request — it manages connection pooling internally, and constructing a new one for every call throws that benefit away.

## Exercise

Write `String fetchBody(String url) throws IOException, InterruptedException` that GETs `url` with a 5-second timeout, throws a `RuntimeException` if the status isn't 200, and otherwise returns the response body as a `String`.

Try it yourself first, then check [`solutions/Exercise1.java`](./solutions/Exercise1.java).

## Interview questions

1. **Why doesn't `HttpClient.send` throw on a 404 or 500 response?** — It only throws for transport-level failures (connection refused, timeout, DNS failure); an HTTP error status is still a "successful" exchange from the client's point of view, so `statusCode()` must be checked explicitly.
2. **When would you use `sendAsync` instead of `send`?** — When you don't want to block the calling thread waiting for the response — `sendAsync` returns a `CompletableFuture<HttpResponse<T>>` immediately, useful for making concurrent requests or keeping a server thread free while waiting.

---
← [Previous: Testing](../12_testing/README.md) | [Next: Databases →](../14_databases/README.md)
