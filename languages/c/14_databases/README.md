# Databases

C has no database support in its standard library. SQLite is the natural choice for a self-contained example: it's a C library (`<sqlite3.h>`, linked with `-lsqlite3`) that runs an entire SQL database in-process with no separate server — and it's itself written in C, so its API *is* a C API, not a binding. Larger systems use client libraries like `libpq` (PostgreSQL) or `libmysqlclient`, but the core pattern — prepare a statement, bind parameters, step through results — is the same.

## Example

```c
#include <sqlite3.h>

sqlite3 *db;
sqlite3_open(":memory:", &db);

sqlite3_exec(db, "CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT)", NULL, NULL, NULL);

// parameterized insert — never build SQL with sprintf
sqlite3_stmt *stmt;
sqlite3_prepare_v2(db, "INSERT INTO users (name) VALUES (?)", -1, &stmt, NULL);
sqlite3_bind_text(stmt, 1, "Ada", -1, SQLITE_STATIC);
sqlite3_step(stmt);          // executes the insert
sqlite3_finalize(stmt);       // free the prepared statement

sqlite3_close(db);
```

Compile with `cc example.c -o example -lsqlite3`. See [`example.c`](./example.c) for the full runnable file.

## Common mistakes

1. **Building SQL with `sprintf`/string concatenation instead of parameter placeholders (`?`) + `sqlite3_bind_*`.** Same SQL injection risk as any language, and worse in C where string handling is already error-prone — always bind values separately from the query text.
2. **Forgetting `sqlite3_finalize` on a prepared statement, or `sqlite3_close` on the connection.** Both hold resources; not finalizing a statement leaks memory and can leave the database locked, and not closing the connection leaks the whole handle.
3. **Ignoring return codes.** Every `sqlite3_*` call returns a status code (`SQLITE_OK`, `SQLITE_ROW`, `SQLITE_DONE`, or an error) — `sqlite3_step` in particular returns `SQLITE_ROW` for each result row and `SQLITE_DONE` when finished; treating them all the same misreads the result.
4. **Passing the wrong lifetime hint to `sqlite3_bind_text`.** The `SQLITE_STATIC` vs `SQLITE_TRANSIENT` final argument tells SQLite whether the string will outlive the call (`STATIC`, no copy) or must be copied immediately (`TRANSIENT`) — passing `SQLITE_STATIC` for a buffer that's about to go out of scope is a use-after-free.

## Exercise

Write `int get_user_id_by_name(sqlite3 *db, const char *name)` returning the `id` of the user with the given name via a parameterized query, or `-1` if not found.

Try it yourself first, then check [`solutions/exercise_1.c`](./solutions/exercise_1.c) — compile with `cc solutions/exercise_1.c -o exercise_1 -lsqlite3`.

## Interview questions

1. **Why is SQLite a particularly natural database example for C specifically?** — SQLite is itself written in C and ships as a C library that runs the database engine in-process (no separate server) — so its native API is a plain C API, and the whole database is just a linked library plus a file, making it self-contained and dependency-light compared to a client/server database.
2. **What does the `SQLITE_STATIC` / `SQLITE_TRANSIENT` argument to `sqlite3_bind_text` control?** — Whether SQLite must make its own copy of the bound string: `SQLITE_STATIC` promises the string stays valid until the statement is done (so SQLite avoids a copy), while `SQLITE_TRANSIENT` tells SQLite to copy it immediately because the caller's buffer may be freed or reused — getting this wrong causes a use-after-free.

---
← [Previous: Networking](../13_networking/README.md) | [Next: Concurrency →](../15_concurrency/README.md)

