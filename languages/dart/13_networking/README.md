# Networking and APIs

Dart's `dart:io` provides `ServerSocket`/`Socket` for raw TCP, built entirely on `Future`/`Stream` — a socket's incoming data arrives as a `Stream<Uint8List>`, so reading from the network uses the same `async`/`await`/`.listen()` patterns as any other async Dart code. For HTTP calls, `dart:io`'s `HttpClient` (lower-level) or the `http` package (higher-level, and what most projects actually use) cover client requests.

## Example

```dart
import "dart:io";
import "dart:convert";

final server = await ServerSocket.bind(InternetAddress.loopbackIPv4, 0);   // 0: let the OS assign a free port
final port = server.port;

server.listen((client) {
	client.listen((data) {
		client.add(data);   // echo it back
		client.close();
	});
});

final socket = await Socket.connect(InternetAddress.loopbackIPv4, port);
socket.add(utf8.encode("ping"));

final response = await socket.first;   // first chunk of the response Stream
final text = utf8.decode(response);    // "ping"

socket.close();
await server.close();
```

See [`example.dart`](./example.dart) for the full runnable file — a loopback client/server exchange using `ServerSocket`/`Socket`.

## Common mistakes

1. **Treating `socket.first` as "the complete message" for anything beyond a toy example.** A socket's data arrives as a `Stream` of chunks — `.first` grabs only the first chunk, which may be a partial message if more data is still arriving; real protocols need explicit framing (length-prefixed or delimited) and accumulate chunks accordingly, typically via `.fold`/`.transform` on the stream.
2. **Not closing sockets (`socket.close()`, `await server.close()`) on every code path**, including error paths — each wraps an OS resource that isn't automatically released without an explicit close.
3. **Using `dart:io`'s low-level `HttpClient` for application HTTP calls when the `http` package's simpler API would do.** `HttpClient` requires more manual work (building the request, writing the body, reading the response stream) than the `http` package's `http.get(uri)`/`http.post(uri, body: ...)`, which return a ready-to-use response directly — reach for `HttpClient` only when its extra control (fine-grained header/connection management) is actually needed.
4. **Forgetting `dart:io` (and therefore raw sockets/`HttpClient`) isn't available on Flutter Web** — web apps run in a browser sandbox with no raw socket access; web-targeted code needs `package:http` (which adapts to `fetch`/`XMLHttpRequest` under the hood on web) or `dart:html`'s browser-specific APIs instead.

## Exercise

Write a function `Future<String> echoOnce(int port, String message)` that connects to a listening socket on `port`, sends `message`, and returns what comes back.

Try it yourself first, then check [`solutions/exercise_1.dart`](./solutions/exercise_1.dart).

## Interview questions

1. **Why does a Dart socket's incoming data arrive as a `Stream` rather than a single value?** — Network data arrives incrementally and in chunks whose boundaries don't necessarily align with logical messages — a `Stream<Uint8List>` models this naturally, letting code process data as it arrives (via `.listen()`) or accumulate it (via `.fold`/`.transform`) rather than blocking until some fixed amount has arrived, which wouldn't fit variable-length messages well anyway.
2. **Why might `dart:io`'s raw sockets/`HttpClient` be unavailable in some Dart contexts?** — `dart:io` provides OS-level I/O bindings that only make sense in a native runtime (command-line, server, or a Flutter app's native platform code) — a Flutter Web app runs inside a browser sandbox with no access to raw sockets or the filesystem, so `dart:io` isn't available there at all; code needing to run on both native and web targets uses `package:http` (which adapts per-platform) instead of `dart:io` directly.

---
← [Previous: Testing](../12_testing/README.md) | [Next: Databases →](../14_databases/README.md)
