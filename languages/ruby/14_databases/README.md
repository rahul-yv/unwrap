# Databases

Ruby has no database support in its standard library — the `sqlite3` gem is the standard binding for SQLite, installed via RubyGems. Unlike the fully stdlib-only topics so far, this one needs `gem install sqlite3` first (or a `Gemfile` with Bundler in a real project).

## Example

```ruby
require "sqlite3"

db = SQLite3::Database.new(":memory:")
db.execute("CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT)")

db.execute("INSERT INTO users (name) VALUES (?)", ["Ada"])   # parameterized — never string-interpolate values into SQL

row = db.execute("SELECT name FROM users WHERE id = ?", [1]).first
name = row[0]   # "Ada", or nil if execute returned no rows
```

Run with (installing the gem once, cached locally after): `gem install sqlite3 && ruby example.rb`. See [`example.rb`](./example.rb) for the full runnable file.

## Common mistakes

1. **Building SQL with string interpolation instead of `?` placeholders.** `"SELECT * FROM users WHERE name = '#{name}'"` is a SQL injection vector; always pass values as a separate array argument to `.execute`.
2. **Forgetting `.execute` returns an array of rows (each itself an array of column values) — even for a single-row result** — `db.execute(...).first` gets the first row, and `row[0]` (or, with `results_as_hash = true` on the connection, `row["name"]`) gets a specific column; there's no automatic "just give me the one value" shortcut without a bit of unwrapping.
3. **Not handling the case where a query returns no rows.** `.execute(...).first` returns `nil` if there are no matching rows — calling `[0]` on that `nil` raises `NoMethodError`; check for `nil` first when the row might not exist.
4. **Not closing the database connection (`db.close`) when done with it**, especially in longer-running scripts — for a short script this is harmless since the process exiting releases it, but explicit `db.close` (or a block form where supported) is good practice.

## Exercise

Write a method `def get_user_name(db, id)` that returns the user's name for a given `id` via a parameterized query, or `nil` if no row matches.

Try it yourself first, then check [`solutions/exercise_1.rb`](./solutions/exercise_1.rb).

## Interview questions

1. **Why should SQL values always be passed as separate arguments to `.execute` instead of interpolated into the query string?** — Interpolating untrusted input directly into SQL lets an attacker inject SQL syntax (SQL injection). Passing values as a separate array argument sends the SQL text and the values separately, so the database always treats bound values as literal data, never as executable SQL.
2. **What does `SQLite3::Database#execute` return, and how do you get a single scalar value from it?** — It returns an array of rows, where each row is itself an array of column values (by default) — even a query expected to return one row and one column still comes back as `[[value]]`. Getting a scalar means `.execute(...).first&.first` (first row, first column) or, with `results_as_hash = true` set on the connection, `.execute(...).first&.[]("column_name")` for a hash-style lookup.

---
← [Previous: Networking](../13_networking/README.md) | [Next: Concurrency →](../15_concurrency/README.md)
