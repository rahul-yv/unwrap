# Security Basics

`crypto/rand` (real stdlib) generates cryptographically secure random bytes — never use `math/rand` for tokens, passwords, or session IDs, it's explicitly documented as not safe for that. Core stdlib has no slow password-hashing KDF, so the idiomatic choice is `golang.org/x/crypto/bcrypt` (maintained by the Go team, a de facto extension of stdlib) — it handles salting internally, so you don't manage a salt yourself.

## Example

```go
import "golang.org/x/crypto/bcrypt"

hash, err := bcrypt.GenerateFromPassword([]byte("hunter2"), bcrypt.DefaultCost)
// hash already embeds a random salt and the cost factor — nothing else to store

err = bcrypt.CompareHashAndPassword(hash, []byte("hunter2"))   // nil error means match

token := make([]byte, 16)
_, err = rand.Read(token)   // crypto/rand, not math/rand
```

See [`example.go`](./example.go) for the full runnable file.

## Common mistakes

1. **Using `math/rand` for anything security-sensitive.** It's a fast, statistically-good-but-predictable PRNG meant for simulations/games, not secrets — `math/rand`'s own docs say so explicitly. Always `crypto/rand` for tokens, salts, or keys.
2. **Hashing passwords with a fast general-purpose hash (`sha256.Sum256`) instead of `bcrypt`.** A fast hash lets an attacker who steals the database try billions of guesses per second; `bcrypt` is deliberately slow and tunable via its cost factor.
3. **Managing your own salt alongside `bcrypt`.** `bcrypt.GenerateFromPassword` generates and embeds a random salt in its output automatically — storing/passing a separate salt is redundant and a sign of not using the API as intended.
4. **Comparing hashes or tokens with `==`/`bytes.Equal` when a timing-safe comparison matters.** `bcrypt.CompareHashAndPassword` already does this internally for password checks; for other secret comparisons, use `crypto/subtle.ConstantTimeCompare`.

## Exercise

Write `hashPassword(password string) (string, error)` using `bcrypt.GenerateFromPassword`, and `verifyPassword(password, hash string) bool` using `bcrypt.CompareHashAndPassword`.

Try it yourself first, then check [`solutions/exercise_1.go`](./solutions/exercise_1.go).

## Interview questions

1. **Why is `math/rand` unsafe for generating tokens or session IDs?** — It's a deterministic PRNG seeded from a predictable source by default and designed for statistical distribution, not unpredictability — an attacker who can observe some output (or knows/guesses the seed) can potentially predict future values; `crypto/rand` draws from the OS's cryptographically secure entropy source instead.
2. **Why doesn't `bcrypt` require you to generate and store a salt separately?** — `GenerateFromPassword` generates a random salt internally and encodes it directly into the returned hash string, so `CompareHashAndPassword` can extract it back out — one self-contained value to store per password, not two.

---
← [Previous: Concurrency](../15_concurrency/README.md) | [Next: Mini Projects →](../17_projects/README.md)
