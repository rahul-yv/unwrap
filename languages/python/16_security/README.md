# Security Basics

A few stdlib-backed habits prevent most common vulnerabilities: `secrets` for anything security-sensitive (tokens, passwords) instead of `random`, `hashlib` with a proper salted algorithm for password storage, parameterized queries for SQL (see `14_databases`), and never `eval`/`exec` on untrusted input.

## Example

```python
import hashlib
import hmac
import secrets

salt = secrets.token_bytes(16)
password = "correct horse battery staple"
digest = hashlib.pbkdf2_hmac("sha256", password.encode(), salt, 200_000)

# verifying later:
candidate_digest = hashlib.pbkdf2_hmac("sha256", password.encode(), salt, 200_000)
hmac.compare_digest(digest, candidate_digest)   # True — constant-time comparison
```

See [`example.py`](./example.py) for the full runnable file.

## Common mistakes

1. **Using `random` for tokens, passwords, or session IDs.** `random` is not cryptographically secure and is predictable given enough output; use `secrets.token_bytes`/`secrets.token_hex` for anything security-sensitive.
2. **Storing passwords in plain text or with a fast, unsalted hash (`md5`, plain `sha256`).** Fast hashes are cheap to brute-force at scale; use a slow, salted key-derivation function (`pbkdf2_hmac`, or `bcrypt`/`argon2` from a third-party library) with a unique salt per password.
3. **Comparing secrets with `==`.** String `==` short-circuits on the first mismatched byte, leaking timing information an attacker can use to guess a secret byte-by-byte. Use `hmac.compare_digest` for constant-time comparison.
4. **Calling `eval()`/`exec()` on any input that isn't fully trusted** — this is arbitrary code execution. If you need to parse structured data, use `json.loads` or `ast.literal_eval` for Python literals, never `eval`.

## Exercise

Write `hash_password(password)` returning `(salt, digest)` using `secrets.token_bytes(16)` and `hashlib.pbkdf2_hmac("sha256", ..., 200_000)`, and `verify_password(password, salt, digest)` that recomputes the digest and compares it with `hmac.compare_digest`.

Try it yourself first, then check [`solutions/exercise_1.py`](./solutions/exercise_1.py).

## Interview questions

1. **Why salt a password hash?** — Without a salt, identical passwords produce identical hashes, so an attacker with a precomputed table (rainbow table) can crack many accounts at once; a unique salt per password defeats precomputed tables.
2. **Why is a fast hash function (MD5, SHA-256 alone) a bad choice for password storage?** — Fast hashes let an attacker who steals the hash database try billions of guesses per second; a deliberately slow KDF (PBKDF2, bcrypt, argon2) makes brute-forcing far more expensive per guess.
3. **What's a timing attack, and how does `hmac.compare_digest` defend against it?** — An attacker measures how long a comparison takes to infer how many leading bytes matched; `compare_digest` always takes the same time regardless of where the mismatch occurs, leaking no positional information.

---
← [Previous: Concurrency](../15_concurrency/README.md) | [Next: Mini Projects →](../17_projects/README.md)
