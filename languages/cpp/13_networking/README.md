# Networking and APIs

Like C, C++'s standard library has no networking — you use the operating system's POSIX sockets API (`<sys/socket.h>`) on Unix-like systems. What C++ adds is the ability to wrap a raw socket file descriptor in an **RAII class** so it's closed automatically when the object goes out of scope — turning C's error-prone manual `close()` into something the compiler guarantees. (Higher-level C++ networking uses libraries like Boost.Asio or, eventually, the proposed networking TS.)

## Example

```cpp
#include <sys/socket.h>
#include <unistd.h>

// RAII wrapper: the destructor closes the fd, so no manual close() to forget
class Socket {
public:
	explicit Socket(int fd) : fd_(fd) {}
	~Socket() { if (fd_ >= 0) ::close(fd_); }
	Socket(const Socket&) = delete;             // non-copyable (a fd shouldn't be double-closed)
	Socket& operator=(const Socket&) = delete;
	int get() const { return fd_; }
private:
	int fd_;
};

Socket server(::socket(AF_INET, SOCK_STREAM, 0));
// ... bind/listen/accept using server.get() ...
// when `server` goes out of scope, its destructor closes the fd automatically
```

See [`example.cpp`](./example.cpp) for the full runnable file — a loopback client/server exchange using an RAII `Socket` wrapper.

## Common mistakes

1. **Wrapping a resource in RAII but forgetting to disable copying.** If a `Socket` (holding an `int` fd) is copyable with the default copy constructor, copying it and letting both copies destruct calls `close()` on the same fd twice (a double-close bug). Delete the copy operations (or implement proper move semantics) for any RAII type owning a unique resource.
2. **Forgetting `htons`/`htonl` for port and address byte order** — the same network-byte-order requirement as C; a value stored in host byte order will be misinterpreted by the other end.
3. **Assuming one `recv`/`read` returns a complete message** — TCP is a byte stream; loop until you've read a full message, exactly as in C.
4. **Not checking return values of socket calls** — they return `-1` on error; C++ doesn't change that (these are C APIs), so the checks are still your responsibility unless you wrap them to throw.

## Exercise

Write an RAII `class Socket` (as above: takes an fd, closes it in the destructor, non-copyable, with a `get()`). Then use it in a loopback client/server that sends `"ping"` and receives it. Package the send-and-receive into `std::string echo_once(int port, const std::string& message)` if you like, or inline it in `main`.

Try it yourself first, then check [`solutions/exercise_1.cpp`](./solutions/exercise_1.cpp).

## Interview questions

1. **How does wrapping a socket file descriptor in an RAII class improve on C's raw socket handling?** — The wrapper's destructor calls `close()` automatically when the object leaves scope (including via an exception), so the file descriptor can't be leaked by a forgotten `close()` or an early return — the same safety RAII brings to memory and files, applied to OS handles.
2. **Why must an RAII type that owns a unique resource (like a file descriptor) disable or carefully define copying?** — The default copy just copies the handle value, so two objects end up "owning" the same resource; when both destruct, the resource is released twice (double-close / double-free) — undefined behavior. Such types should be non-copyable (deleted copy operations) or implement move semantics that transfer ownership.

---
← [Previous: Testing](../12_testing/README.md) | [Next: Databases →](../14_databases/README.md)

