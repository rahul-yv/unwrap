# Security Basics

Ruby's `openssl` and `securerandom` standard libraries provide everything needed here without an external gem. `SecureRandom` draws from the OS's cryptographically secure entropy source; `OpenSSL::PKCS5.pbkdf2_hmac` implements PBKDF2, a slow, iteration-tunable password-hashing algorithm; `OpenSSL.fixed_length_secure_compare` compares byte strings in constant time, avoiding timing side-channels. (Real-world Rails apps typically use the `bcrypt` gem via `has_secure_password`, which wraps similar ideas behind a friendlier API.)

## Example

```ruby
require "openssl"
require "securerandom"

ITERATIONS = 100_000
KEY_LENGTH = 32

def hash(password, salt)
  OpenSSL::PKCS5.pbkdf2_hmac(password, salt, ITERATIONS, KEY_LENGTH, "sha256")
end

salt = SecureRandom.random_bytes(16)   # cryptographically secure random salt
hashed = hash("hunter2", salt)

attempt = hash("hunter2", salt)
matches = OpenSSL.fixed_length_secure_compare(hashed, attempt)   # constant-time comparison
```

See [`example.rb`](./example.rb) for the full runnable file.

## Common mistakes

1. **Hashing passwords with a fast general-purpose hash (`Digest::SHA256.hexdigest`) instead of a slow, iterated algorithm.** A fast hash lets an attacker who steals the database try enormous numbers of guesses per second; PBKDF2 (or bcrypt/Argon2 via a gem) is deliberately slow, controlled by the iteration count, making brute-force expensive.
2. **Reusing the same salt across passwords, or omitting a salt entirely.** Without a per-password random salt, identical passwords produce identical hashes, and precomputed rainbow tables become effective; `SecureRandom.random_bytes` generates a fresh, unpredictable salt for each password.
3. **Comparing hashes with `==` instead of `OpenSSL.fixed_length_secure_compare`.** A naive `==` comparison on strings can return as soon as it finds the first differing byte, and the time this takes leaks information about how many leading bytes matched — the constant-time comparison always takes the same time regardless of where a mismatch occurs.
4. **Using `Random.rand`/`Kernel#rand` for anything security-sensitive.** These are fast, statistically-uniform but *predictable* pseudorandom generators, not designed to resist an attacker guessing their internal state — always use `SecureRandom` for salts, tokens, or keys.

## Exercise

Write `def hash_password(password, salt)` using `OpenSSL::PKCS5.pbkdf2_hmac`, and `def verify_password(password, salt, expected_hash)` that re-hashes and compares with `OpenSSL.fixed_length_secure_compare`.

Try it yourself first, then check [`solutions/exercise_1.rb`](./solutions/exercise_1.rb).

## Interview questions

1. **Why is PBKDF2 (or bcrypt/Argon2) preferred over a plain salted SHA-256 for password storage?** — These algorithms are deliberately slow, with a tunable cost factor (iteration count for PBKDF2; work factor for bcrypt), making both brute-force and hardware-accelerated attacks far more expensive per guess. A single fast hash like SHA-256, even salted, can be computed billions of times per second on modern hardware, making stolen hashes crackable quickly.
2. **Why does comparing two hashes require a constant-time comparison instead of `==`?** — A naive comparison typically short-circuits at the first mismatched byte, so comparing a guess against the real hash takes slightly longer the more leading bytes match. Measuring that timing difference over many attempts lets an attacker reconstruct the hash byte by byte. `OpenSSL.fixed_length_secure_compare` always examines the full length regardless of mismatches, so the timing reveals nothing.

---
← [Previous: Concurrency](../15_concurrency/README.md) | [Next: Mini Projects →](../17_projects/README.md)
