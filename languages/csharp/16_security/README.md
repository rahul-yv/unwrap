# Security Basics

`System.Security.Cryptography` ships in the base class library — no external package needed. `RandomNumberGenerator` draws from the OS's cryptographically secure entropy source; `Rfc2898DeriveBytes` implements PBKDF2, a slow, iteration-tunable password-hashing algorithm; `CryptographicOperations.FixedTimeEquals` compares byte arrays in constant time, avoiding timing side-channels.

## Example

```csharp
using System.Security.Cryptography;

const int iterations = 100_000;
const int saltSize = 16;
const int hashSize = 32;

byte[] Hash(string password, byte[] salt) =>
	Rfc2898DeriveBytes.Pbkdf2(password, salt, iterations, HashAlgorithmName.SHA256, hashSize);

byte[] salt = RandomNumberGenerator.GetBytes(saltSize);   // cryptographically secure random salt
byte[] hash = Hash("hunter2", salt);

byte[] attempt = Hash("hunter2", salt);
bool matches = CryptographicOperations.FixedTimeEquals(hash, attempt);   // constant-time comparison
```

See [`example.cs`](./example.cs) for the full runnable file.

## Common mistakes

1. **Hashing passwords with a fast general-purpose hash (`SHA256.HashData`) instead of a slow, iterated algorithm.** A fast hash lets an attacker who steals the database try enormous numbers of guesses per second; PBKDF2 (or Argon2/bcrypt via a package) is deliberately slow, controlled by the iteration count, making brute-force expensive.
2. **Reusing the same salt across passwords, or omitting a salt entirely.** Without a per-password random salt, identical passwords produce identical hashes, and precomputed rainbow tables become effective; `RandomNumberGenerator.GetBytes` generates a fresh, unpredictable salt for each password.
3. **Comparing hashes with `==` or `SequenceEqual` instead of a constant-time comparison.** A naive comparison can return as soon as it finds the first differing byte, and the time this takes leaks information about how many leading bytes matched — an attacker can exploit that timing difference. `CryptographicOperations.FixedTimeEquals` always takes the same time regardless of where a mismatch occurs.
4. **Using `System.Random` for anything security-sensitive.** `Random` is a fast, statistically-uniform but *predictable* pseudorandom generator, not designed to resist an attacker guessing its internal state — always use `RandomNumberGenerator` for salts, tokens, or keys.

## Exercise

Write `byte[] HashPassword(string password, byte[] salt)` using `Rfc2898DeriveBytes.Pbkdf2`, and `bool VerifyPassword(string password, byte[] salt, byte[] expectedHash)` that re-hashes and compares with `CryptographicOperations.FixedTimeEquals`.

Try it yourself first, then check [`solutions/exercise_1.cs`](./solutions/exercise_1.cs).

## Interview questions

1. **Why is PBKDF2 (or Argon2/bcrypt) preferred over a plain salted SHA-256 for password storage?** — These algorithms are deliberately slow, with a tunable cost factor (iteration count for PBKDF2; memory and time cost for Argon2), making both brute-force and hardware-accelerated attacks far more expensive per guess. A single fast hash like SHA-256, even salted, can be computed billions of times per second on modern hardware, making stolen hashes crackable quickly.
2. **Why does comparing two hashes require a constant-time comparison instead of `==`?** — A naive byte-by-byte comparison typically short-circuits at the first mismatch, so comparing a guess against the real hash takes slightly longer the more leading bytes match. Measuring that timing difference over many attempts lets an attacker reconstruct the hash byte by byte. A constant-time comparison always examines every byte regardless of mismatches, so the timing reveals nothing.

---
← [Previous: Concurrency](../15_concurrency/README.md) | [Next: Mini Projects →](../17_projects/README.md)
