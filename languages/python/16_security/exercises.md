# Exercises: Security Basics

1. Write `hash_password(password)` returning `(salt, digest)` using `secrets.token_bytes(16)` for the salt and `hashlib.pbkdf2_hmac("sha256", password.encode(), salt, 200_000)` for the digest.
2. Write `verify_password(password, salt, digest)` that recomputes the digest for `password`/`salt` and returns whether it matches `digest`, using `hmac.compare_digest` (not `==`).

Check your answer against [`solutions/exercise_1.py`](./solutions/exercise_1.py).
