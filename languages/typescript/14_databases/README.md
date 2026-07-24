# Databases

Runtime behavior matches the JavaScript track's `14_databases` (`node:sqlite`). TypeScript's addition: rows come back as `any` (the driver can't know your schema), so the idiomatic pattern is to define an interface for the row shape and cast the result — same caveat as `response.json()`: a cast asserts, it doesn't validate.

## Example

```typescript
import { DatabaseSync } from "node:sqlite";

interface UserRow {
  id: number;
  name: string;
}

const db = new DatabaseSync(":memory:");
db.exec("CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT)");

const insert = db.prepare("INSERT INTO users (name) VALUES (?)");
insert.run("Ada");

const select = db.prepare("SELECT id, name FROM users WHERE name = ?");
const row = select.get("Ada") as UserRow | undefined;
```

See [`example.ts`](./example.ts) for the full runnable file.

## Common mistakes

1. **Casting a query result to an interface that doesn't match the actual columns selected.** `SELECT id FROM users` cast `as UserRow` (which also expects `name`) type-checks fine but `row.name` is `undefined` at runtime — the cast doesn't verify the query actually returns every field the interface claims.
2. **Building SQL with template literals instead of parameterized `?` placeholders** — same SQL injection risk as JavaScript; TypeScript's typing doesn't protect against this at all, since the query is just a `string`.
3. **Forgetting `.get()` returns `T | undefined`, not just `T`.** Casting away the `undefined` (`as UserRow` instead of `as UserRow | undefined`) hides the "no row matched" case from the type checker, and a later `.name` access on `undefined` fails at runtime instead of being caught at compile time.

## Exercise

Define an interface `UserRow { id: number; name: string }` and write `getUserByName(db: DatabaseSync, name: string): UserRow | undefined` using a parameterized, prepared statement.

Try it yourself first, then check [`solutions/exercise_1.ts`](./solutions/exercise_1.ts).

## Interview questions

1. **Does casting a database row to an interface guarantee the data matches that shape?** — No — a cast is a compile-time-only assertion; if the query selects fewer/different columns than the interface declares, the mismatch isn't caught until something accesses a field that isn't actually there.
2. **Why type `.get()`'s result as `T | undefined` rather than just `T`?** — A lookup can legitimately find nothing; keeping `undefined` in the type forces callers to handle the "not found" case explicitly instead of assuming a row was always returned.

---
← [Previous: Networking](../13_networking/README.md) | [Next: Concurrency →](../15_concurrency/README.md)
