import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Optional;

public class Exercise1 {
    static void check(boolean condition, String message) {
        if (!condition) {
            throw new RuntimeException(message);
        }
    }

    static Optional<String> getUserNameById(Connection conn, int id) throws Exception {
        PreparedStatement select = conn.prepareStatement("SELECT name FROM users WHERE id = ?");
        select.setInt(1, id);
        ResultSet rs = select.executeQuery();
        if (rs.next()) {
            return Optional.of(rs.getString("name"));
        }
        return Optional.empty();
    }

    public static void main(String[] args) throws Exception {
        try (Connection conn = DriverManager.getConnection("jdbc:sqlite::memory:")) {
            conn.createStatement().execute("CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT)");
            PreparedStatement insert = conn.prepareStatement("INSERT INTO users (name) VALUES (?)");
            insert.setString(1, "Ada");
            insert.executeUpdate();

            check(getUserNameById(conn, 1).equals(Optional.of("Ada")), "should find Ada");
            check(getUserNameById(conn, 999).isEmpty(), "should be empty for a missing id");
        }

        System.out.println("ok");
    }
}
