# Security Basics

`java.security.SecureRandom` (stdlib) generates cryptographically secure random bytes — never `java.util.Random` for anything security-sensitive, its default algorithm is a predictable PRNG. Unlike some languages, the JDK's stdlib actually includes a proper slow password-hashing KDF: `SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256")` — no third-party dependency needed.

## Example

```java
byte[] salt = new byte[16];
new SecureRandom().nextBytes(salt);

PBEKeySpec spec = new PBEKeySpec("hunter2".toCharArray(), salt, 200_000, 256);
SecretKeyFactory factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256");
byte[] hash = factory.generateSecret(spec).getEncoded();

// verifying later, with the same salt and iteration count:
boolean matches = MessageDigest.isEqual(hash, candidateHash);   // constant-time comparison
```

See [`Example.java`](./Example.java) for the full runnable file.

## Common mistakes

1. **Using `java.util.Random` for tokens, passwords, or session IDs.** Its default seeding/algorithm is not cryptographically secure and can be predictable; always `SecureRandom` for anything security-sensitive.
2. **Hashing passwords with a fast general-purpose digest (`MessageDigest.getInstance("SHA-256")`) alone, unsalted.** A fast hash lets an attacker who steals the database try billions of guesses per second, and no salt means identical passwords produce identical hashes; `PBKDF2` (or `bcrypt`/`argon2` from a library) with a per-password salt and a high iteration count addresses both.
3. **Comparing password hashes or tokens with `Arrays.equals`/`==` instead of a constant-time comparison.** `Arrays.equals` short-circuits on the first differing byte, leaking timing information; `MessageDigest.isEqual` is specifically documented to run in constant time for this purpose.
4. **Choosing too low an iteration count for PBKDF2.** The whole point of the iteration count is to make each guess expensive — a low count (the historical default in some old examples) defeats that; 200,000+ is a reasonable modern floor, and it should increase over time as hardware gets faster.

## Exercise

Write `byte[] hashPassword(String password, byte[] salt)` using `PBKDF2WithHmacSHA256` with 200,000 iterations and a 256-bit key length, and `boolean verifyPassword(String password, byte[] salt, byte[] expectedHash)` comparing with `MessageDigest.isEqual`.

Try it yourself first, then check [`solutions/Exercise1.java`](./solutions/Exercise1.java).

## Interview questions

1. **Why is `PBKDF2` (or `bcrypt`/`argon2`) preferred over a single fast hash for passwords?** — These are deliberately slow, tunable (via iteration count/cost factor) functions, making brute-force guessing expensive per attempt — a fast general-purpose hash lets an attacker try enormous numbers of guesses per second once they have the hash.
2. **What does `MessageDigest.isEqual` guarantee that a manual byte-by-byte loop or `Arrays.equals` doesn't?** — It's documented to compare in time proportional to the length of the arrays, not to where the first mismatch occurs, preventing an attacker from using response-time differences to guess a secret byte-by-byte.

---
← [Previous: Concurrency](../15_concurrency/README.md) | [Next: Mini Projects →](../17_projects/README.md)
