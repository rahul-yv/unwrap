# Exercises: Security Basics

1. Write `hashPassword(password string) (string, error)` using `bcrypt.GenerateFromPassword`, returning the hash as a `string`.
2. Write `verifyPassword(password, hash string) bool` using `bcrypt.CompareHashAndPassword`.

Check your answer against [`solutions/exercise_1.go`](./solutions/exercise_1.go).
