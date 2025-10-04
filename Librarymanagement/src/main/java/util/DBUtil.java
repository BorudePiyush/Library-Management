package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class DBUtil {
    private static final String URL = "jdbc:mysql://localhost:3306/library_db";
    private static final String USER = "root";
    private static final String PASS = "roote";

    public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(URL, USER, PASS);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }
    
    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    
    // Method to initialize database tables
    public static void initializeDatabase() {
        Connection conn = null;
        Statement stmt = null;
        try {
            conn = getConnection();
            stmt = conn.createStatement();
            
            // Create admin table
            String adminTable = "CREATE TABLE IF NOT EXISTS admin (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY, " +
                    "username VARCHAR(50) UNIQUE NOT NULL, " +
                    "password VARCHAR(100) NOT NULL, " +
                    "email VARCHAR(100), " +
                    "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP)";
            stmt.executeUpdate(adminTable);
            
            // Create users table
            String usersTable = "CREATE TABLE IF NOT EXISTS users (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY, " +
                    "username VARCHAR(50) UNIQUE NOT NULL, " +
                    "password VARCHAR(100) NOT NULL, " +
                    "email VARCHAR(100) NOT NULL, " +
                    "full_name VARCHAR(100) NOT NULL, " +
                    "phone VARCHAR(15), " +
                    "address TEXT, " +
                    "registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, " +
                    "is_active BOOLEAN DEFAULT TRUE)";
            stmt.executeUpdate(usersTable);
            
            // Create books table
            String booksTable = "CREATE TABLE IF NOT EXISTS books (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY, " +
                    "isbn VARCHAR(20) UNIQUE, " +
                    "title VARCHAR(200) NOT NULL, " +
                    "author VARCHAR(100) NOT NULL, " +
                    "publisher VARCHAR(100), " +
                    "category VARCHAR(50), " +
                    "total_copies INT DEFAULT 1, " +
                    "available_copies INT DEFAULT 1, " +
                    "publication_year INT, " +
                    "added_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP)";
            stmt.executeUpdate(booksTable);
            
            // Create transactions table
            String transactionsTable = "CREATE TABLE IF NOT EXISTS transactions (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY, " +
                    "user_id INT NOT NULL, " +
                    "book_id INT NOT NULL, " +
                    "issue_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, " +
                    "due_date DATE NOT NULL, " +
                    "return_date TIMESTAMP NULL, " +
                    "fine_amount DECIMAL(10,2) DEFAULT 0.00, " +
                    "status ENUM('ISSUED', 'RETURNED', 'OVERDUE') DEFAULT 'ISSUED', " +
                    "FOREIGN KEY (user_id) REFERENCES users(id), " +
                    "FOREIGN KEY (book_id) REFERENCES books(id))";
            stmt.executeUpdate(transactionsTable);
            
            // Insert default admin
            String insertAdmin = "INSERT IGNORE INTO admin (username, password, email) VALUES " +
                    "('admin', 'admin123', 'admin@library.com')";
            stmt.executeUpdate(insertAdmin);
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
