# Databases

C++ has no database support in its standard library. SQLite (via its C API, `<sqlite3.h>`, linked with `-lsqlite3`) works directly from C++ — the C API is fully usable, and C++ can wrap it in RAII types so the connection and prepared statements are cleaned up automatically. Larger systems use C++ client libraries or ORMs, but the pattern — prepare, bind parameters, step through results — is the same as everywhere.

## Example

```cpp
#include <sqlite3.h>

sqlite3* db = nullptr;
sqlite3_open(":memory:", &db);

sqlite3_exec(db, "CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT)",
             nullptr, nullptr, nullptr);

// parameterized query — bind values, never build SQL with string concatenation
sqlite3_stmt* stmt = nullptr;
sqlite3_prepare_v2(db, "INSERT INTO users (name) VALUES (?)", -1, &stmt, nullptr);
sqlite3_bind_text(stmt, 1, "Ada", -1, SQLITE_STATIC);
sqlite3_step(stmt);       // execute
sqlite3_finalize(stmt);    // free the statement

sqlite3_close(db);
```

Compile with `c++ example.cpp -o example -lsqlite3`. See [`example.cpp`](./example.cpp) for the full runnable file, which wraps the connection in a small RAII guard so `sqlite3_close` can't be forgotten.

## Common mistakes

1. **Building SQL with string concatenation instead of `?` placeholders + `sqlite3_bind_*`.** SQL injection risk, same as any language — bind values separately from the query text.
2. **Forgetting `sqlite3_finalize` (per statement) or `sqlite3_close` (per connection).** These leak resources and can leave the database locked — wrapping them in RAII types (destructor calls finalize/close) is the idiomatic C++ fix for the forgetfulness the raw C API invites.
3. **Ignoring the step/result codes.** `sqlite3_step` returns `SQLITE_ROW` for each row and `SQLITE_DONE` at the end — treat them distinctly when reading query results.
4. **Getting the `SQLITE_STATIC` vs `SQLITE_TRANSIENT` lifetime hint wrong on `sqlite3_bind_text`** — `SQLITE_STATIC` promises the bound string outlives the statement; if the buffer might be freed/reused first, use `SQLITE_TRANSIENT` so SQLite copies it (a use-after-free otherwise).

## Exercise

Write `int get_user_id_by_name(sqlite3* db, const std::string& name)` returning the `id` of the user with the given name via a parameterized query, or `-1` if not found.

Try it yourself first, then check [`solutions/exercise_1.cpp`](./solutions/exercise_1.cpp) — compile with `c++ solutions/exercise_1.cpp -o exercise_1 -lsqlite3`.

## Interview questions

1. **How can C++ improve on using SQLite's raw C API directly?** — By wrapping the resources (the `sqlite3*` connection and `sqlite3_stmt*` statements) in RAII classes whose destructors call `sqlite3_close`/`sqlite3_finalize` — so cleanup happens automatically on scope exit (even during an exception), eliminating the manual-cleanup bugs the bare C API is prone to.
2. **Why are parameterized queries (bound values) important beyond just SQL injection prevention?** — They also let the database cache and reuse a prepared statement's query plan across executions with different values, and they handle type conversion and escaping correctly (dates, NULLs, binary data) rather than relying on manual string formatting — but injection prevention is the critical one: bound values can never be interpreted as SQL.

---
← [Previous: Networking](../13_networking/README.md) | [Next: Concurrency →](../15_concurrency/README.md)

