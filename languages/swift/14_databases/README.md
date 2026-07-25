# Databases

Swift has no built-in database support, but the system's SQLite C library is available on both macOS and Linux (it ships with the OS/toolchain) — no real package dependency needed, just a small system-library shim (`Sources/CSQLite`) so Swift can `import` the C headers. This lesson calls the C API directly, the same layer higher-level wrappers like GRDB.swift are built on. Like `16_security`, this topic uses a Swift package instead of a single runnable file, since it needs that module map.

## Example

```swift
import CSQLite

// SQLite's C API expects a destructor for bound text: SQLITE_TRANSIENT tells it
// to copy the string internally, since Swift's C-string bridging is only valid
// for the duration of the call — passing `nil` (SQLITE_STATIC) leaves a dangling read.
let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)

var db: OpaquePointer?
sqlite3_open(":memory:", &db)
sqlite3_exec(db, "CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT)", nil, nil, nil)

var stmt: OpaquePointer?
sqlite3_prepare_v2(db, "INSERT INTO users (name) VALUES (?)", -1, &stmt, nil)
sqlite3_bind_text(stmt, 1, "Ada", -1, SQLITE_TRANSIENT)   // parameterized — never string-concatenate values into SQL
sqlite3_step(stmt)
sqlite3_finalize(stmt)

sqlite3_prepare_v2(db, "SELECT name FROM users WHERE id = ?", -1, &stmt, nil)
sqlite3_bind_int(stmt, 1, 1)
if sqlite3_step(stmt) == SQLITE_ROW {
	let name = String(cString: sqlite3_column_text(stmt, 0))   // "Ada"
}
sqlite3_finalize(stmt)
sqlite3_close(db)
```

Run with `swift run example` from this directory. See [`Sources/example/main.swift`](./Sources/example/main.swift), [`Sources/CSQLite/`](./Sources/CSQLite/), and [`Package.swift`](./Package.swift) for the full files.

## Common mistakes

1. **Passing `nil` instead of `SQLITE_TRANSIENT` as `sqlite3_bind_text`'s destructor argument.** `nil` tells SQLite the string pointer is static and safe to read later (`SQLITE_STATIC`), but a Swift `String` bridged to a C string for a single call is only valid for that call's duration — reading it afterward (when `sqlite3_step` actually runs the statement) reads freed or reused memory, silently producing an empty or garbage string instead of a crash. `SQLITE_TRANSIENT` tells SQLite to copy the bytes immediately, which is almost always the correct choice from Swift.
2. **Building SQL with string interpolation instead of `sqlite3_bind_*` placeholders.** `"SELECT * FROM users WHERE name = '\(name)'"` is a SQL injection vector; always bind values through the parameter API.
3. **Not calling `sqlite3_finalize` on every prepared statement.** Each `sqlite3_prepare_v2` call allocates a statement object that must be explicitly finalized — there's no automatic cleanup for this C-level resource the way `defer`/RAII handles Swift-native types.
4. **Checking `sqlite3_step`'s result loosely** (e.g. just checking it's not an error) instead of the specific expected code (`SQLITE_ROW` for a row available, `SQLITE_DONE` when a query/statement has finished) — the two are easy to conflate and mean different things.
5. **Expecting `import SQLite3` to work in a single Swift file without a module map.** Unlike Apple platforms' SDK (which ships a module map for SQLite3), Linux has no built-in Swift module wrapping `libsqlite3` — a plain `swift file.swift` invocation fails with "no such module." The fix is a minimal `systemLibrary` target (a `module.modulemap` plus a header shim including `<sqlite3.h>`) in a small SwiftPM package, which is why this topic needs `Package.swift` rather than a single file.

## Exercise

Write a function `func getUserName(_ db: OpaquePointer?, id: Int64) -> String?` that returns the user's name for a given `id` via a parameterized query, or `nil` if no row matches.

Try it yourself first, then check [`Sources/exercise_1/main.swift`](./Sources/exercise_1/main.swift) (run with `swift run exercise_1`).

## Interview questions

1. **Why does `sqlite3_bind_text` need `SQLITE_TRANSIENT` when binding a Swift `String`?** — Swift bridges a `String` to a C string only for the lifetime of the call that needs it; that temporary buffer isn't guaranteed to remain valid afterward. `SQLITE_TRANSIENT` instructs SQLite to copy the bytes into its own storage immediately, rather than assuming (as `SQLITE_STATIC`/`nil` does) that the caller's pointer will remain valid until the statement no longer needs it — which isn't true for Swift's temporary C-string bridging.
2. **Why should SQL values always be passed as bound parameters instead of interpolated into the query string?** — Interpolating untrusted input directly into SQL lets an attacker inject SQL syntax (SQL injection). Bound parameters send the SQL text and the values separately, so the database always treats bound values as literal data, never as executable SQL.

---
← [Previous: Networking](../13_networking/README.md) | [Next: Concurrency →](../15_concurrency/README.md)
