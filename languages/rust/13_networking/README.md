# Networking and APIs

Rust's standard library has no HTTP client or server — unlike Python/Go/Java, that's deliberately left to the ecosystem (`reqwest`, `hyper`, `axum`, ...), which need `Cargo` to pull in. What stdlib *does* give you is `std::net::TcpListener`/`TcpStream` — raw TCP sockets, which is what HTTP is actually built on top of. This lesson builds a minimal HTTP exchange directly on TCP, staying dependency-free and showing what an HTTP library does under the hood.

## Example

```rust
use std::net::{TcpListener, TcpStream};
use std::io::{Read, Write};

let listener = TcpListener::bind("127.0.0.1:0")?;   // :0 asks the OS for a free port
let port = listener.local_addr()?.port();

// server: accept one connection, read the request, write a minimal response
let mut stream = listener.accept()?.0;
let mut buffer = [0; 1024];
stream.read(&mut buffer)?;
stream.write_all(b"HTTP/1.1 200 OK\r\nContent-Length: 2\r\n\r\nok")?;

// client: connect and send a raw HTTP request line
let mut client = TcpStream::connect(("127.0.0.1", port))?;
client.write_all(b"GET / HTTP/1.1\r\nHost: localhost\r\n\r\n")?;
```

See [`example.rs`](./example.rs) for the full runnable file — the server runs on a background thread so the client can connect to it in the same process.

## Common mistakes

1. **Forgetting real HTTP parsing (headers, chunked encoding, keep-alive) is a lot more than reading raw bytes off a socket.** This lesson's raw-TCP approach is for understanding the fundamentals, not a suggestion to hand-roll an HTTP server for real use — reach for a real crate (`reqwest` for clients, `axum`/`actix-web` for servers) in production code.
2. **Not setting a read timeout on a `TcpStream`.** Without one, `.read()` can block indefinitely if the peer never sends anything — `stream.set_read_timeout(Some(Duration::from_secs(5)))?` bounds the wait.
3. **Assuming `.read()` returns a complete message in one call.** TCP is a byte stream with no message boundaries — a single `.read()` call may return a partial request/response; real HTTP libraries handle this by reading until they've seen a complete message (per the `Content-Length` header or a terminating sequence).
4. **Binding to a fixed port in tests/examples**, causing failures when run concurrently or when that port is already in use — bind to port `0` and read back the OS-assigned port via `.local_addr()`.

## Exercise

Write `fn send_and_receive(addr: &str, request: &[u8]) -> std::io::Result<Vec<u8>>` that connects to `addr`, writes `request`, and returns whatever bytes come back (read once, into a fixed-size buffer, trimmed to what was actually read).

Try it yourself first, then check [`solutions/exercise_1.rs`](./solutions/exercise_1.rs).

## Interview questions

1. **Why doesn't Rust's standard library include an HTTP client?** — A deliberate scope decision: the standard library focuses on cross-platform primitives (like raw TCP/UDP sockets) and leaves higher-level protocols to the crate ecosystem, which can iterate independently of Rust's release cycle and offer competing designs (sync vs async, different feature sets).
2. **Why bind to port `0` in tests instead of a fixed port number?** — Port `0` asks the OS to assign any free port, avoiding collisions when tests run concurrently or when a fixed port happens to already be in use on the machine running the tests.

---
← [Previous: Testing](../12_testing/README.md) | [Next: Databases →](../14_databases/README.md)

