# Databases

C# has no database support in the base class library — `Microsoft.Data.Sqlite` (the standard SQLite provider) is a NuGet package. .NET 10's single-file `#:package` directive lets a plain `.cs` file declare that dependency inline, so `dotnet run file.cs` restores it automatically — no `.csproj` needed, matching every other topic's single-file layout.

## Example

```csharp
#:package Microsoft.Data.Sqlite@10.0.10
#:package SQLitePCLRaw.bundle_e_sqlite3@3.0.4
using Microsoft.Data.Sqlite;

using var conn = new SqliteConnection("Data Source=:memory:");
conn.Open();

var create = conn.CreateCommand();
create.CommandText = "CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT)";
create.ExecuteNonQuery();

var insert = conn.CreateCommand();
insert.CommandText = "INSERT INTO users (name) VALUES ($n)";
insert.Parameters.AddWithValue("$n", "Ada");   // parameterized — never string-concatenate values into SQL
insert.ExecuteNonQuery();

var select = conn.CreateCommand();
select.CommandText = "SELECT name FROM users WHERE id = 1";
string name = (string)select.ExecuteScalar()!;   // "Ada"
```

The second `#:package` line pins `SQLitePCLRaw.bundle_e_sqlite3` (the native SQLite engine `Microsoft.Data.Sqlite` depends on) to a version newer than the one it would otherwise pull in transitively, which carries a known vulnerability advisory — pinning it directly resolves the warning.

See [`example.cs`](./example.cs) for the full runnable file.

## Common mistakes

1. **Building SQL with string interpolation instead of parameters.** `$"SELECT * FROM users WHERE name = '{name}'"` is a SQL injection vector; always pass values through `.Parameters.AddWithValue()` (or `.Parameters.Add` with an explicit type) and placeholders like `$n` in the SQL text.
2. **Not disposing the connection/command.** `SqliteConnection` and `SqliteCommand` hold unmanaged resources; use `using`/`using var` so they're released even if an exception is thrown mid-query.
3. **Calling `ExecuteScalar()` when no row matches and not handling `null`.** It returns `null` (not throwing) if the query finds nothing — casting the result directly, as in the example, throws a `NullReferenceException` in that case; check for `null` first when the row might not exist.
4. **Leaving a transitive dependency's vulnerable version unpinned.** A NuGet restore can pull in an old, flagged version of a transitive package (like `SQLitePCLRaw.lib.e_sqlite3` here) even when the direct dependency is current — pin the transitive package explicitly to clear the warning rather than ignoring it.

## Exercise

Write a method `string? GetUserName(SqliteConnection conn, long id)` that returns the user's name for a given `id` via a parameterized query, or `null` if no row matches.

Try it yourself first, then check [`solutions/exercise_1.cs`](./solutions/exercise_1.cs).

## Interview questions

1. **Why should SQL values always be passed as parameters instead of interpolated into the query string?** — Interpolating untrusted input directly into SQL lets an attacker inject SQL syntax (SQL injection) — e.g. a name like `'; DROP TABLE users; --`. Parameters are sent separately from the SQL text, so the database always treats them as literal data, never as executable SQL.
2. **What's the risk of leaving a transitive NuGet dependency at whatever version a package brings in by default, and how do you fix it?** — A direct dependency's own dependency (transitive) can lag behind and carry a known vulnerability even though the top-level package is current; NuGet will resolve it automatically unless told otherwise. Adding an explicit reference to the transitive package at a newer version overrides the resolution and clears the vulnerability.

---
← [Previous: Networking](../13_networking/README.md) | [Next: Concurrency →](../15_concurrency/README.md)
