# Security Basics

C++'s standard library has no cryptography, so — like C — the standard choice is OpenSSL's `libcrypto` (`<openssl/...>`, linked with `-lcrypto`): `RAND_bytes` for secure random bytes, `PKCS5_PBKDF2_HMAC` for password hashing, `CRYPTO_memcmp` for constant-time comparison. C++ can wrap the results in `std::vector<unsigned char>` / `std::string` for safer, RAII-managed buffers than raw C arrays. Never use `std::rand()` (or the old `rand()`) for anything security-sensitive.

## Example

```cpp
#include <openssl/evp.h>
#include <openssl/rand.h>
#include <vector>

std::vector<unsigned char> salt(16);
RAND_bytes(salt.data(), static_cast<int>(salt.size()));

std::vector<unsigned char> hash(32);
PKCS5_PBKDF2_HMAC(
	"hunter2", -1,                              // password
	salt.data(), static_cast<int>(salt.size()),
	200000,                                     // iterations (deliberately slow)
	EVP_sha256(),
	static_cast<int>(hash.size()), hash.data());

// verify by recomputing with the SAME salt and comparing in constant time
bool matches = CRYPTO_memcmp(hash.data(), candidate.data(), hash.size()) == 0;
```

Compile with `c++ example.cpp -o example -lcrypto`. See [`example.cpp`](./example.cpp) for the full runnable file.

## Common mistakes

1. **Using `std::rand()` / `rand()` for salts, tokens, or keys.** It's a predictable pseudo-random generator, not cryptographically secure — use `RAND_bytes` (or C++'s `std::random_device` only if documented as non-deterministic on your platform, which isn't guaranteed) for security-sensitive randomness.
2. **Hashing passwords with a single fast hash, unsalted.** A fast hash is cheap to brute-force and unsalted hashes are identical for identical passwords — use PBKDF2 (or bcrypt/argon2) with a per-password salt and a high iteration count.
3. **Comparing hashes with `==` / `std::memcmp` / `std::equal`.** These short-circuit at the first difference, leaking timing information; `CRYPTO_memcmp` compares in constant time.
4. **Too low a PBKDF2 iteration count.** The iteration count is the deliberate cost that makes brute-forcing expensive — 200,000+ is a reasonable modern floor for SHA-256, increasing over time.

## Exercise

Write `std::vector<unsigned char> hash_password(const std::string& password, const std::vector<unsigned char>& salt)` returning a 32-byte PBKDF2-HMAC-SHA256 hash (200,000 iterations).

Try it yourself first, then check [`solutions/exercise_1.cpp`](./solutions/exercise_1.cpp) — compile with `c++ solutions/exercise_1.cpp -o exercise_1 -lcrypto`.

## Interview questions

1. **Why prefer `std::vector<unsigned char>` over a raw `unsigned char[]` when working with cryptographic buffers in C++?** — The vector manages its own memory (RAII — no manual allocation/free, no fixed-size-array bounds mistakes), knows its own size (so you pass `.size()` rather than tracking a length separately), and integrates with the rest of the standard library — reducing the buffer-handling errors that raw arrays invite, while still exposing `.data()` for the C OpenSSL API.
2. **Why is `CRYPTO_memcmp` used instead of `std::memcmp` or `==` for comparing password hashes?** — `std::memcmp`/`==` return as soon as they find a differing byte, so their timing reveals how many leading bytes matched — an attacker can exploit that to reconstruct a secret; `CRYPTO_memcmp` always compares the full length in constant time, leaking no positional information.

---
← [Previous: Concurrency](../15_concurrency/README.md) | [Next: Mini Projects →](../17_projects/README.md)
