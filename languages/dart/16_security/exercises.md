# Exercises: Security Basics

1. Write `Uint8List hashPassword(String password, Uint8List salt)` using the `pbkdf2` implementation, and `bool verifyPassword(String password, Uint8List salt, Uint8List expectedHash)` that re-hashes and compares with `secureCompare`.

Check your answer against [`solutions/exercise_1.dart`](./solutions/exercise_1.dart).
