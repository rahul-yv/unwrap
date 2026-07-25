# Exercises: Security Basics

1. Write `byte[] HashPassword(string password, byte[] salt)` using `Rfc2898DeriveBytes.Pbkdf2`, and `bool VerifyPassword(string password, byte[] salt, byte[] expectedHash)` that re-hashes and compares with `CryptographicOperations.FixedTimeEquals`.

Check your answer against [`solutions/exercise_1.cs`](./solutions/exercise_1.cs).
