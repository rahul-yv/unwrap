# Exercises: Databases

1. Write `Optional<String> getUserNameById(Connection conn, int id)` returning the user's name via a parameterized query, or `Optional.empty()` if not found.

Run it with the SQLite driver on the classpath:

```sh
curl -sL -o /tmp/sqlite-jdbc.jar "https://repo1.maven.org/maven2/org/xerial/sqlite-jdbc/3.46.1.3/sqlite-jdbc-3.46.1.3.jar"
java -cp /tmp/sqlite-jdbc.jar solutions/Exercise1.java
```

Check your answer against [`solutions/Exercise1.java`](./solutions/Exercise1.java).
