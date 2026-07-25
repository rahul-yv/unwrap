# Security Basics

C's standard library has no cryptography. OpenSSL's `libcrypto` (`<openssl/...>`, linked with `-lcrypto`) is the de facto standard: `RAND_bytes` for cryptographically secure random bytes, `PKCS5_PBKDF2_HMAC` for password hashing (PBKDF2 with a chosen HMAC and iteration count), and `CRYPTO_memcmp` for constant-time comparison. Never use `rand()` from `<stdlib.h>` for anything security-sensitive — it's a predictable pseudo-random generator meant for simulations, not secrets.

## Example

```c
#include <openssl/evp.h>
#include <openssl/rand.h>

unsigned char salt[16];
RAND_bytes(salt, sizeof(salt));            // cryptographically secure randomness

unsigned char hash[32];
PKCS5_PBKDF2_HMAC(
	"hunter2", -1,                          // password (-1 = strlen it)
	salt, sizeof(salt),                     // per-password random salt
	200000,                                 // iteration count (deliberately slow)
	EVP_sha256(),                           // HMAC-SHA256
	sizeof(hash), hash);                    // output buffer

// verify by recomputing with the SAME salt and comparing in constant time
int matches = CRYPTO_memcmp(hash, candidate, sizeof(hash)) == 0;
```

Compile with `cc example.c -o example -lcrypto`. See [`example.c`](./example.c) for the full runnable file.

## Common mistakes

1. **Using `rand()` (or `random()`) for salts, tokens, or keys.** These are seeded from predictable sources and designed for statistical distribution, not unpredictability — an attacker who can guess or observe the seed can predict the output. Use `RAND_bytes` (or the OS's `getrandom`/`/dev/urandom`) for anything security-sensitive.
2. **Hashing passwords with a single fast hash (`SHA256_...` directly, unsalted).** A fast hash lets an attacker try billions of guesses per second, and no salt means identical passwords hash identically — PBKDF2 (with a per-password salt and a high iteration count) makes each guess expensive and each hash unique.
3. **Comparing hashes or MACs with `memcmp`.** `memcmp` returns as soon as it finds a differing byte, leaking timing information about how many leading bytes matched; `CRYPTO_memcmp` compares in constant time regardless of where the first difference is.
4. **Choosing too low an iteration count.** The entire point of PBKDF2's iteration count is to make each attempt slow; a low count (some old examples use 1000 or fewer) defeats that — 200,000+ is a reasonable modern floor for SHA-256, and it should increase over time as hardware speeds up.

## Exercise

Write `int hash_password(const char *password, const unsigned char *salt, int salt_len, unsigned char *out, int out_len)` that fills `out` with a PBKDF2-HMAC-SHA256 hash (200,000 iterations), returning `1` on success or `0` on failure (from `PKCS5_PBKDF2_HMAC`'s return value).

Try it yourself first, then check [`solutions/exercise_1.c`](./solutions/exercise_1.c) — compile with `cc solutions/exercise_1.c -o exercise_1 -lcrypto`.

## Interview questions

1. **Why is `rand()` from the C standard library unsafe for generating a salt or token?** — It's a pseudo-random generator seeded from a predictable source (often the current time) and designed for statistical uniformity, not cryptographic unpredictability — its entire output stream can be reproduced by anyone who knows or guesses the seed, so it must never be used for values that need to be secret or unguessable.
2. **Why use `CRYPTO_memcmp` instead of `memcmp` to compare password hashes?** — `memcmp` short-circuits at the first differing byte, so the time it takes reveals how many leading bytes matched — an attacker can exploit that timing to reconstruct a secret byte-by-byte; `CRYPTO_memcmp` always examines the full length, leaking no positional timing information.

---
← [Previous: Concurrency](../15_concurrency/README.md) | [Next: Mini Projects →](../17_projects/README.md)

