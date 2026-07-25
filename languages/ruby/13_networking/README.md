# Networking and APIs

Ruby's `socket` standard library provides high-level classes (`TCPServer`, `TCPSocket`, `UDPSocket`) that wrap the raw BSD sockets API far more conveniently than the equivalent in most other languages — `TCPServer.new`/`.accept` and `TCPSocket.new` handle the address-struct plumbing entirely internally. For HTTP calls, `Net::HTTP` (also stdlib) or the `open-uri` library (`URI.open`, layered on `Net::HTTP`) cover most needs without an external gem.

## Example

```ruby
require "socket"

server = TCPServer.new("127.0.0.1", 0)   # 0: let the OS assign a free port
port = server.addr[1]

client = TCPSocket.new("127.0.0.1", port)
conn = server.accept

client.write("ping")
received = conn.read(4)   # "ping"

client.close
conn.close
server.close
```

For a quick HTTP GET: `require "net/http"; body = Net::HTTP.get(URI("https://example.com/api"))`.

See [`example.rb`](./example.rb) for the full runnable file — a loopback client/server exchange using `TCPServer`/`TCPSocket`.

## Common mistakes

1. **Calling `.read(n)` and assuming it always returns exactly `n` bytes.** Like any TCP stream read, `.read(n)` may return fewer bytes if that's all that has arrived so far (though Ruby's `IO#read` with a length argument does block until either `n` bytes are read or EOF, which is more forgiving than some languages' single-`recv` semantics — but the underlying TCP delivery is still not message-boundary-aware).
2. **Not closing sockets (`client.close`, `conn.close`, `server.close`) on every exit path**, including error paths — each wraps an OS file descriptor that isn't automatically released without an explicit `close` (or a block form, where available).
3. **Using `open-uri`/`Net::HTTP.get` for anything beyond a quick, low-stakes GET.** They're convenient for simple cases but offer limited control over timeouts, headers, and error handling compared to constructing a `Net::HTTP` object directly (or using a gem like Faraday/HTTParty for more complex API clients).
4. **Forgetting `TCPServer.new(host, 0)` with port `0` means "let the OS pick a free port"** — the actual assigned port must be read back via `server.addr[1]` (or `server.local_address.ip_port`) rather than assumed.

## Exercise

Write a method `def echo_once(port, message)` that connects to a listening `TCPServer` on `port`, sends `message`, and returns what comes back.

Try it yourself first, then check [`solutions/exercise_1.rb`](./solutions/exercise_1.rb).

## Interview questions

1. **What does `TCPServer.new(host, 0)` do, and how do you find out which port was actually assigned?** — Passing `0` as the port tells the OS to bind to any currently-free ephemeral port rather than a specific one — useful for tests or short-lived servers that don't need a fixed, well-known port. The actual assigned port is read back afterward via `server.addr[1]` (the second element of the address array) or `server.local_address.ip_port`.
2. **Why might `Net::HTTP` be preferred over `open-uri`'s `URI.open` for a production HTTP client?** — `open-uri` is convenient for a quick script but offers less direct control over connection reuse, timeouts, custom headers, and detailed error handling; constructing a `Net::HTTP` object explicitly (or using a dedicated HTTP client gem) gives finer control appropriate for a production service making many requests reliably.

---
← [Previous: Testing](../12_testing/README.md) | [Next: Databases →](../14_databases/README.md)
