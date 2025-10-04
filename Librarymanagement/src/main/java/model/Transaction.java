package model;

import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

public class Transaction {
    private int id;
    private int userId;
    private int bookId;
    private Timestamp issueDate;
    private Date dueDate;
    private Timestamp returnDate;
    private BigDecimal fineAmount;
    private TransactionStatus status;
    
    // Additional fields for display purposes
    private String userName;
    private String bookTitle;
    private String bookAuthor;
    
    public enum TransactionStatus {
        ISSUED, RETURNED, OVERDUE
    }
    
    // Default constructor
    public Transaction() {
        this.status = TransactionStatus.ISSUED;
        this.fineAmount = BigDecimal.ZERO;
    }
    
    // Parameterized constructor
    public Transaction(int userId, int bookId, Date dueDate) {
        this.userId = userId;
        this.bookId = bookId;
        this.dueDate = dueDate;
        this.status = TransactionStatus.ISSUED;
        this.fineAmount = BigDecimal.ZERO;
    }
    
    // Getters and Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public int getUserId() {
        return userId;
    }
    
    public void setUserId(int userId) {
        this.userId = userId;
    }
    
    public int getBookId() {
        return bookId;
    }
    
    public void setBookId(int bookId) {
        this.bookId = bookId;
    }
    
    public Timestamp getIssueDate() {
        return issueDate;
    }
    
    public void setIssueDate(Timestamp issueDate) {
        this.issueDate = issueDate;
    }
    
    public Date getDueDate() {
        return dueDate;
    }
    
    public void setDueDate(Date dueDate) {
        this.dueDate = dueDate;
    }
    
    public Timestamp getReturnDate() {
        return returnDate;
    }
    
    public void setReturnDate(Timestamp returnDate) {
        this.returnDate = returnDate;
    }
    
    public BigDecimal getFineAmount() {
        return fineAmount;
    }
    
    public void setFineAmount(BigDecimal fineAmount) {
        this.fineAmount = fineAmount;
    }
    
    public TransactionStatus getStatus() {
        return status;
    }
    
    public void setStatus(TransactionStatus status) {
        this.status = status;
    }
    
    public String getUserName() {
        return userName;
    }
    
    public void setUserName(String userName) {
        this.userName = userName;
    }
    
    public String getBookTitle() {
        return bookTitle;
    }
    
    public void setBookTitle(String bookTitle) {
        this.bookTitle = bookTitle;
    }
    
    public String getBookAuthor() {
        return bookAuthor;
    }
    
    public void setBookAuthor(String bookAuthor) {
        this.bookAuthor = bookAuthor;
    }
    
    @Override
    public String toString() {
        return "Transaction{" +
                "id=" + id +
                ", userId=" + userId +
                ", bookId=" + bookId +
                ", issueDate=" + issueDate +
                ", dueDate=" + dueDate +
                ", returnDate=" + returnDate +
                ", fineAmount=" + fineAmount +
                ", status=" + status +
                ", userName='" + userName + '\'' +
                ", bookTitle='" + bookTitle + '\'' +
                ", bookAuthor='" + bookAuthor + '\'' +
                '}';
    }
}