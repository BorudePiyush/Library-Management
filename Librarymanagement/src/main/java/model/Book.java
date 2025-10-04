package model;

import java.sql.Timestamp;

public class Book {
    private int id;
    private String isbn;
    private String title;
    private String author;
    private String publisher;
    private String category;
    private int totalCopies;
    private int availableCopies;
    private int publicationYear;
    private Timestamp addedDate;
    
    // Default constructor
    public Book() {}
    
    // Parameterized constructor
    public Book(String isbn, String title, String author, String publisher, 
                String category, int totalCopies, int publicationYear) {
        this.isbn = isbn;
        this.title = title;
        this.author = author;
        this.publisher = publisher;
        this.category = category;
        this.totalCopies = totalCopies;
        this.availableCopies = totalCopies;
        this.publicationYear = publicationYear;
    }
    
    // Getters and Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public String getIsbn() {
        return isbn;
    }
    
    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }
    
    public String getTitle() {
        return title;
    }
    
    public void setTitle(String title) {
        this.title = title;
    }
    
    public String getAuthor() {
        return author;
    }
    
    public void setAuthor(String author) {
        this.author = author;
    }
    
    public String getPublisher() {
        return publisher;
    }
    
    public void setPublisher(String publisher) {
        this.publisher = publisher;
    }
    
    public String getCategory() {
        return category;
    }
    
    public void setCategory(String category) {
        this.category = category;
    }
    
    public int getTotalCopies() {
        return totalCopies;
    }
    
    public void setTotalCopies(int totalCopies) {
        this.totalCopies = totalCopies;
    }
    
    public int getAvailableCopies() {
        return availableCopies;
    }
    
    public void setAvailableCopies(int availableCopies) {
        this.availableCopies = availableCopies;
    }
    
    public int getPublicationYear() {
        return publicationYear;
    }
    
    public void setPublicationYear(int publicationYear) {
        this.publicationYear = publicationYear;
    }
    
    public Timestamp getAddedDate() {
        return addedDate;
    }
    
    public void setAddedDate(Timestamp addedDate) {
        this.addedDate = addedDate;
    }
    
    @Override
    public String toString() {
        return "Book{" +
                "id=" + id +
                ", isbn='" + isbn + '\'' +
                ", title='" + title + '\'' +
                ", author='" + author + '\'' +
                ", publisher='" + publisher + '\'' +
                ", category='" + category + '\'' +
                ", totalCopies=" + totalCopies +
                ", availableCopies=" + availableCopies +
                ", publicationYear=" + publicationYear +
                ", addedDate=" + addedDate +
                '}';
    }
}