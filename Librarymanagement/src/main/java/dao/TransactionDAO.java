package dao;


import model.Transaction;
import util.DBUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;

public class TransactionDAO {
    
    public boolean issueBook(Transaction transaction) {
        Connection conn = null;
        PreparedStatement ps1 = null;
        PreparedStatement ps2 = null;
        
        try {
            conn = DBUtil.getConnection();
            conn.setAutoCommit(false);
            
            // Insert transaction
            String insertSql = "INSERT INTO transactions (user_id, book_id, due_date) VALUES (?, ?, ?)";
            ps1 = conn.prepareStatement(insertSql);
            ps1.setInt(1, transaction.getUserId());
            ps1.setInt(2, transaction.getBookId());
            ps1.setDate(3, transaction.getDueDate());
            
            int result1 = ps1.executeUpdate();
            
            // Update available copies
            String updateSql = "UPDATE books SET available_copies = available_copies - 1 WHERE id = ? AND available_copies > 0";
            ps2 = conn.prepareStatement(updateSql);
            ps2.setInt(1, transaction.getBookId());
            
            int result2 = ps2.executeUpdate();
            
            if (result1 > 0 && result2 > 0) {
                conn.commit();
                return true;
            } else {
                conn.rollback();
                return false;
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            try {
                if (conn != null) conn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            return false;
        } finally {
            try {
                if (ps1 != null) ps1.close();
                if (ps2 != null) ps2.close();
                if (conn != null) {
                    conn.setAutoCommit(true);
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    
    public boolean returnBook(int transactionId, BigDecimal fineAmount) {
        Connection conn = null;
        PreparedStatement ps1 = null;
        PreparedStatement ps2 = null;
        PreparedStatement ps3 = null;
        
        try {
            conn = DBUtil.getConnection();
            conn.setAutoCommit(false);
            
            // Get book ID from transaction
            String selectSql = "SELECT book_id FROM transactions WHERE id = ?";
            ps1 = conn.prepareStatement(selectSql);
            ps1.setInt(1, transactionId);
            ResultSet rs = ps1.executeQuery();
            
            int bookId = 0;
            if (rs.next()) {
                bookId = rs.getInt("book_id");
            } else {
                return false;
            }
            
            // Update transaction
            String updateTransactionSql = "UPDATE transactions SET return_date = CURRENT_TIMESTAMP, fine_amount = ?, status = 'RETURNED' WHERE id = ?";
            ps2 = conn.prepareStatement(updateTransactionSql);
            ps2.setBigDecimal(1, fineAmount);
            ps2.setInt(2, transactionId);
            
            int result1 = ps2.executeUpdate();
            
            // Update available copies
            String updateBookSql = "UPDATE books SET available_copies = available_copies + 1 WHERE id = ?";
            ps3 = conn.prepareStatement(updateBookSql);
            ps3.setInt(1, bookId);
            
            int result2 = ps3.executeUpdate();
            
            if (result1 > 0 && result2 > 0) {
                conn.commit();
                return true;
            } else {
                conn.rollback();
                return false;
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            try {
                if (conn != null) conn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            return false;
        } finally {
            try {
                if (ps1 != null) ps1.close();
                if (ps2 != null) ps2.close();
                if (ps3 != null) ps3.close();
                if (conn != null) {
                    conn.setAutoCommit(true);
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    
    public List<Transaction> getAllTransactions() {
        List<Transaction> transactions = new ArrayList<>();
        String sql = "SELECT t.*, u.username, u.full_name, b.title, b.author " +
                    "FROM transactions t " +
                    "JOIN users u ON t.user_id = u.id " +
                    "JOIN books b ON t.book_id = b.id " +
                    "ORDER BY t.issue_date DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                transactions.add(mapResultSetToTransaction(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return transactions;
    }
    
    public List<Transaction> getActiveTransactions() {
        List<Transaction> transactions = new ArrayList<>();
        String sql = "SELECT t.*, u.username, u.full_name, b.title, b.author " +
                    "FROM transactions t " +
                    "JOIN users u ON t.user_id = u.id " +
                    "JOIN books b ON t.book_id = b.id " +
                    "WHERE t.status = 'ISSUED' " +
                    "ORDER BY t.due_date ASC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                transactions.add(mapResultSetToTransaction(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return transactions;
    }
    
    public List<Transaction> getOverdueTransactions() {
        List<Transaction> transactions = new ArrayList<>();
        String sql = "SELECT t.*, u.username, u.full_name, b.title, b.author " +
                    "FROM transactions t " +
                    "JOIN users u ON t.user_id = u.id " +
                    "JOIN books b ON t.book_id = b.id " +
                    "WHERE t.status = 'ISSUED' AND t.due_date < CURDATE() " +
                    "ORDER BY t.due_date ASC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                transactions.add(mapResultSetToTransaction(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return transactions;
    }
    
    public List<Transaction> getUserTransactions(int userId) {
        List<Transaction> transactions = new ArrayList<>();
        String sql = "SELECT t.*, u.username, u.full_name, b.title, b.author " +
                    "FROM transactions t " +
                    "JOIN users u ON t.user_id = u.id " +
                    "JOIN books b ON t.book_id = b.id " +
                    "WHERE t.user_id = ? " +
                    "ORDER BY t.issue_date DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                transactions.add(mapResultSetToTransaction(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return transactions;
    }
    
    public List<Transaction> getBookTransactions(int bookId) {
        List<Transaction> transactions = new ArrayList<>();
        String sql = "SELECT t.*, u.username, u.full_name, b.title, b.author " +
                    "FROM transactions t " +
                    "JOIN users u ON t.user_id = u.id " +
                    "JOIN books b ON t.book_id = b.id " +
                    "WHERE t.book_id = ? " +
                    "ORDER BY t.issue_date DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, bookId);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                transactions.add(mapResultSetToTransaction(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return transactions;
    }
    
    public Transaction getTransactionById(int id) {
        String sql = "SELECT t.*, u.username, u.full_name, b.title, b.author " +
                    "FROM transactions t " +
                    "JOIN users u ON t.user_id = u.id " +
                    "JOIN books b ON t.book_id = b.id " +
                    "WHERE t.id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToTransaction(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public boolean hasActiveTransaction(int userId, int bookId) {
        String sql = "SELECT COUNT(*) FROM transactions WHERE user_id = ? AND book_id = ? AND status = 'ISSUED'";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userId);
            ps.setInt(2, bookId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean updateOverdueStatus() {
        String sql = "UPDATE transactions SET status = 'OVERDUE' WHERE status = 'ISSUED' AND due_date < CURDATE()";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            return ps.executeUpdate() >= 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    private Transaction mapResultSetToTransaction(ResultSet rs) throws SQLException {
        Transaction transaction = new Transaction();
        transaction.setId(rs.getInt("id"));
        transaction.setUserId(rs.getInt("user_id"));
        transaction.setBookId(rs.getInt("book_id"));
        transaction.setIssueDate(rs.getTimestamp("issue_date"));
        transaction.setDueDate(rs.getDate("due_date"));
        transaction.setReturnDate(rs.getTimestamp("return_date"));
        transaction.setFineAmount(rs.getBigDecimal("fine_amount"));
        transaction.setStatus(Transaction.TransactionStatus.valueOf(rs.getString("status")));
        
        // Additional fields for display
        transaction.setUserName(rs.getString("full_name"));
        transaction.setBookTitle(rs.getString("title"));
        transaction.setBookAuthor(rs.getString("author"));
        
        return transaction;
    }
}
