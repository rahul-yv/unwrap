# Exercises: Security Basics

1. Write `byte[] hashPassword(String password, byte[] salt)` using `PBKDF2WithHmacSHA256` (200,000 iterations, 256-bit key).
2. Write `boolean verifyPassword(String password, byte[] salt, byte[] expectedHash)` using `MessageDigest.isEqual`.

Check your answer against [`solutions/Exercise1.java`](./solutions/Exercise1.java).
