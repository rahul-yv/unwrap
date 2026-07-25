# Exercises: Networking and APIs

1. Write `int send_all(int fd, const char *data, int len)` that writes all `len` bytes of `data` to socket `fd`, looping over `send` until everything is written (a single `send` may write fewer bytes than requested). Return `0` on success, `-1` on error.

Check your answer against [`solutions/exercise_1.c`](./solutions/exercise_1.c).
