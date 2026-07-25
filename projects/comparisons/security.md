# Security Basics, across 14 languages

Every language here needs the same three primitives — cryptographically secure randomness, a slow password-hashing algorithm, and constant-time comparison — but they differ sharply on whether the standard library actually provides them.

## Cryptographically secure randomness: nearly universal in stdlib

Every language in this set ships a real CSPRNG in its standard library or core SDK: Python's `secrets`, Node's `crypto.randomBytes`, Go's `crypto/rand`, Java's `SecureRandom`, C#'s `RandomNumberGenerator`, Kotlin's `SecureRandom` (JVM), PHP's `random_bytes()`, Ruby's `SecureRandom`, Dart's `Random.secure()`, Swift/Rust/C/C++ via their respective crypto libraries' RNG (though these three don't have it in the *core* stdlib — see below). The universal warning across every single track: never use the default/fast PRNG (`Math.random()`, `math/rand`, `rand()`, `java.util.Random`, `mt_rand()`) for anything security-sensitive — every one of these is documented as predictable and unsuitable for secrets.

## Password hashing (a slow, iterated KDF): the real dividing line

This is where the languages split into three clear tiers:

**Tier 1 — full stdlib support, zero dependencies:**
- Java/Kotlin: `SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256")` (JDK/JVM stdlib)
- C#: `Rfc2898DeriveBytes` (PBKDF2, base class library)
- PHP: `password_hash()`/`password_verify()` (bcrypt or Argon2, fully built in, salt handled automatically)
- Ruby: `OpenSSL::PKCS5.pbkdf2_hmac` (stdlib's bundled `openssl`)

**Tier 2 — a hash primitive in stdlib, but PBKDF2/bcrypt/Argon2 needs a small manual implementation or de facto standard library:**
- Go: no PBKDF2 in core stdlib, but `golang.org/x/crypto/bcrypt` is maintained by the Go team itself — a de facto stdlib extension, not a third-party gamble
- Dart: `crypto` pub package provides `Hmac`/`sha256` but not PBKDF2 itself — this track hand-implements PBKDF2-HMAC-SHA256 on top of it

**Tier 3 — no cryptography at all in stdlib, a real external dependency required:**
- Rust: no crypto in `std` at all — uses the `argon2` crate
- Swift: no crypto in the standard library — uses Apple's `swift-crypto` package (`_CryptoExtras`'s `KDF.Insecure.PBKDF2`)
- C/C++: no crypto in stdlib — both use OpenSSL's `libcrypto` (`PKCS5_PBKDF2_HMAC`), linked with `-lcrypto`
- Python/JS/TS: `hashlib`/`node:crypto` provide the *hash primitives* (`scrypt`, `pbkdf2`) directly in stdlib, actually landing closer to Tier 1 — worth noting these two are more complete than their "scripting language" reputation might suggest

## Constant-time comparison: present almost everywhere it's needed

Every tier-1/tier-2 language above also ships a constant-time comparison function alongside its hashing story: Java/Kotlin's `MessageDigest.isEqual`, C#'s `CryptographicOperations.FixedTimeEquals`, PHP's `hash_equals()`, Ruby's `OpenSSL.fixed_length_secure_compare`, Node's `crypto.timingSafeEqual`, C/C++'s OpenSSL `CRYPTO_memcmp`. Where the language doesn't provide one, the pattern is always the same hand-rolled construction: XOR every byte into an accumulator regardless of earlier mismatches, check the accumulator once at the end — Dart's `security` topic implements exactly this by hand since neither `dart:core` nor the `crypto` package expose one directly.

## Interview-relevant takeaway

The question "does this language's standard library include real cryptography?" splits cleanly into two camps that don't align with the language's age or popularity: mature "batteries included" ecosystems (Java, C#, PHP, Ruby, and — less obviously — Python and Node) ship it directly; systems/newer languages (Rust, Swift) and C-family languages (C, C++) deliberately keep crypto out of the core language and lean on an external, audited library (OpenSSL, swift-crypto, the `argon2`/`ring` crates) instead — a design choice, not an oversight, since rolling your own crypto primitives is exactly the mistake these languages are steering you away from by not offering a half-baked built-in alternative.
