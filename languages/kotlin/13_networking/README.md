# Networking and APIs

Kotlin runs on the JVM, so it has full access to `java.net.Socket`/`ServerSocket` for raw TCP, and `java.net.http.HttpClient` (Java 11+) for HTTP calls — no extra dependency needed for either. Kotlin's `use { }` closes sockets and streams automatically, the same pattern as file I/O.

## Example

```kotlin
import java.net.InetAddress
import java.net.ServerSocket
import java.net.Socket

val server = ServerSocket(0, 1, InetAddress.getLoopbackAddress())
val port = server.localPort

val serverThread = Thread {
	server.accept().use { conn ->
		val buffer = ByteArray(16)
		val read = conn.getInputStream().read(buffer)
		conn.getOutputStream().write(buffer, 0, read)   // echo it back
	}
}
serverThread.start()

Socket(InetAddress.getLoopbackAddress(), port).use { client ->
	client.getOutputStream().write("ping".toByteArray())

	val response = ByteArray(16)
	val n = client.getInputStream().read(response)
	val text = String(response, 0, n)   // "ping"
}
serverThread.join()
server.close()
```

For calling a real HTTP API: `val client = HttpClient.newHttpClient(); val response = client.send(request, BodyHandlers.ofString())` — a single `HttpClient` instance is thread-safe and reusable across requests, similar to `.NET`'s `HttpClient`.

See [`example.kt`](./example.kt) for the full runnable file — a loopback client/server exchange using `Socket`/`ServerSocket`.

## Common mistakes

1. **Creating a new `HttpClient` per request.** Like most HTTP client libraries, `HttpClient` pools connections internally — creating and discarding many instances wastes that pooling; build one and reuse it for the app's lifetime.
2. **Assuming one `read()` call returns the whole message.** TCP is a byte stream — a message can arrive split across multiple reads; loop until a complete, self-delimited message (length-prefixed or newline-terminated) has been read.
3. **Not closing sockets/streams with `use { }`.** A `Socket`, `ServerSocket`, or stream wraps an OS resource; forgetting to close it (especially on an exception path) leaks file descriptors.
4. **Running blocking socket I/O on a thread meant for something else** (like a UI thread) without moving it to a background thread or coroutine — blocking I/O ties up whatever thread calls it until the operation completes.

## Exercise

Write a function `fun echoOnce(port: Int, message: String): String` that connects to a `ServerSocket` already listening on `port`, sends `message`, and returns what comes back.

Try it yourself first, then check [`solutions/exercise_1.kt`](./solutions/exercise_1.kt).

## Interview questions

1. **Why should an app share one `HttpClient` instance instead of creating one per request?** — It pools and reuses underlying TCP connections internally; creating a new instance per call discards that pooling, effectively opening a fresh connection for every request — wasteful and slower under load.
2. **Why does receiving a TCP message often require a loop instead of a single `read()`?** — TCP delivers a stream of bytes with no message boundaries preserved — a single `read()` call may return less than a full logical message (if it hasn't all arrived yet) or, on the sending side, an application-level message may be split across multiple underlying packets. The receiver needs its own framing (a length prefix, a delimiter, or a fixed size) and must loop until that complete frame has been read.

---
← [Previous: Testing](../12_testing/README.md) | [Next: Databases →](../14_databases/README.md)
