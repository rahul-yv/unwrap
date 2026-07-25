# Networking and APIs

C has no networking in its standard library — networking is provided by the operating system. On Unix-like systems (Linux, macOS, BSD), that's the POSIX sockets API (`<sys/socket.h>`, `<netinet/in.h>`): `socket`, `bind`, `listen`, `accept`, `connect`, `send`, `recv`. This is the low-level foundation every higher-level networking library in every language is ultimately built on top of. (Windows uses a very similar but separate API, Winsock.)

## Example

```c
#include <sys/socket.h>
#include <netinet/in.h>
#include <unistd.h>

int server = socket(AF_INET, SOCK_STREAM, 0);   // TCP socket

struct sockaddr_in addr = {0};
addr.sin_family = AF_INET;
addr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);   // 127.0.0.1
addr.sin_port = 0;                                // 0 = let the OS pick a free port

bind(server, (struct sockaddr *)&addr, sizeof(addr));
listen(server, 1);

// a client connects, the server accept()s, then both send()/recv() bytes
```

See [`example.c`](./example.c) for the full runnable file — it creates a listening socket, connects a client to it, and exchanges bytes, all within one process (the server accepts on the same thread after the client connects to a non-blocking-friendly setup).

## Common mistakes

1. **Forgetting to convert byte order with `htons`/`htonl`.** Network protocols use big-endian ("network byte order"); most machines are little-endian. Port numbers and IPv4 addresses must be converted with `htons` (host-to-network short) / `htonl` (long) when filling in `sockaddr_in`, or you'll connect to the wrong port/address.
2. **Not checking the return value of every socket call.** `socket`, `bind`, `connect`, `accept`, `send`, `recv` all return `-1` on error (and set `errno`) — skipping the checks means a failure surfaces as a confusing crash later instead of at the point it happened.
3. **Assuming `recv` returns a whole message.** TCP is a byte stream with no message boundaries — one `recv` may return part of what was sent, or several sends coalesced; real protocols loop until they've read a complete message (by length prefix or delimiter).
4. **Forgetting to `close` sockets.** A socket is a file descriptor — like `FILE *` or heap memory, leaking it exhausts a finite resource; `close(fd)` releases it.

## Exercise

Write `int send_all(int fd, const char *data, int len)` that writes all `len` bytes of `data` to socket `fd`, looping over `send` until everything is written (since a single `send` may write fewer bytes than requested), returning `0` on success or `-1` on error.

Try it yourself first, then check [`solutions/exercise_1.c`](./solutions/exercise_1.c).

## Interview questions

1. **Why do port numbers and IP addresses need `htons`/`htonl` when filling in a `sockaddr_in`?** — The network uses big-endian byte order by convention ("network byte order"), but the host CPU may be little-endian; these macros convert host byte order to network byte order (and are no-ops on big-endian machines), ensuring the bytes are interpreted correctly by the other end regardless of either machine's native endianness.
2. **Why might a single `send` write fewer bytes than you asked it to?** — The socket's send buffer may be partially full, so the kernel accepts only part of the data and returns how much it took; correct code loops, advancing past the bytes already sent, until the entire buffer is written — which is exactly what a `send_all` helper does.

---
← [Previous: Testing](../12_testing/README.md) | [Next: Databases →](../14_databases/README.md)

