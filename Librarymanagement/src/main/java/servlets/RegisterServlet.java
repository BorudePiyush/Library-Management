package servlets;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import dao.userDAO;
import model.User;
import java.io.IOException;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private userDAO userDAO = new userDAO();
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        
        try {
            // Check if username or email already exists
            if (userDAO.isUsernameExists(username)) {
                response.sendRedirect("register.jsp?error=username_exists");
                return;
            }
            
            if (userDAO.isEmailExists(email)) {
                response.sendRedirect("register.jsp?error=email_exists");
                return;
            }
            
            // Create new user
            User user = new User(username, password, email, fullName, phone, address);
            boolean success = userDAO.registerUser(user);
            
            if (success) {
                response.sendRedirect("login.jsp?success=registered");
            } else {
                response.sendRedirect("register.jsp?error=registration_failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?error=exception");
        }
    }
}