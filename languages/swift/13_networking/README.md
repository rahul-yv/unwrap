# Networking and APIs

On Apple platforms, real-world Swift networking uses `URLSession` (Foundation) for HTTP and `Network.framework` for lower-level TCP/UDP. For a cross-platform, dependency-free example that runs the same on macOS and Linux CI, this lesson drops to the POSIX sockets API directly (`Glibc` on Linux, `Darwin` on macOS) — the same underlying layer `URLSession`/`Network.framework` are built on.

## Example

```swift
#if canImport(Glibc)
import Glibc
let streamSocketType = Int32(SOCK_STREAM.rawValue)   // Glibc types SOCK_STREAM as an enum, not Int32
#else
import Darwin
let streamSocketType = SOCK_STREAM
#endif

let serverFd = socket(AF_INET, streamSocketType, 0)

var addr = sockaddr_in()
addr.sin_family = sa_family_t(AF_INET)
addr.sin_addr.s_addr = inet_addr("127.0.0.1")
addr.sin_port = 0   // 0: let the OS assign a free port

withUnsafePointer(to: &addr) { ptr in
	ptr.withMemoryRebound(to: sockaddr.self, capacity: 1) { sockaddrPtr in
		_ = bind(serverFd, sockaddrPtr, socklen_t(MemoryLayout<sockaddr_in>.size))
	}
}
listen(serverFd, 1)

// ... connect a client, accept the connection, send/recv bytes ...

close(serverFd)
```

For a real HTTP call on Apple platforms: `let (data, response) = try await URLSession.shared.data(from: url)` — `URLSession.shared` is a reusable, thread-safe singleton appropriate for most apps.

See [`example.swift`](./example.swift) for the full runnable file — a loopback client/server exchange using raw POSIX sockets.

## Common mistakes

1. **Forgetting the `sockaddr_in`/`sockaddr` pointer dance.** POSIX socket functions take a generic `sockaddr*`, but you build the address as a `sockaddr_in`; `withUnsafePointer`/`withMemoryRebound` is Swift's safe way to reinterpret the pointer type for the call, since a raw C-style cast isn't available.
2. **Assuming one `recv` call returns the whole message.** TCP is a byte stream — a message can arrive split across multiple reads; loop until a complete, self-delimited message has been read.
3. **Not checking socket call return values.** Like C, these are low-level POSIX calls that return `-1` on error; Swift doesn't add automatic error handling on top of them the way it does for `throws` functions.
4. **Not closing every socket file descriptor (`close(fd)`) on every exit path**, including error paths — there's no automatic RAII cleanup for raw POSIX handles the way there is for `FileHandle`/`URLSession` on Apple platforms.
5. **Passing `SOCK_STREAM` directly to `socket()` and assuming it type-checks the same on every platform.** On Darwin it's already `Int32`; on Glibc (Linux) it's typed as an enum (`__socket_type`), so it needs `Int32(SOCK_STREAM.rawValue)` — a `#if canImport(Glibc)` constant at the top of the file is the portable fix, same idea as the `Glibc`/`Darwin` import split itself.

## Exercise

Write a function `func echoOnce(port: UInt16, message: String) -> String` that connects to a listening socket on `port`, sends `message`, and returns what comes back.

Try it yourself first, then check [`solutions/exercise_1.swift`](./solutions/exercise_1.swift).

## Interview questions

1. **Why does this lesson use raw POSIX sockets instead of `URLSession`?** — `URLSession` is Foundation's high-level HTTP client, built on top of lower-level networking (ultimately POSIX sockets on Linux, or `Network.framework` on Apple platforms) — it's the right tool for real HTTP/API calls, but doesn't expose raw TCP socket control, and isn't universally available in every Swift environment the same way the POSIX API is. Using POSIX sockets directly here keeps the example portable and shows the layer other networking APIs are ultimately built on.
2. **Why must a message received over TCP potentially be read in a loop rather than a single call?** — TCP delivers a stream of bytes with no message boundaries preserved — a single `recv` may return less than the sender wrote (if it hasn't all arrived yet) or, less commonly, more than one logical message coalesced together. The receiver needs its own framing (length prefix, delimiter, or fixed size) and must loop until that complete frame has been read.

---
← [Previous: Testing](../12_testing/README.md) | [Next: Databases →](../14_databases/README.md)
