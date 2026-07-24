# Security Basics

Node's built-in `node:crypto` module covers the essentials: `crypto.randomBytes`/`randomUUID` for secure randomness, `crypto.scrypt`/`pbkdf2` for password hashing, and `crypto.timingSafeEqual` for constant-time comparison. Never build these yourself with `Math.random()` or a fast general-purpose hash.

## Example

```javascript
const crypto = require("node:crypto");

const salt = crypto.randomBytes(16);
const password = "correct horse battery staple";

const digest = crypto.scryptSync(password, salt, 64);

// verifying later:
const candidate = crypto.scryptSync(password, salt, 64);
crypto.timingSafeEqual(digest, candidate);   // true — constant-time comparison
```

See [`example.js`](./example.js) for the full runnable file.

## Common mistakes

1. **Using `Math.random()` for tokens, passwords, or session IDs.** It's not cryptographically secure and is predictable given enough output; use `crypto.randomBytes`/`crypto.randomUUID` for anything security-sensitive.
2. **Storing passwords with a fast, unsalted hash (`crypto.createHash("sha256")` alone).** Fast general-purpose hashes are cheap to brute-force at scale; use a slow, salted KDF (`scrypt`, or `bcrypt`/`argon2` from a package) with a unique salt per password.
3. **Comparing secrets with `===`.** String equality short-circuits on the first mismatch, leaking timing information. Use `crypto.timingSafeEqual` for constant-time comparison of buffers of equal length.
4. **Interpolating untrusted input directly into HTML** (building markup with template literals from user data) — this is a stored/reflected XSS vulnerability. Escape or use a templating system that auto-escapes by default.

## Exercise

Write `hashPassword(password)` returning `{ salt, digest }` using `crypto.randomBytes(16)` and `crypto.scryptSync(password, salt, 64)`, and `verifyPassword(password, salt, digest)` that recomputes the digest and compares with `crypto.timingSafeEqual`.

Try it yourself first, then check [`solutions/exercise_1.js`](./solutions/exercise_1.js).

## Interview questions

1. **Why salt a password hash?** — Without a salt, identical passwords produce identical hashes, letting an attacker crack many accounts at once with a precomputed table; a unique salt per password defeats that.
2. **Why is `scrypt`/`bcrypt` preferred over plain SHA-256 for password storage?** — They're deliberately slow and memory-hard, making brute-force attempts expensive per guess; a fast hash lets an attacker who steals the database try billions of guesses per second.
3. **What does `crypto.timingSafeEqual` protect against, and what's a requirement for using it?** — Protects against timing attacks that infer how many leading bytes matched by measuring comparison time; it requires both buffers to be the same length (throws otherwise), so length must be checked/normalized separately.

---
← [Previous: Concurrency](../15_concurrency/README.md) | [Next: Mini Projects →](../17_projects/README.md)
