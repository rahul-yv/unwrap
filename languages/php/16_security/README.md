# Security Basics

PHP has strong security primitives built directly into the standard library — no external package needed. `password_hash()`/`password_verify()` implement password hashing (bcrypt by default, or Argon2 if selected) with the salt generation and storage format handled automatically; `random_bytes()` draws from the OS's cryptographically secure entropy source; `hash_equals()` compares strings in constant time, avoiding timing side-channels.

## Example

```php
<?php
$hash = password_hash("hunter2", PASSWORD_DEFAULT);   // salt is generated and embedded automatically
// $hash is a self-contained string encoding the algorithm, cost, salt, and digest together

$matches = password_verify("hunter2", $hash);   // true — verify() re-derives and compares safely

$token = bin2hex(random_bytes(16));   // cryptographically secure random token

$a = "expected-value";
$b = "user-supplied-value";
$safeCompare = hash_equals($a, $b);   // constant-time comparison
```

See [`example.php`](./example.php) for the full runnable file.

## Common mistakes

1. **Hashing passwords with `md5()`/`sha1()`/`hash('sha256', ...)` instead of `password_hash()`.** These are fast, general-purpose hashes — an attacker who steals the database can try enormous numbers of guesses per second; `password_hash()` uses a deliberately slow, tunable algorithm (bcrypt by default) specifically designed to make brute-force expensive.
2. **Managing the salt separately from the hash.** `password_hash()`'s output string already embeds the algorithm, cost parameter, salt, and digest together — there's no separate salt value to generate, store, or pass around; `password_verify()` parses all of it back out automatically.
3. **Comparing password hashes (or any secret) with `===`/`==` instead of `hash_equals()` or `password_verify()`.** A naive string comparison can return as soon as it finds the first differing byte or character, and the time this takes leaks information about how many leading bytes matched — `hash_equals()` always takes the same time regardless of where a mismatch occurs.
4. **Using `mt_rand()`/`rand()` for anything security-sensitive.** Both are fast, statistically-uniform but *predictable* pseudorandom generators, not designed to resist an attacker guessing their internal state — always use `random_bytes()`/`random_int()` for salts, tokens, or keys.

## Exercise

Write `function hashPassword(string $password): string` using `password_hash()`, and `function verifyPassword(string $password, string $hash): bool` using `password_verify()`.

Try it yourself first, then check [`solutions/exercise_1.php`](./solutions/exercise_1.php).

## Interview questions

1. **Why is `password_hash()` preferred over a plain salted `sha256()` for password storage?** — `password_hash()`'s default algorithm (bcrypt) is deliberately slow, with a tunable cost factor, making both brute-force and hardware-accelerated attacks far more expensive per guess. A single fast hash like SHA-256, even salted, can be computed billions of times per second on modern hardware, making stolen hashes crackable quickly.
2. **Why does comparing two secret strings require `hash_equals()` instead of `===`?** — A naive comparison typically short-circuits at the first mismatched byte, so comparing a guess against the real value takes slightly longer the more leading bytes match. Measuring that timing difference over many attempts lets an attacker reconstruct the value byte by byte. `hash_equals()` always examines the full length regardless of mismatches, so the timing reveals nothing.

---
← [Previous: Concurrency](../15_concurrency/README.md) | [Next: Mini Projects →](../17_projects/README.md)
