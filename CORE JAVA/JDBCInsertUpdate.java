import java.sql.*;

public class JDBCInsertUpdate {
    public static void main(String[] args) {
        try {
            Connection conn = DriverManager.getConnection("jdbc:sqlite:students.db");

            // Insert
            String insertQuery = "INSERT INTO students (id, name) VALUES (?, ?)";
            PreparedStatement insertStmt = conn.prepareStatement(insertQuery);
            insertStmt.setInt(1, 3);
            insertStmt.setString(2, "David");
            insertStmt.executeUpdate();

            // Update
            String updateQuery = "UPDATE students SET name = ? WHERE id = ?";
            PreparedStatement updateStmt = conn.prepareStatement(updateQuery);
            updateStmt.setString(1, "UpdatedName");
            updateStmt.setInt(2, 3);
            updateStmt.executeUpdate();

            System.out.println("Insert and update completed.");
            conn.close();
        } catch (SQLException e) {
            System.out.println("Database error: " + e.getMessage());
        }
    }
}