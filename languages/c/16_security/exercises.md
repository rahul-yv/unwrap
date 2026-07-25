# Exercises: Security Basics

1. Write `int hash_password(const char *password, const unsigned char *salt, int salt_len, unsigned char *out, int out_len)` filling `out` with a PBKDF2-HMAC-SHA256 hash (200,000 iterations), returning `1` on success or `0` on failure.

Compile with `cc solutions/exercise_1.c -o exercise_1 -lcrypto`.

Check your answer against [`solutions/exercise_1.c`](./solutions/exercise_1.c).
