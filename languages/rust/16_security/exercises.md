# Exercises: Security Basics

1. Write `fn hash_password(password: &str) -> String` using `Argon2::default().hash_password`.
2. Write `fn verify_password(password: &str, hash: &str) -> bool` using `PasswordHash::new` + `.verify_password`.

Check your answer against [`solutions/exercise_1.rs`](./solutions/exercise_1.rs). Run with `cargo run --bin exercise_1` from this directory.
