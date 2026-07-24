# Exercises: Security Basics

1. Define `type HashedPassword = string & { readonly __brand: "HashedPassword" }`.
2. Write `hashPassword(plaintext: string): { salt: Buffer; hashed: HashedPassword }` using `crypto.randomBytes`/`crypto.scryptSync`.
3. Write `verifyPassword(plaintext: string, salt: Buffer, hashed: HashedPassword): boolean` using `crypto.timingSafeEqual`.

Check your answer against [`solutions/exercise_1.ts`](./solutions/exercise_1.ts).
