# Networking and APIs

PHP's `sockets` extension exposes the BSD sockets API (`socket_create`, `socket_bind`, `socket_listen`, `socket_connect`) directly, close to the underlying C interface. For higher-level HTTP client calls, real-world PHP typically uses `curl` (via the `curl` extension) or Guzzle (a Composer package); for a quick one-off GET, the `file_get_contents()` function even works directly on a URL if `allow_url_fopen` is enabled.

## Example

```php
<?php
$server = socket_create(AF_INET, SOCK_STREAM, SOL_TCP);
socket_bind($server, "127.0.0.1", 0);   // 0: let the OS assign a free port
socket_listen($server, 1);
socket_getsockname($server, $addr, $port);

$client = socket_create(AF_INET, SOCK_STREAM, SOL_TCP);
socket_connect($client, "127.0.0.1", $port);

$conn = socket_accept($server);

socket_write($client, "ping");
$received = socket_read($conn, 16);   // "ping"

socket_close($client);
socket_close($conn);
socket_close($server);
```

For a quick HTTP GET: `$body = file_get_contents("https://example.com/api");` (simple, but offers no control over headers/timeouts); `curl_init()`/`curl_setopt()`/`curl_exec()` is the standard choice when more control is needed.

See [`example.php`](./example.php) for the full runnable file — a loopback client/server exchange using the `sockets` extension.

## Common mistakes

1. **Not checking `socket_create`/`socket_bind`/etc. return values for `false`.** Like much of PHP's older extension-based API, socket functions signal failure by returning `false` (retrievable error details via `socket_last_error()`/`socket_strerror()`), not by throwing — silently continuing after a failed call leads to a confusing failure later.
2. **Assuming one `socket_read` call returns the whole message.** TCP is a byte stream — a message can arrive split across multiple reads; loop until a complete, self-delimited message has been read.
3. **Using `file_get_contents()` on a URL for anything beyond a quick, low-stakes GET.** It has no built-in timeout control, limited error handling (a failed request just returns `false`, indistinguishable from other failure modes without checking `$http_response_header`), and no easy way to set custom headers or handle redirects explicitly — `curl` is the standard choice once any of that matters.
4. **Not closing every socket (`socket_close()`) on every exit path**, including error paths — there's no automatic cleanup for these low-level resource handles.

## Exercise

Write a function `function echoOnce(int $port, string $message): string` that connects to a listening socket on `$port`, sends `$message`, and returns what comes back. The solution's test harness uses `pcntl_fork()` to run a real listening server concurrently, since exercising a blocking client function end-to-end needs something else actively accepting the connection at the same time.

Try it yourself first, then check [`solutions/exercise_1.php`](./solutions/exercise_1.php).

## Interview questions

1. **Why might a real PHP application use `curl` instead of `file_get_contents()` for HTTP calls?** — `curl` provides fine-grained control (timeouts, custom headers, following redirects explicitly, connection reuse, detailed error codes) that `file_get_contents()` on a URL doesn't expose — the latter is convenient for a quick script but lacks the robustness (and clear failure diagnostics) a production HTTP client needs.
2. **Why must a message received over TCP potentially be read in a loop rather than a single call?** — TCP delivers a stream of bytes with no message boundaries preserved — a single `socket_read` may return less than the sender wrote (if it hasn't all arrived yet) or, less commonly, more than one logical message coalesced together. The receiver needs its own framing (length prefix, delimiter, or fixed size) and must loop until that complete frame has been read.

---
← [Previous: Testing](../12_testing/README.md) | [Next: Databases →](../14_databases/README.md)
