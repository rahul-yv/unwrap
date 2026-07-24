# Exercises: Databases

1. Write `fn get_user_name(conn: &rusqlite::Connection, id: i64) -> rusqlite::Result<Option<String>>` returning the user's name via a parameterized query, or `Ok(None)` if not found (using `.optional()`).

Check your answer against [`solutions/exercise_1.rs`](./solutions/exercise_1.rs). Run with `cargo run --bin exercise_1` from this directory.
