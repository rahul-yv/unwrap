# Security Basics

Rust's standard library has no cryptography at all — no secure random, no hashing. This lesson uses `argon2` (a pure-Rust implementation of the Argon2 password-hashing algorithm, the current recommended default over bcrypt/PBKDF2 in most new projects) plus `rand_core`'s `OsRng` (draws from the OS's cryptographically secure entropy source). Like the databases and networking topics, this one needs `Cargo`.

## Example

```rust
use argon2::password_hash::{rand_core::OsRng, PasswordHasher, SaltString};
use argon2::{Argon2, PasswordHash, PasswordVerifier};

let salt = SaltString::generate(&mut OsRng);
let argon2 = Argon2::default();
let hash = argon2.hash_password(b"hunter2", &salt)?.to_string();
// `hash` is a self-contained string encoding the algorithm, salt, and digest together

let parsed_hash = PasswordHash::new(&hash)?;
let matches = argon2.verify_password(b"hunter2", &parsed_hash).is_ok();
```

See [`example.rs`](./example.rs) for the full runnable file.

## Common mistakes

1. **Using `rand::thread_rng()` (the general-purpose, non-cryptographic-by-contract RNG in some setups) for security-sensitive randomness** instead of explicitly reaching for `OsRng`. Always use a generator documented as cryptographically secure for salts, tokens, or keys.
2. **Hashing passwords with a fast general-purpose hash (`sha2::Sha256`) instead of Argon2/bcrypt/scrypt.** A fast hash lets an attacker who steals the database try enormous numbers of guesses per second; Argon2 is deliberately slow and memory-hard, making brute-force expensive.
3. **Managing the salt separately from the hash.** Argon2's output string (the "PHC string format") already embeds the salt, algorithm parameters, and digest together — there's no separate salt value to store or pass around; `PasswordHash::new` parses all of it back out.
4. **Comparing password hashes yourself with `==`** instead of using the library's `verify_password`, which performs the comparison in a way that avoids leaking timing information — don't hand-roll what the crate already does correctly.

## Exercise

Write `fn hash_password(password: &str) -> String` using `Argon2::default().hash_password`, and `fn verify_password(password: &str, hash: &str) -> bool` using `PasswordHash::new` + `.verify_password`.

Try it yourself first, then check [`solutions/exercise_1.rs`](./solutions/exercise_1.rs).

## Interview questions

1. **Why is Argon2 generally recommended over a plain salted SHA-256 for password storage?** — Argon2 is deliberately slow and memory-hard (tunable via its cost parameters), making both brute-force and GPU/ASIC-accelerated attacks far more expensive per guess; a fast hash like SHA-256, even salted, can be tried billions of times per second on modern hardware.
2. **What does the Argon2 hash string actually contain?** — The algorithm variant and version, its cost parameters (memory, iterations, parallelism), the salt, and the derived hash — all encoded together in one self-describing string (the PHC string format), so verification doesn't need any separately-stored metadata.

---
← [Previous: Concurrency](../15_concurrency/README.md) | [Next: Mini Projects →](../17_projects/README.md)

