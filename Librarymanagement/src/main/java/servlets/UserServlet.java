package servlets;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import dao.userDAO;
import model.User;
import java.io.IOException;
import java.util.List;

@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {
    private userDAO userDAO = new userDAO();
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "list";
        }
        
        switch (action) {
            case "list":
                listUsers(request, response);
                break;
            case "search":
                searchUsers(request, response);
                break;
            case "view":
                viewUser(request, response);
                break;
            case "edit":
                editUser(request, response);
                break;
            case "deactivate":
                deactivateUser(request, response);
                break;
            default:
                listUsers(request, response);
                break;
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("update".equals(action)) {
            updateUser(request, response);
        } else if ("changePassword".equals(action)) {
            changePassword(request, response);
        }
    }
    
    private void listUsers(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<User> users = userDAO.getAllUsers();
        request.setAttribute("users", users);
        RequestDispatcher dispatcher = request.getRequestDispatcher("userList.jsp");
        dispatcher.forward(request, response);
    }
    
    private void searchUsers(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String searchTerm = request.getParameter("search");
        List<User> users;
        
        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            users = userDAO.searchUsers(searchTerm);
            request.setAttribute("searchTerm", searchTerm);
        } else {
            users = userDAO.getAllUsers();
        }
        
        request.setAttribute("users", users);
        RequestDispatcher dispatcher = request.getRequestDispatcher("userList.jsp");
        dispatcher.forward(request, response);
    }
    
    private void viewUser(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        User user = userDAO.getUserById(id);
        request.setAttribute("user", user);
        RequestDispatcher dispatcher = request.getRequestDispatcher("userDetails.jsp");
        dispatcher.forward(request, response);
    }
    
    private void editUser(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        User user = userDAO.getUserById(id);
        request.setAttribute("user", user);
        RequestDispatcher dispatcher = request.getRequestDispatcher("editUser.jsp");
        dispatcher.forward(request, response);
    }
    
    private void updateUser(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String fullName = request.getParameter("fullName");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            boolean isActive = "true".equals(request.getParameter("isActive"));
            
            User user = userDAO.getUserById(id);
            if (user != null) {
                user.setUsername(username);
                user.setEmail(email);
                user.setFullName(fullName);
                user.setPhone(phone);
                user.setAddress(address);
                user.setActive(isActive);
                
                boolean success = userDAO.updateUser(user);
                
                if (success) {
                    response.sendRedirect("UserServlet?success=updated");
                } else {
                    response.sendRedirect("UserServlet?action=edit&id=" + id + "&error=update_failed");
                }
            } else {
                response.sendRedirect("UserServlet?error=user_not_found");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("UserServlet?error=exception");
        }
    }
    
    private void changePassword(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int userId = Integer.parseInt(request.getParameter("userId"));
            String newPassword = request.getParameter("newPassword");
            
            boolean success = userDAO.updatePassword(userId, newPassword);
            
            if (success) {
                response.sendRedirect("UserServlet?action=view&id=" + userId + "&success=password_changed");
            } else {
                response.sendRedirect("UserServlet?action=view&id=" + userId + "&error=password_change_failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("UserServlet?error=exception");
        }
    }
    
    private void deactivateUser(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            boolean success = userDAO.deactivateUser(id);
            
            if (success) {
                response.sendRedirect("UserServlet?success=deactivated");
            } else {
                response.sendRedirect("UserServlet?error=deactivate_failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("UserServlet?error=exception");
        }
    }
}