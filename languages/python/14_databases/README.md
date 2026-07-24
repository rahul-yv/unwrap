# Databases

`sqlite3` (stdlib) gives a real SQL database with zero setup — useful for learning SQL basics and for small tools; production systems typically use PostgreSQL/MySQL via a driver like `psycopg2` or an ORM like SQLAlchemy, but the core lesson — parameterized queries, transactions, connections — carries over directly.

## Example

```python
import sqlite3

conn = sqlite3.connect(":memory:")
conn.execute("CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT)")
conn.execute("INSERT INTO users (name) VALUES (?)", ("Ada",))
conn.commit()

cursor = conn.execute("SELECT id, name FROM users WHERE name = ?", ("Ada",))
row = cursor.fetchone()   # (1, 'Ada')
```

See [`example.py`](./example.py) for the full runnable file.

## Common mistakes

1. **Building SQL with string formatting/f-strings instead of parameterized queries.** `f"SELECT * FROM users WHERE name = '{name}'"` is a SQL injection vulnerability. Always use `?` placeholders (or `%s` for other drivers) and pass values separately — the driver escapes them safely.
2. **Forgetting to commit a transaction.** Writes made with `conn.execute(...)` aren't persisted until `conn.commit()` — code that writes then reads in a fresh connection without committing first will see stale data.
3. **Leaving connections open**, exhausting the connection pool under load — use a context manager or explicit `close()`, same principle as file handles.
4. **Not using a transaction for multi-step writes that must succeed or fail together** — without one, a crash mid-sequence leaves the database in a half-updated state.

## Exercise

Write a function `get_user_by_name(conn, name)` that queries a `users(id, name)` table for a row matching `name` using a parameterized query, and returns the row as a dict (`{"id": ..., "name": ...}`) or `None` if not found.

Try it yourself first, then check [`solutions/exercise_1.py`](./solutions/exercise_1.py).

## Interview questions

1. **Why are parameterized queries the fix for SQL injection?** — The driver sends the query and the values separately; the database never interprets a value as part of the SQL syntax, so user input can't alter the query structure no matter what characters it contains.
2. **What does `conn.commit()` actually do?** — Ends the current transaction, making its writes durable and visible to other connections; without it, writes may be rolled back or invisible elsewhere.
3. **When would you reach for a raw SQL query instead of an ORM?** — Performance-critical or complex queries an ORM generates inefficiently, or database-specific features the ORM doesn't expose cleanly.

---
← [Previous: Networking](../13_networking/README.md) | [Next: Concurrency →](../15_concurrency/README.md)
