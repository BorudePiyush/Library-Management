<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@ page import="dao.*, model.*" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
 <title>Issue Book - Library Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="css/style.css" rel="stylesheet">
</head>
<body class="bg-light">
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="dashboard.jsp">Library Management</a>
            <div class="navbar-nav ms-auto">
                <a class="nav-link" href="dashboard.jsp">Dashboard</a>
                <a class="nav-link" href="LogoutServlet">Logout</a>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card shadow">
                    <div class="card-header bg-success text-white">
                        <h4 class="mb-0">Issue Book</h4>
                    </div>
                    <div class="card-body">
                        <%
                        String error = request.getParameter("error");
                        if("already_issued".equals(error)) { %>
                            <div class="alert alert-warning">This user has already borrowed this book!</div>
                        <% } else if("not_available".equals(error)) { %>
                            <div class="alert alert-danger">Book is not available for issuing!</div>
                        <% } else if("issue_failed".equals(error)) { %>
                            <div class="alert alert-danger">Failed to issue book! Please try again.</div>
                        <% } else if("exception".equals(error)) { %>
                            <div class="alert alert-danger">System error occurred!</div>
                        <% } %>
                        
                        <form action="TransactionServlet" method="post">
                            <input type="hidden" name="action" value="issue">
                            
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Select User *</label>
                                    <select name="userId" class="form-select" required>
                                        <option value="">Choose User</option>
                                        <option value="">PIYUSH</option>
                                        <%
                                        @SuppressWarnings("unchecked")
                                        List<User> users = (List<User>) request.getAttribute("users");
                                        if (users != null) {
                                            for (User user : users) {
                                        %>
                                        <option value="<%= user.getId() %>"><%= user.getFullName() %> (<%= user.getUsername() %>)</option>
                                        <% } } %>
                                    </select>
                                </div>
                                
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Select Book *</label>
                                    <select name="bookId" class="form-select" required>
                                        <option value="">Choose Book</option>
                                        <option vale="">CHHAVA</option>
                                        <%
                                        @SuppressWarnings("unchecked")
                                        List<Book> books = (List<Book>) request.getAttribute("books");
                                        if (books != null) {
                                            for (Book book : books) {
                                        %>
                                        <option value="<%= book.getId() %>">
                                            <%= book.getTitle() %> by <%= book.getAuthor() %> 
                                            (Available: <%= book.getAvailableCopies() %>)
                                        </option>
                                        <% } } %>
                                    </select>
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label">Return Period (Days) *</label>
                                <select name="daysToReturn" class="form-select" required>
                                    <option value="7">7 Days</option>
                                    <option value="14" selected>14 Days</option>
                                    <option value="21">21 Days</option>
                                    <option value="30">30 Days</option>
                                </select>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-12 text-center">
                                    <button type="submit" class="btn btn-success btn-lg me-2">Issue Book</button>
                                    <a href="TransactionServlet?action=active" class="btn btn-secondary btn-lg">Cancel</a>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>