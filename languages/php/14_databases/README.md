# Databases

PHP's PDO (PHP Data Objects) extension provides a uniform database API across drivers (`sqlite`, `mysql`, `pgsql`, ...) — the same prepared-statement code works regardless of the underlying database, just by changing the connection DSN string. This lesson uses `pdo_sqlite`, needing no separate server process.

## Example

```php
<?php
$pdo = new PDO("sqlite::memory:");
$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

$pdo->exec("CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT)");

$stmt = $pdo->prepare("INSERT INTO users (name) VALUES (?)");
$stmt->execute(["Ada"]);   // parameterized — never string-concatenate values into SQL

$stmt = $pdo->prepare("SELECT name FROM users WHERE id = ?");
$stmt->execute([1]);
$name = $stmt->fetchColumn();   // "Ada", or false if no row matched
```

See [`example.php`](./example.php) for the full runnable file.

## Common mistakes

1. **Building SQL with string interpolation instead of PDO's `?`/named placeholders.** `"SELECT * FROM users WHERE name = '$name'"` is a SQL injection vector; always pass values through `->execute([...])` or `->bindValue()`.
2. **Not setting `PDO::ATTR_ERRMODE` to `PDO::ERRMODE_EXCEPTION`.** PDO's default error mode is silent (`PDO::ERRMODE_SILENT`) — a failed query just leaves the statement in a failed state without visibly signaling an error unless you check manually; setting the exception mode makes failures surface immediately as catchable `PDOException`s, matching how the rest of PHP's modern error handling works.
3. **Confusing `fetchColumn()`'s `false` return (no matching row) with a legitimately falsy stored value.** If the queried column could itself contain `0`, `""`, or `false`-like values, distinguishing "no row" from "row with a falsy value" needs `fetch()` plus an explicit row-count or `=== false` check with awareness of that ambiguity.
4. **Reusing a `PDOStatement` across different parameter sets without realizing `execute()` can simply be called again** — prepared statements are compiled once and can be `execute()`d repeatedly with different bound values, which is both correct and efficient (avoiding re-parsing the SQL each time) for running the same query many times.

## Exercise

Write a function `function getUserName(PDO $pdo, int $id): ?string` that returns the user's name for a given `id` via a parameterized query, or `null` if no row matches.

Try it yourself first, then check [`solutions/exercise_1.php`](./solutions/exercise_1.php).

## Interview questions

1. **Why should SQL values always be passed as PDO parameters instead of interpolated into the query string?** — Interpolating untrusted input directly into SQL lets an attacker inject SQL syntax (SQL injection). PDO's placeholders send the SQL text and the values separately, so the database always treats bound values as literal data, never as executable SQL.
2. **Why does one PDO codebase work across different databases with minimal changes?** — PDO provides a common interface (`prepare`, `execute`, `fetch`, transactions) implemented by driver-specific classes underneath; switching databases is mostly a matter of changing the connection DSN (`sqlite:...` vs `mysql:host=...`) — though genuinely database-specific SQL syntax (functions, data types) still needs to match whichever database is actually in use, since PDO abstracts the connection API, not the SQL dialect itself.

---
← [Previous: Networking](../13_networking/README.md) | [Next: Concurrency →](../15_concurrency/README.md)
