# Exercises: Security Basics

1. Write `hashPassword(password)` returning `{ salt, digest }` using `crypto.randomBytes(16)` and `crypto.scryptSync(password, salt, 64)`.
2. Write `verifyPassword(password, salt, digest)` recomputing the digest and comparing with `crypto.timingSafeEqual` (not `===`).

Check your answer against [`solutions/exercise_1.js`](./solutions/exercise_1.js).
