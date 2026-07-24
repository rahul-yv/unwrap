import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class Example {
    static void check(boolean condition, String message) {
        if (!condition) {
            throw new RuntimeException(message);
        }
    }

    public static void main(String[] args) throws Exception {
        try (Connection conn = DriverManager.getConnection("jdbc:sqlite::memory:")) {
            Statement stmt = conn.createStatement();
            stmt.execute("CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT)");

            PreparedStatement insert = conn.prepareStatement("INSERT INTO users (name) VALUES (?)");
            insert.setString(1, "Ada");
            insert.executeUpdate();

            PreparedStatement select = conn.prepareStatement("SELECT id, name FROM users WHERE name = ?");
            select.setString(1, "Ada");
            ResultSet rs = select.executeQuery();
            check(rs.next(), "should find the inserted row");
            check(rs.getInt("id") == 1 && rs.getString("name").equals("Ada"), "row values should match");

            // parameterized query treats input as data, not SQL
            String malicious = "Ada' OR '1'='1";
            insert.setString(1, malicious);
            insert.executeUpdate();

            PreparedStatement count = conn.prepareStatement("SELECT COUNT(*) AS n FROM users");
            ResultSet countRs = count.executeQuery();
            countRs.next();
            check(countRs.getInt("n") == 2, "the injected OR '1'='1' should not have selected every row");

            PreparedStatement missing = conn.prepareStatement("SELECT id FROM users WHERE name = ?");
            missing.setString(1, "Nobody");
            ResultSet missingRs = missing.executeQuery();
            check(!missingRs.next(), "querying a missing row should find nothing");
        }

        System.out.println("ok");
    }
}
