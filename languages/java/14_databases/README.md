# Databases

JDBC (`java.sql`, stdlib) is a generic interface over SQL databases — like Go's `database/sql`, it needs a driver JAR for any specific database; there's no bundled driver in the JDK. This lesson uses `sqlite-jdbc` (a single self-contained jar with the native SQLite library embedded), downloaded directly rather than via Maven/Gradle, so it fits the same "no build tool" pattern as the rest of this track.

## Example

```java
try (Connection conn = DriverManager.getConnection("jdbc:sqlite::memory:")) {
	conn.createStatement().execute("CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT)");

	PreparedStatement insert = conn.prepareStatement("INSERT INTO users (name) VALUES (?)");
	insert.setString(1, "Ada");
	insert.executeUpdate();

	PreparedStatement select = conn.prepareStatement("SELECT id, name FROM users WHERE name = ?");
	select.setString(1, "Ada");
	ResultSet rs = select.executeQuery();
	if (rs.next()) {
		int id = rs.getInt("id");
		String name = rs.getString("name");
	}
}
```

Run with the driver on the classpath: `java -cp sqlite-jdbc.jar Example.java` (the single-file launcher works fine here, since the driver is provided via `-cp` rather than needing a local package import). See [`Example.java`](./Example.java) for the full runnable file.

## Common mistakes

1. **Building SQL with string concatenation instead of `PreparedStatement` placeholders (`?`).** Same SQL injection risk as any language — always use `PreparedStatement` with `.setString`/`.setInt`/etc. for values, never interpolate them into the query text.
2. **Forgetting `ResultSet.next()` must be called before reading the first row** — a fresh `ResultSet` starts positioned *before* the first row; `rs.next()` both advances to (and returns whether there is) a row.
3. **Not closing `Connection`/`Statement`/`ResultSet`.** All three implement `AutoCloseable` — use try-with-resources (closing the `Connection` typically closes its statements and result sets too, but explicit try-with-resources on each is the safe default).
4. **Column index confusion**: JDBC's positional getters (`rs.getString(1)`) are 1-indexed, not 0-indexed — an off-by-one here is a classic first mistake coming from most other APIs.

## Exercise

Write `Optional<String> getUserNameById(Connection conn, int id)` returning the user's name via a parameterized query, or `Optional.empty()` if not found.

Try it yourself first, then check [`solutions/Exercise1.java`](./solutions/Exercise1.java).

## Interview questions

1. **Why does `java.sql` need a separate driver JAR for each database?** — `java.sql` defines the interfaces (`Connection`, `Statement`, `ResultSet`, ...); a driver provides the actual implementation talking to a specific database's wire protocol, registered with `DriverManager` (often automatically via a `META-INF/services` file in the driver JAR, called Java's Service Provider Interface).
2. **Why use `Optional<String>` instead of returning `null` for "not found"?** — Makes the possibility of absence visible in the method's return type, forcing callers to explicitly handle the empty case (`.isPresent()`/`.map()`/`.orElse()`) rather than risking an unchecked `NullPointerException` from a forgotten null check.

---
← [Previous: Networking](../13_networking/README.md) | [Next: Concurrency →](../15_concurrency/README.md)
