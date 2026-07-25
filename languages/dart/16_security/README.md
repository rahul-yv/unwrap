# Security Basics

Dart's core SDK provides `Random.secure()` for cryptographically secure randomness, but has no built-in password-hashing algorithm — the `crypto` pub package provides hash primitives (`sha256`, `Hmac`) but not PBKDF2 directly, so this lesson implements PBKDF2-HMAC-SHA256 (a standard, well-documented construction) on top of `crypto`'s `Hmac`. Like the databases topic, this one needs a small package with a `pubspec.yaml`.

## Example

```dart
import "dart:math";
import "dart:typed_data";
import "package:crypto/crypto.dart";

Uint8List randomBytes(int count) {
	final random = Random.secure();   // cryptographically secure random source
	return Uint8List.fromList(List.generate(count, (_) => random.nextInt(256)));
}

bool secureCompare(List<int> a, List<int> b) {
	if (a.length != b.length) return false;
	int result = 0;
	for (int i = 0; i < a.length; i++) {
		result |= a[i] ^ b[i];   // XOR every byte regardless of earlier mismatches — no early exit
	}
	return result == 0;
}

final salt = randomBytes(16);
final hash = pbkdf2("hunter2", salt, 100000, 32);   // see example.dart for the full pbkdf2 implementation
final attempt = pbkdf2("hunter2", salt, 100000, 32);
final matches = secureCompare(hash, attempt);
```

See [`example.dart`](./example.dart) for the full runnable file, including the complete `pbkdf2` implementation.

## Common mistakes

1. **Hashing passwords with a fast general-purpose hash (`sha256.convert(...)`) instead of a slow, iterated algorithm.** A fast hash lets an attacker who steals the database try enormous numbers of guesses per second; PBKDF2 (or bcrypt/Argon2 via a dedicated package) is deliberately slow, controlled by the iteration count, making brute-force expensive.
2. **Reusing the same salt across passwords, or omitting a salt entirely.** Without a per-password random salt, identical passwords produce identical hashes, and precomputed rainbow tables become effective; `Random.secure()` generates a fresh, unpredictable salt for each password.
3. **Comparing hashes with `==`/`.equals()` on the byte lists instead of a constant-time comparison.** A naive comparison can return as soon as it finds the first differing byte, and the time this takes leaks information about how many leading bytes matched; the `secureCompare` pattern above always examines every byte regardless of mismatches, so the timing reveals nothing.
4. **Using `Random()` (not `Random.secure()`) for anything security-sensitive.** The default `Random` is a fast, statistically-uniform but *predictable* pseudorandom generator, not designed to resist an attacker guessing its internal state — always use `Random.secure()` for salts, tokens, or keys.

## Exercise

Write `Uint8List hashPassword(String password, Uint8List salt)` using the `pbkdf2` implementation, and `bool verifyPassword(String password, Uint8List salt, Uint8List expectedHash)` that re-hashes and compares with `secureCompare`.

Try it yourself first, then check [`solutions/exercise_1.dart`](./solutions/exercise_1.dart).

## Interview questions

1. **Why is PBKDF2 (or bcrypt/Argon2) preferred over a plain salted SHA-256 for password storage?** — These algorithms are deliberately slow, with a tunable cost factor (iteration count for PBKDF2; memory and time cost for Argon2), making both brute-force and hardware-accelerated attacks far more expensive per guess. A single fast hash like SHA-256, even salted, can be computed billions of times per second on modern hardware, making stolen hashes crackable quickly.
2. **Why does comparing two hashes require a constant-time comparison instead of a naive loop with early exit?** — A naive comparison typically short-circuits at the first mismatched byte, so comparing a guess against the real hash takes slightly longer the more leading bytes match. Measuring that timing difference over many attempts lets an attacker reconstruct the hash byte by byte. A constant-time comparison (XOR-accumulate every byte, check the accumulator once at the end) always takes the same time regardless of where a mismatch occurs, so the timing reveals nothing.

---
← [Previous: Concurrency](../15_concurrency/README.md) | [Next: Mini Projects →](../17_projects/README.md)
