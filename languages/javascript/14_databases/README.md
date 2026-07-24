# Databases

Node's built-in `node:sqlite` module (stable since Node 22) gives a real SQL database with zero dependencies — good for learning SQL basics and small tools. Production Node apps typically use `pg` (PostgreSQL) or an ORM like Prisma, but parameterized queries and transactions work the same way.

## Example

```javascript
const { DatabaseSync } = require("node:sqlite");

const db = new DatabaseSync(":memory:");
db.exec("CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT)");

const insert = db.prepare("INSERT INTO users (name) VALUES (?)");
insert.run("Ada");

const select = db.prepare("SELECT id, name FROM users WHERE name = ?");
const row = select.get("Ada");   // { id: 1, name: "Ada" }
```

See [`example.js`](./example.js) for the full runnable file.

## Common mistakes

1. **Building SQL with template literals/string concatenation instead of prepared statements.** `` `SELECT * FROM users WHERE name = '${name}'` `` is a SQL injection vulnerability. Always use `?` placeholders and pass values to `.run()`/`.get()`/`.all()` separately.
2. **Re-preparing the same statement on every call in a hot path.** `db.prepare(...)` compiles the SQL; prepare it once and reuse the returned statement object for repeated calls with different parameters.
3. **Not wrapping multi-step writes in a transaction.** Without one, a failure partway through a multi-statement update leaves the database inconsistent — use `db.exec("BEGIN")` / `COMMIT` (or a transaction helper) for operations that must succeed or fail together.
4. **Forgetting `.get()` returns `undefined` (not `null` or throwing) when no row matches** — check for `undefined` explicitly rather than assuming a row was found.
5. **Comparing a returned row with `assert.deepStrictEqual(row, { ... })`.** `node:sqlite` rows have a `null` prototype (not plain `Object`), so a strict deep-equality check against an object literal fails even when the fields match — compare individual fields instead, or normalize with `{ ...row }`.

## Exercise

Write `getUserByName(db, name)` that uses a prepared, parameterized statement to look up a user by name in a `users(id, name)` table, returning the row object or `undefined` if not found.

Try it yourself first, then check [`solutions/exercise_1.js`](./solutions/exercise_1.js).

## Interview questions

1. **Why are prepared statements the fix for SQL injection?** — The query structure is compiled before any user value is bound to it, so a value can never be interpreted as SQL syntax no matter what characters it contains.
2. **What's the benefit of preparing a statement once and reusing it?** — Avoids re-parsing/re-compiling the same SQL on every call, which matters for statements executed many times in a loop or hot path.

---
← [Previous: Networking](../13_networking/README.md) | [Next: Concurrency →](../15_concurrency/README.md)
