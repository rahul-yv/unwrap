import java.sql.DriverManager

fun main() {
    DriverManager.getConnection("jdbc:sqlite::memory:").use { conn ->
        conn.createStatement().use { st ->
            st.execute("CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT)")
        }

        conn.prepareStatement("INSERT INTO users (name) VALUES (?)").use { ps ->
            ps.setString(1, "Ada")
            ps.executeUpdate()
        }

        conn.prepareStatement("SELECT name FROM users WHERE id = ?").use { ps ->
            ps.setInt(1, 1)
            ps.executeQuery().use { rs ->
                check(rs.next())
                check(rs.getString("name") == "Ada")
            }
        }

        conn.prepareStatement("SELECT name FROM users WHERE id = ?").use { ps ->
            ps.setInt(1, 999)
            ps.executeQuery().use { rs ->
                check(!rs.next())
            }
        }
    }

    println("ok")
}
