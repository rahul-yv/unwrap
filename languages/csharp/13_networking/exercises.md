# Exercises: Networking and APIs

1. Write an async method `Task<string> EchoOnceAsync(int port, string message)` that connects to a `TcpListener` already listening on `port`, sends `message`, and returns what comes back. Use it against a loopback `TcpListener`/`TcpClient` pair.

Check your answer against [`solutions/exercise_1.cs`](./solutions/exercise_1.cs).
