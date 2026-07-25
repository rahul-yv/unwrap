# Networking and APIs, across 14 languages

Whether the standard library gives you a real HTTP client, only raw TCP sockets, or nothing at all — and what that implies about how each track's `13_networking` lesson had to be built.

## Full HTTP client (and often server) in the standard library

- **Go**: `net/http` covers both client and server, no external dependency — unusually complete for a systems language.
- **Java**: `java.net.http.HttpClient` (11+) for clients, `com.sun.net.httpserver.HttpServer` for a small built-in server.
- **C#**: `System.Net.Http.HttpClient` plus `System.Net.Sockets` for raw TCP, all `async`/`await`-native.
- **Kotlin**: inherits the JVM's `java.net.http.HttpClient` directly — no extra dependency, same as Java.
- **Python**: `urllib.request` (stdlib) works with no dependency, though the ecosystem strongly prefers the third-party `requests` for its friendlier API.
- **JavaScript/TypeScript**: `fetch` is built into modern Node and every browser — no dependency, and increasingly the universal JS networking API regardless of runtime.
- **Ruby**: `Net::HTTP` (stdlib) plus higher-level `open-uri` convenience on top of it.
- **Dart**: `dart:io`'s `HttpClient` is available, though the ecosystem's `http` package is what most projects actually reach for.
- **PHP**: no dedicated HTTP client class, but `file_get_contents()` works directly on a URL for simple GETs (if `allow_url_fopen` is enabled) — genuinely minimal but functional; `curl`/Guzzle for anything more.

## Raw sockets only — no HTTP client at all in stdlib

- **Rust**: deliberately excludes HTTP from `std` — only `TcpListener`/`TcpStream` at the raw socket level; real projects reach for `reqwest`/`hyper`/`axum` via Cargo.
- **Swift**: no networking in the core standard library at all (Apple platforms have `URLSession`/`Network.framework`, but those are Foundation/platform frameworks, not the language's stdlib) — this repo's Swift track drops to raw POSIX sockets (`Glibc`/`Darwin`) specifically to stay cross-platform and dependency-free.
- **C**: no networking in stdlib whatsoever — the OS's POSIX sockets API (`<sys/socket.h>`) is the only option, and it's the literal foundation every other language's networking is ultimately built on.
- **PHP**'s `sockets` extension: closer to C's raw BSD sockets API than to a convenience wrapper — a deliberate low-level choice even though PHP has higher-level HTTP options for the client side.

## The convenience gradient for raw sockets

Even among the "raw sockets only" languages, the ergonomics differ sharply:
- **Ruby**'s `TCPServer`/`TCPSocket` wrap the BSD sockets API far more conveniently than the raw C-level equivalent — no manual `sockaddr` struct plumbing.
- **Go**'s `net` package (which `net/http` sits on top of) is similarly high-level.
- **C, Swift, PHP's `sockets` extension** stay close to the actual C API: manual address structs, explicit `bind`/`listen`/`accept`/`connect` calls, and (for Swift specifically) the added complexity of safely reinterpreting pointer types across the `sockaddr`/`sockaddr_in` boundary.

## Interview-relevant takeaway

"Does this language's standard library include an HTTP client?" is a surprisingly reliable signal of the language's design philosophy: "batteries included" languages (Go, Java, Python, JS, Ruby, C#) say yes; languages that deliberately keep the standard library minimal and push networking (like cryptography, covered in the security comparison) out to the ecosystem (Rust, Swift, C) say no. The same two camps recur across both comparisons — not a coincidence, but a consistent design stance each language takes about what belongs in "the language" versus "a library you choose."

---
← See also: [security.md](./security.md) for the same batteries-included-vs-minimal-stdlib pattern applied to cryptography.
