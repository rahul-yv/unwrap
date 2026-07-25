# Networking and APIs

C#'s `System.Net.Sockets` (`TcpListener`/`TcpClient`) gives direct access to TCP, while `System.Net.Http.HttpClient` is the standard way to call web APIs. Both are built around `async`/`await` from the start — `AcceptTcpClientAsync`, `ReadAsync`, `GetStringAsync` all return `Task`/`Task<T>`, so I/O-bound networking code never blocks a thread waiting on the network.

## Example

```csharp
using System.Net;
using System.Net.Sockets;
using System.Text;

var listener = new TcpListener(IPAddress.Loopback, 0);
listener.Start();
int port = ((IPEndPoint)listener.LocalEndpoint).Port;

var serverTask = Task.Run(async () => {
	using var conn = await listener.AcceptTcpClientAsync();
	using var stream = conn.GetStream();
	var buffer = new byte[16];
	int read = await stream.ReadAsync(buffer);
	await stream.WriteAsync(buffer.AsMemory(0, read));   // echo it back
});

using var client = new TcpClient();
await client.ConnectAsync(IPAddress.Loopback, port);
using var clientStream = client.GetStream();
byte[] message = Encoding.UTF8.GetBytes("ping");
await clientStream.WriteAsync(message);

var response = new byte[16];
int n = await clientStream.ReadAsync(response);
string text = Encoding.UTF8.GetString(response, 0, n);   // "ping"

await serverTask;
listener.Stop();
```

For calling a real HTTP API: `using var http = new HttpClient(); string body = await http.GetStringAsync(url);` — `HttpClient` handles connection pooling internally, so a single shared instance should live for the app's lifetime rather than being created per request.

See [`example.cs`](./example.cs) for the full runnable file — a loopback client/server exchange using `TcpListener`/`TcpClient`.

## Common mistakes

1. **Creating a new `HttpClient` per request.** Each instance owns its own connection pool; creating and disposing many of them exhausts sockets under load (they can linger in `TIME_WAIT`). Share one `HttpClient` (or use `IHttpClientFactory` in ASP.NET Core apps) for the app's lifetime.
2. **Assuming one `ReadAsync` call returns the whole message.** TCP is a byte stream — a message can arrive split across multiple reads, or multiple small messages can arrive coalesced into one read. Loop until a complete, self-delimited message (length-prefixed or newline-terminated) has been read.
3. **Blocking on async networking calls with `.Result` or `.Wait()`.** This can deadlock in contexts with a synchronization context (like older ASP.NET or UI apps) and wastes a thread pool thread even where it doesn't deadlock — `await` all the way up the call stack instead.
4. **Not disposing `TcpClient`/`NetworkStream`/`HttpResponseMessage`.** These wrap OS sockets; `using` (or `using var`) ensures they're released even if an exception is thrown mid-request.

## Exercise

Write an async method `Task<string> EchoOnceAsync(int port, string message)` that connects to a `TcpListener` already listening on `port`, sends `message`, and returns what comes back. Use it against a loopback `TcpListener`/`TcpClient` pair, as in the example.

Try it yourself first, then check [`solutions/exercise_1.cs`](./solutions/exercise_1.cs).

## Interview questions

1. **Why should an app share one `HttpClient` instance instead of creating one per request?** — `HttpClient` pools and reuses underlying TCP connections; creating a new instance per call means a new connection (and socket) each time, which can exhaust available sockets under load since closed sockets linger in `TIME_WAIT`. A shared, long-lived instance (or `IHttpClientFactory`, which also handles DNS-change rotation) avoids this.
2. **Why does `.Result`/`.Wait()` on an async call risk a deadlock in some C# applications?** — In contexts with a captured `SynchronizationContext` (classic ASP.NET, WPF/WinForms UI threads), an awaited `Task`'s continuation tries to resume on that same context by default; blocking that context's only thread with `.Result` while the continuation waits to run on it deadlocks. `await`ing instead of blocking, or awaiting with `ConfigureAwait(false)` in library code, avoids capturing the context.

---
← [Previous: Testing](../12_testing/README.md) | [Next: Databases →](../14_databases/README.md)
