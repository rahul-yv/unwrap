# Databases

Rust's standard library has no database support at all — like networking, that's entirely the ecosystem's job. This lesson uses `rusqlite` (the standard SQLite binding, with its `bundled` feature compiling SQLite from source so no system library is required) — unlike every topic so far, this one needs `Cargo`, not just `rustc`, since it depends on an external crate.

## Example

```rust
use rusqlite::Connection;

let conn = Connection::open_in_memory()?;
conn.execute("CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT)", [])?;

conn.execute("INSERT INTO users (name) VALUES (?1)", ["Ada"])?;

let name: String = conn.query_row(
	"SELECT name FROM users WHERE id = 1",
	[],
	|row| row.get(0),
)?;
```

Run with `cargo run --bin example` from this directory (or `cargo build` then run the compiled binary directly). See [`example.rs`](./example.rs) and [`Cargo.toml`](./Cargo.toml) for the full files.

## Common mistakes

1. **Building SQL with `format!`/string concatenation instead of `?1`-style placeholders.** Same SQL injection risk as any language — always pass values as separate parameters to `.execute()`/`.query_row()`, never interpolated into the query text.
2. **Forgetting query parameters are positional (`?1`, `?2`, ...) or named (`:name`), and mismatching the parameter array's order/count** against the placeholders in the SQL string — a runtime error, not a compile-time one, since the SQL itself is just a `&str`.
3. **Not handling the case where `query_row` finds no matching row.** It returns `Err(rusqlite::Error::QueryReturnedNoRows)` in that case, not a panic or `None` — pattern-match on the `Result` (or use `.optional()` from the `OptionalExtension` trait to convert it to `Option<T>`) rather than `.unwrap()`ing blindly.
4. **Not using the `bundled` feature and then hitting build failures on machines without a system SQLite installed.** `bundled` compiles SQLite from source as part of the build, trading a slightly longer first build for zero external system dependencies — worth it for portability.

## Exercise

Write `fn get_user_name(conn: &rusqlite::Connection, id: i64) -> rusqlite::Result<Option<String>>` returning the user's name via a parameterized query, or `Ok(None)` if not found (using `.optional()`).

Try it yourself first, then check [`solutions/exercise_1.rs`](./solutions/exercise_1.rs).

## Interview questions

1. **Why does `rusqlite` offer a `bundled` feature, and what's the tradeoff?** — It compiles SQLite's C source directly into the build instead of linking against a system-installed `libsqlite3`, trading a longer first compile (and needing a C compiler available) for guaranteed availability and a consistent SQLite version across machines, regardless of what (if anything) is installed system-wide.
2. **How does `query_row` signal "no row found" versus a real error?** — Both come back as `Err`, but with a specific variant (`rusqlite::Error::QueryReturnedNoRows`) for the "not found" case — callers that want to treat "not found" as a normal `None` rather than a propagated error use `.optional()` to convert that specific variant, while other errors still propagate as `Err`.

---
← [Previous: Networking](../13_networking/README.md) | [Next: Concurrency →](../15_concurrency/README.md)

