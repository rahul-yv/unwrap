# Databases

`database/sql` (stdlib) is a generic interface over SQL databases — it defines *how* to query and scan results, but on its own can't talk to any specific database. You always need a driver registered alongside it; there's no database driver in core stdlib. This example uses `modernc.org/sqlite`, a pure-Go (no CGo) SQLite driver, so the lesson runs with zero system dependencies.

## Example

```go
import (
	"database/sql"
	_ "modernc.org/sqlite"   // registers the "sqlite" driver via its init(), used only for the side effect
)

db, err := sql.Open("sqlite", ":memory:")
defer db.Close()

db.Exec("CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT)")
db.Exec("INSERT INTO users (name) VALUES (?)", "Ada")

var id int
var name string
err = db.QueryRow("SELECT id, name FROM users WHERE name = ?", "Ada").Scan(&id, &name)
```

See [`example.go`](./example.go) for the full runnable file.

## Common mistakes

1. **Building SQL with `fmt.Sprintf`/string concatenation instead of `?` placeholders.** Same SQL injection risk as any language — always pass values as separate arguments to `Exec`/`Query`/`QueryRow`, never interpolated into the query string.
2. **Forgetting the blank import (`_ "modernc.org/sqlite"`).** The driver registers itself via its package `init()` function; if you don't import it at all (even though nothing in it is referenced directly), `sql.Open` fails with "unknown driver."
3. **Not checking for `sql.ErrNoRows` after `QueryRow(...).Scan(...)`.** A `QueryRow` that finds no matching row doesn't return a zero-valued struct — `Scan` returns the sentinel error `sql.ErrNoRows`, which must be checked explicitly to distinguish "not found" from other errors.
4. **Never closing `*sql.DB` or forgetting it's a connection *pool*, not a single connection.** `sql.DB` is safe for concurrent use and manages its own pool internally — there's no need to manually pool connections yourself, but the `DB` itself should still be closed when truly done with it (typically for the lifetime of the program, closed via `defer` at the top level).

## Exercise

Write `getUserByName(db *sql.DB, name string) (int, string, error)` returning the user's `id, name` via a parameterized query, propagating `sql.ErrNoRows` if not found.

Try it yourself first, then check [`solutions/exercise_1.go`](./solutions/exercise_1.go).

## Interview questions

1. **Why does `database/sql` need a separate driver import that's never referenced directly in the code?** — Drivers register themselves with `database/sql` via their package's `init()` function as a side effect of being imported; the blank identifier (`_`) tells Go "import this for its side effects only," since nothing from the package is used by name.
2. **What does `sql.ErrNoRows` represent, and why isn't "no row found" a panic or a zero-valued result?** — It's Go's normal error-as-value approach applied to a common, expected outcome (a lookup that finds nothing) — the caller checks for this specific sentinel error rather than the language treating "not found" as exceptional.

---
← [Previous: Networking](../13_networking/README.md) | [Next: Concurrency →](../15_concurrency/README.md)
