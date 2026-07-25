import java.sql.Connection
import java.sql.DriverManager

fun getUserName(conn: Connection, id: Long): String? {
    conn.prepareStatement("SELECT name FROM users WHERE id = ?").use { ps ->
        ps.setLong(1, id)
        ps.executeQuery().use { rs ->
            return if (rs.next()) rs.getString("name") else null
        }
    }
}

fun main() {
    DriverManager.getConnection("jdbc:sqlite::memory:").use { conn ->
        conn.createStatement().use { st ->
            st.execute("CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT)")
        }
        conn.prepareStatement("INSERT INTO users (name) VALUES (?)").use { ps ->
            ps.setString(1, "Ada")
            ps.executeUpdate()
        }

        check(getUserName(conn, 1) == "Ada")
        check(getUserName(conn, 999) == null)
    }

    println("ok")
}
