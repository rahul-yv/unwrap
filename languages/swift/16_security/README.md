# Security Basics

Swift's standard library has no cryptography at all — this lesson uses [swift-crypto](https://github.com/apple/swift-crypto), Apple's cross-platform implementation of the CryptoKit API (backed by BoringSSL on Linux, the system's Security framework on Apple platforms). Because it's a real package dependency, this topic uses a Swift package (`Package.swift`) instead of a single runnable file — the only topic in this track that does, alongside `14_databases`'s system-library dependency.

## Example

```swift
import _CryptoExtras
import Crypto
import Foundation

// /dev/urandom is the portable cross-platform source of secure randomness;
// SecRandomCopyBytes is an alternative on Apple platforms only.
func randomBytes(_ count: Int) -> [UInt8] {
	var bytes = [UInt8](repeating: 0, count: count)
	let fd = open("/dev/urandom", O_RDONLY)
	_ = read(fd, &bytes, count)
	close(fd)
	return bytes
}

func hash(_ password: String, salt: [UInt8]) throws -> SymmetricKey {
	try KDF.Insecure.PBKDF2.deriveKey(
		from: Array(password.utf8),
		salt: salt,
		using: .sha256,
		outputByteCount: 32,
		unsafeUncheckedRounds: 100_000   // "unsafeUnchecked" refers to skipping the library's minimum-rounds guard, not the algorithm itself
	)
}

let salt = randomBytes(16)
let hashed = try hash("hunter2", salt: salt)
let attempt = try hash("hunter2", salt: salt)
let matches = hashed == attempt   // SymmetricKey's == is a constant-time comparison
```

Run with `swift run example` from this directory (or `swift build` then run the compiled binary directly). See [`example.swift`](./example.swift) and [`Package.swift`](./Package.swift) for the full files.

## Common mistakes

1. **Hashing passwords with a fast general-purpose hash (`SHA256.hash(data:)`) instead of a slow, iterated algorithm.** A fast hash lets an attacker who steals the database try enormous numbers of guesses per second; PBKDF2 (or Argon2/bcrypt) is deliberately slow, controlled by the rounds count, making brute-force expensive.
2. **Reusing the same salt across passwords, or omitting a salt entirely.** Without a per-password random salt, identical passwords produce identical hashes, and precomputed rainbow tables become effective; generate a fresh, unpredictable salt for each password.
3. **Comparing derived keys with a manual byte-by-byte loop instead of relying on `SymmetricKey`'s built-in `==`.** `SymmetricKey` (and swift-crypto's digest/tag types generally) implement `Equatable` with a constant-time comparison specifically to avoid leaking timing information — a hand-rolled comparison risks reintroducing the timing side-channel the library already avoids.
4. **Misreading `unsafeUncheckedRounds` as "insecure."** The name refers to swift-crypto skipping its own minimum-rounds sanity check (which would otherwise reject a suspiciously low round count) — the PBKDF2 algorithm itself is still the standard, secure construction; the caller is simply responsible for choosing an appropriately high round count themselves.

## Exercise

Write `func hashPassword(_ password: String, salt: [UInt8]) throws -> SymmetricKey` using `KDF.Insecure.PBKDF2.deriveKey`, and `func verifyPassword(_ password: String, salt: [UInt8], expectedHash: SymmetricKey) throws -> Bool` that re-hashes and compares.

Try it yourself first, then check [`solutions/exercise_1.swift`](./solutions/exercise_1.swift) (run with `swift run exercise_1`).

## Interview questions

1. **Why is PBKDF2 (or Argon2/bcrypt) preferred over a plain salted SHA-256 for password storage?** — These algorithms are deliberately slow, with a tunable cost factor (rounds/iterations for PBKDF2; memory and time cost for Argon2), making both brute-force and hardware-accelerated attacks far more expensive per guess. A single fast hash like SHA-256, even salted, can be computed billions of times per second on modern hardware, making stolen hashes crackable quickly.
2. **Why does comparing two derived keys need a constant-time comparison instead of a manual loop?** — A naive byte-by-byte comparison typically short-circuits at the first mismatch, so comparing a guess against the real value takes slightly longer the more leading bytes match. Measuring that timing difference over many attempts lets an attacker reconstruct the value byte by byte. `SymmetricKey`'s `Equatable` conformance is implemented to always take the same time regardless of where a mismatch occurs, so the timing reveals nothing.

---
← [Previous: Concurrency](../15_concurrency/README.md) | [Next: Mini Projects →](../17_projects/README.md)
