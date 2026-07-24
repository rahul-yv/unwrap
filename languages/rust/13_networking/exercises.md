# Exercises: Networking and APIs

1. Write `fn send_and_receive(addr: &str, request: &[u8]) -> std::io::Result<Vec<u8>>` connecting to `addr`, writing `request`, and returning the bytes read back (a single `.read()` into a fixed buffer, trimmed to the actual bytes read).

Check your answer against [`solutions/exercise_1.rs`](./solutions/exercise_1.rs).
