# Databases

Kotlin uses JDBC (`java.sql`), the same database API as Java, since it runs on the JVM. This lesson uses `sqlite-jdbc` — SQLite's official JDBC driver — as an external jar on the classpath, the same "no build tool needed" approach as the testing topic's JUnit jar.

## Example

```kotlin
import java.sql.DriverManager

DriverManager.getConnection("jdbc:sqlite::memory:").use { conn ->
	conn.createStatement().use { st ->
		st.execute("CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT)")
	}

	conn.prepareStatement("INSERT INTO users (name) VALUES (?)").use { ps ->
		ps.setString(1, "Ada")   // parameterized — never string-concatenate values into SQL
		ps.executeUpdate()
	}

	conn.prepareStatement("SELECT name FROM users WHERE id = ?").use { ps ->
		ps.setInt(1, 1)
		ps.executeQuery().use { rs ->
			if (rs.next()) rs.getString("name") else null   // "Ada"
		}
	}
}
```

Run with (downloading the driver jar once, cached locally after):

```sh
curl -sL -o /tmp/sqlite-jdbc.jar "https://repo1.maven.org/maven2/org/xerial/sqlite-jdbc/3.47.1.0/sqlite-jdbc-3.47.1.0.jar"
kotlinc example.kt -include-runtime -cp /tmp/sqlite-jdbc.jar -d example.jar
java -cp "example.jar:/tmp/sqlite-jdbc.jar" ExampleKt
```

See [`example.kt`](./example.kt) for the full runnable file.

## Common mistakes

1. **Building SQL with string interpolation instead of a `PreparedStatement`'s `?` placeholders.** `"SELECT * FROM users WHERE name = '$name'"` is a SQL injection vector; always bind values through `ps.setString`/`.setInt`/etc.
2. **Not wrapping `Connection`/`Statement`/`ResultSet` in `use { }`.** Each wraps a native resource; `use { }` ensures they're closed even if an exception is thrown mid-query, the same pattern as file I/O.
3. **Calling `rs.getString(...)` without first checking `rs.next()` returned `true`.** `next()` advances to the first/next row and returns `false` when there are no more rows — reading a column before checking that leads to a `SQLException`, not a clean "no result".
4. **Forgetting the JDBC driver jar must be on the classpath at both compile and run time.** Unlike a Gradle-managed dependency, a hand-run `kotlinc`/`java` invocation needs `-cp` pointed at the jar explicitly in both commands, or the driver class won't be found.

## Exercise

Write a function `fun getUserName(conn: java.sql.Connection, id: Long): String?` that returns the user's name for a given `id` via a parameterized query, or `null` if no row matches.

Try it yourself first, then check [`solutions/exercise_1.kt`](./solutions/exercise_1.kt).

## Interview questions

1. **Why should SQL values always be passed as `PreparedStatement` parameters instead of interpolated into the query string?** — Interpolating untrusted input directly into SQL lets an attacker inject SQL syntax (SQL injection). A `PreparedStatement`'s placeholders send the SQL text and the values separately, so the database always treats bound values as literal data, never as executable SQL.
2. **What does `rs.next()` do, and why must it be checked before reading a column?** — `ResultSet.next()` advances the cursor to the next row (starting before the first row) and returns `true` if a row is now available, `false` if there are no more. Reading a column value before ever calling `next()` (or after it returns `false`) has no current row to read from and throws — the pattern `if (rs.next()) { ... }` or `while (rs.next()) { ... }` is required before any `getX()` call.

---
← [Previous: Networking](../13_networking/README.md) | [Next: Concurrency →](../15_concurrency/README.md)
