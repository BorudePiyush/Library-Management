package servlets;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import dao.BookDAO;
import model.Book;
import java.io.IOException;

@WebServlet("/BookServlet")
public class BookServlet extends HttpServlet {
    private BookDAO bookDAO = new BookDAO();
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "list";
        }
        
        switch (action) {
            case "list":
                listBooks(request, response);
                break;
            case "search":
                searchBooks(request, response);
                break;
            case "view":
                viewBook(request, response);
                break;
            case "delete":
                deleteBook(request, response);
                break;
            default:
                listBooks(request, response);
                break;
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("add".equals(action)) {
            addBook(request, response);
        } else if ("update".equals(action)) {
            updateBook(request, response);
        }
    }
    
    private void listBooks(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setAttribute("books", bookDAO.getAllBooks());
        RequestDispatcher dispatcher = request.getRequestDispatcher("bookList.jsp");
        dispatcher.forward(request, response);
    }
    
    private void searchBooks(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String searchTerm = request.getParameter("search");
        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            request.setAttribute("books", bookDAO.searchBooks(searchTerm));
            request.setAttribute("searchTerm", searchTerm);
        } else {
            request.setAttribute("books", bookDAO.getAllBooks());
        }
        RequestDispatcher dispatcher = request.getRequestDispatcher("bookList.jsp");
        dispatcher.forward(request, response);
    }
    
    private void viewBook(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Book book = bookDAO.getBookById(id);
        request.setAttribute("book", book);
        RequestDispatcher dispatcher = request.getRequestDispatcher("bookDetails.jsp");
        dispatcher.forward(request, response);
    }
    
    private void addBook(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            String isbn = request.getParameter("isbn");
            String title = request.getParameter("title");
            String author = request.getParameter("author");
            String publisher = request.getParameter("publisher");
            String category = request.getParameter("category");
            int totalCopies = Integer.parseInt(request.getParameter("totalCopies"));
            int publicationYear = Integer.parseInt(request.getParameter("publicationYear"));
            
            Book book = new Book(isbn, title, author, publisher, category, totalCopies, publicationYear);
            boolean success = bookDAO.addBook(book);
            
            if (success) {
                response.sendRedirect("BookServlet?success=added");
            } else {
                response.sendRedirect("addBook.jsp?error=add_failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("addBook.jsp?error=exception");
        }
    }
    
    private void updateBook(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String isbn = request.getParameter("isbn");
            String title = request.getParameter("title");
            String author = request.getParameter("author");
            String publisher = request.getParameter("publisher");
            String category = request.getParameter("category");
            int totalCopies = Integer.parseInt(request.getParameter("totalCopies"));
            int availableCopies = Integer.parseInt(request.getParameter("availableCopies"));
            int publicationYear = Integer.parseInt(request.getParameter("publicationYear"));
            
            Book book = new Book(isbn, title, author, publisher, category, totalCopies, publicationYear);
            book.setId(id);
            book.setAvailableCopies(availableCopies);
            
            boolean success = bookDAO.updateBook(book);
            
            if (success) {
                response.sendRedirect("BookServlet?success=updated");
            } else {
                response.sendRedirect("editBook.jsp?id=" + id + "&error=update_failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("BookServlet?error=exception");
        }
    }
    
    private void deleteBook(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            boolean success = BookDAO.deleteBook(id);
            
            if (success) {
                response.sendRedirect("BookServlet?success=deleted");
            } else {
                response.sendRedirect("BookServlet?error=delete_failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("BookServlet?error=exception");
        }
    }
}