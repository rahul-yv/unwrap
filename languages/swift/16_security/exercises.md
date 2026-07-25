# Exercises: Security Basics

1. Write `func hashPassword(_ password: String, salt: [UInt8]) throws -> SymmetricKey` using `KDF.Insecure.PBKDF2.deriveKey`, and `func verifyPassword(_ password: String, salt: [UInt8], expectedHash: SymmetricKey) throws -> Bool` that re-hashes and compares.

Check your answer against [`solutions/exercise_1.swift`](./solutions/exercise_1.swift) (run with `swift run exercise_1`).
