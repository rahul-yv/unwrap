# Security Basics

The JVM's `java.security`/`javax.crypto` packages ship in the standard library — no external dependency needed. `SecureRandom` draws from the OS's cryptographically secure entropy source; `SecretKeyFactory` with `PBKDF2WithHmacSHA256` implements PBKDF2, a slow, iteration-tunable password-hashing algorithm; `MessageDigest.isEqual` compares byte arrays in constant time, avoiding timing side-channels.

## Example

```kotlin
import java.security.MessageDigest
import java.security.SecureRandom
import javax.crypto.SecretKeyFactory
import javax.crypto.spec.PBEKeySpec

const val ITERATIONS = 100_000
const val KEY_LENGTH = 256

fun hash(password: String, salt: ByteArray): ByteArray {
	val spec = PBEKeySpec(password.toCharArray(), salt, ITERATIONS, KEY_LENGTH)
	val factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256")
	return factory.generateSecret(spec).encoded
}

val salt = ByteArray(16).also { SecureRandom().nextBytes(it) }   // cryptographically secure random salt
val hashed = hash("hunter2", salt)

val attempt = hash("hunter2", salt)
val matches = MessageDigest.isEqual(hashed, attempt)   // constant-time comparison
```

See [`example.kt`](./example.kt) for the full runnable file.

## Common mistakes

1. **Hashing passwords with a fast general-purpose hash (`MessageDigest.getInstance("SHA-256")`) instead of a slow, iterated algorithm.** A fast hash lets an attacker who steals the database try enormous numbers of guesses per second; PBKDF2 (or Argon2/bcrypt via a library) is deliberately slow, controlled by the iteration count, making brute-force expensive.
2. **Reusing the same salt across passwords, or omitting a salt entirely.** Without a per-password random salt, identical passwords produce identical hashes, and precomputed rainbow tables become effective; `SecureRandom` generates a fresh, unpredictable salt for each password.
3. **Comparing hashes with `contentEquals` or `==` instead of a constant-time comparison.** A naive comparison can return as soon as it finds the first differing byte, and the time this takes leaks information about how many leading bytes matched. `MessageDigest.isEqual` always takes the same time regardless of where a mismatch occurs.
4. **Using `java.util.Random` (or `kotlin.random.Random`) for anything security-sensitive.** These are fast, statistically-uniform but *predictable* pseudorandom generators, not designed to resist an attacker guessing their internal state — always use `SecureRandom` for salts, tokens, or keys.

## Exercise

Write `fun hashPassword(password: String, salt: ByteArray): ByteArray` using `PBEKeySpec`/`SecretKeyFactory`, and `fun verifyPassword(password: String, salt: ByteArray, expectedHash: ByteArray): Boolean` that re-hashes and compares with `MessageDigest.isEqual`.

Try it yourself first, then check [`solutions/exercise_1.kt`](./solutions/exercise_1.kt).

## Interview questions

1. **Why is PBKDF2 (or Argon2/bcrypt) preferred over a plain salted SHA-256 for password storage?** — These algorithms are deliberately slow, with a tunable cost factor (iteration count for PBKDF2; memory and time cost for Argon2), making both brute-force and hardware-accelerated attacks far more expensive per guess. A single fast hash like SHA-256, even salted, can be computed billions of times per second on modern hardware, making stolen hashes crackable quickly.
2. **Why does comparing two hashes require a constant-time comparison instead of `contentEquals`?** — A naive byte-by-byte comparison typically short-circuits at the first mismatch, so comparing a guess against the real hash takes slightly longer the more leading bytes match. Measuring that timing difference over many attempts lets an attacker reconstruct the hash byte by byte. A constant-time comparison always examines every byte regardless of mismatches, so the timing reveals nothing.

---
← [Previous: Concurrency](../15_concurrency/README.md) | [Next: Mini Projects →](../17_projects/README.md)
