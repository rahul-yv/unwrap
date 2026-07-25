# Exercises: Networking and APIs

1. Write an RAII `class Socket` (takes an fd, closes it in the destructor, non-copyable, with a `get()`). Use it in a loopback client/server that sends `"ping"` and receives it back.

Check your answer against [`solutions/exercise_1.cpp`](./solutions/exercise_1.cpp).
