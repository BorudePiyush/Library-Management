package servlets;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import dao.TransactionDAO;
import dao.BookDAO;
import dao.userDAO;
import model.Transaction;
import model.Book;
import model.User;
import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.math.BigDecimal;

@WebServlet("/TransactionServlet")
public class TransactionServlet extends HttpServlet {
    private TransactionDAO transactionDAO = new TransactionDAO();
    private BookDAO bookDAO = new BookDAO();
    private userDAO userDAO = new userDAO();
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "list";
        }
        
        switch (action) {
            case "list":
                listTransactions(request, response);
                break;
            case "active":
                listActiveTransactions(request, response);
                break;
            case "overdue":
                listOverdueTransactions(request, response);
                break;
            case "user":
                listUserTransactions(request, response);
                break;
            case "issueForm":
                showIssueForm(request, response);
                break;
            case "returnForm":
                showReturnForm(request, response);
                break;
            default:
                listTransactions(request, response);
                break;
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("issue".equals(action)) {
            issueBook(request, response);
        } else if ("return".equals(action)) {
            returnBook(request, response);
        }
    }
    
    private void listTransactions(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setAttribute("transactions", transactionDAO.getAllTransactions());
        RequestDispatcher dispatcher = request.getRequestDispatcher("transactionList.jsp");
        dispatcher.forward(request, response);
    }
    
    private void listActiveTransactions(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setAttribute("transactions", transactionDAO.getActiveTransactions());
        RequestDispatcher dispatcher = request.getRequestDispatcher("activeTransactions.jsp");
        dispatcher.forward(request, response);
    }
    
    private void listOverdueTransactions(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        transactionDAO.updateOverdueStatus(); // Update overdue status first
        request.setAttribute("transactions", transactionDAO.getOverdueTransactions());
        RequestDispatcher dispatcher = request.getRequestDispatcher("overdueTransactions.jsp");
        dispatcher.forward(request, response);
    }
    
    private void listUserTransactions(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        
        if (userId != null) {
            request.setAttribute("transactions", transactionDAO.getUserTransactions(userId));
            RequestDispatcher dispatcher = request.getRequestDispatcher("userTransactions.jsp");
            dispatcher.forward(request, response);
        } else {
            response.sendRedirect("login.jsp");
        }
    }
    
    private void showIssueForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setAttribute("users", userDAO.getActiveUsers());
        request.setAttribute("books", bookDAO.getAvailableBooks());
        RequestDispatcher dispatcher = request.getRequestDispatcher("issueBook.jsp");
        dispatcher.forward(request, response);
    }
    
    private void showReturnForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setAttribute("transactions", transactionDAO.getActiveTransactions());
        RequestDispatcher dispatcher = request.getRequestDispatcher("returnBook.jsp");
        dispatcher.forward(request, response);
    }
    
    private void issueBook(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int userId = Integer.parseInt(request.getParameter("userId"));
            int bookId = Integer.parseInt(request.getParameter("bookId"));
            int daysToReturn = Integer.parseInt(request.getParameter("daysToReturn"));
            
            // Check if user already has this book
            if (transactionDAO.hasActiveTransaction(userId, bookId)) {
                response.sendRedirect("TransactionServlet?action=issueForm&error=already_issued");
                return;
            }
            
            // Check if book is available
            Book book = bookDAO.getBookById(bookId);
            if (book == null || book.getAvailableCopies() <= 0) {
                response.sendRedirect("TransactionServlet?action=issueForm&error=not_available");
                return;
            }
            
            // Calculate due date
            LocalDate dueDate = LocalDate.now().plusDays(daysToReturn);
            
            Transaction transaction = new Transaction(userId, bookId, Date.valueOf(dueDate));
            boolean success = transactionDAO.issueBook(transaction);
            
            if (success) {
                response.sendRedirect("TransactionServlet?action=active&success=issued");
            } else {
                response.sendRedirect("TransactionServlet?action=issueForm&error=issue_failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("TransactionServlet?action=issueForm&error=exception");
        }
    }
    
    private void returnBook(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int transactionId = Integer.parseInt(request.getParameter("transactionId"));
            String fineAmountStr = request.getParameter("fineAmount");
            
            BigDecimal fineAmount = BigDecimal.ZERO;
            if (fineAmountStr != null && !fineAmountStr.trim().isEmpty()) {
                fineAmount = new BigDecimal(fineAmountStr);
            }
            
            boolean success = transactionDAO.returnBook(transactionId, fineAmount);
            
            if (success) {
                response.sendRedirect("TransactionServlet?action=active&success=returned");
            } else {
                response.sendRedirect("TransactionServlet?action=returnForm&error=return_failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("TransactionServlet?action=returnForm&error=exception");
        }
    }
}
