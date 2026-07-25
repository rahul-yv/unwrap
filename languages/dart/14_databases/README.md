# Databases

Dart has no database support in its core SDK — the `sqlite3` pub package (a native FFI binding) is the standard way to use SQLite. Unlike the fully SDK-only topics so far, this one needs a small package with a `pubspec.yaml` declaring the dependency, resolved with `dart pub get`.

## Example

```dart
import "package:sqlite3/sqlite3.dart";

final db = sqlite3.openInMemory();
db.execute("CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT)");

final insert = db.prepare("INSERT INTO users (name) VALUES (?)");
insert.execute(["Ada"]);   // parameterized — never string-interpolate values into SQL
insert.dispose();

final select = db.prepare("SELECT name FROM users WHERE id = ?");
final result = select.select([1]);
final name = result.isEmpty ? null : result.first["name"];   // "Ada", or null if no row matched
select.dispose();

db.dispose();
```

Run with (resolving the dependency once, cached locally after): `dart pub get && dart run example.dart`. See [`example.dart`](./example.dart) and [`pubspec.yaml`](./pubspec.yaml) for the full files.

## Common mistakes

1. **Building SQL with string interpolation instead of `?` placeholders.** `"SELECT * FROM users WHERE name = '$name'"` is a SQL injection vector; always pass values as a separate list argument to `.execute()`/`.select()`.
2. **Not calling `.dispose()` on prepared statements and the database connection.** These wrap native (FFI) resources outside Dart's garbage collector's visibility — forgetting to dispose them leaks native memory that the GC alone won't reclaim, unlike purely Dart-managed objects.
3. **Assuming `.select()` always returns at least one row.** It returns an empty `ResultSet` if nothing matches — calling `.first` on an empty result throws `StateError`; check `.isEmpty` (or use `.firstOrNull` if available) before accessing `.first`.
4. **Confusing `.execute()` (runs a statement, no rows returned — INSERT/UPDATE/DELETE/DDL) with `.select()` (runs a query, returns a `ResultSet`)** on a prepared statement — using the wrong one for a given SQL statement either silently discards rows that should have been returned, or fails outright.

## Exercise

Write a function `String? getUserName(Database db, int id)` that returns the user's name for a given `id` via a parameterized query, or `null` if no row matches.

Try it yourself first, then check [`solutions/exercise_1.dart`](./solutions/exercise_1.dart) (run with `dart run solutions/exercise_1.dart`).

## Interview questions

1. **Why should SQL values always be passed as parameters instead of interpolated into the query string?** — Interpolating untrusted input directly into SQL lets an attacker inject SQL syntax (SQL injection). Passing values as a separate list argument to `.execute()`/`.select()` sends the SQL text and the values separately, so the database always treats bound values as literal data, never as executable SQL.
2. **Why do the `sqlite3` package's database and statement objects need explicit `.dispose()` calls?** — They wrap native resources accessed via Dart's FFI (foreign function interface) to the underlying C SQLite library — memory and handles that live outside Dart's own garbage-collected heap. The Dart GC only knows about the (small) Dart-side wrapper object, not the native memory it points to, so it can't automatically reclaim the native resources when the wrapper becomes unreachable; explicit disposal is required to release them promptly.

---
← [Previous: Networking](../13_networking/README.md) | [Next: Concurrency →](../15_concurrency/README.md)
