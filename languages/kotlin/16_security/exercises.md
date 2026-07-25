# Exercises: Security Basics

1. Write `fun hashPassword(password: String, salt: ByteArray): ByteArray` using `PBEKeySpec`/`SecretKeyFactory`, and `fun verifyPassword(password: String, salt: ByteArray, expectedHash: ByteArray): Boolean` that re-hashes and compares with `MessageDigest.isEqual`.

Check your answer against [`solutions/exercise_1.kt`](./solutions/exercise_1.kt).
