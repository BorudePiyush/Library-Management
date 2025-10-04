<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="model.Book" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta charset="UTF-8">
    <title>Book List - Library Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="css/style.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="<%= session.getAttribute("admin") != null ? "dashboard.jsp" : "userDashboard.jsp" %>">
                Library Management
            </a>
            <div class="navbar-nav ms-auto">
                <a class="nav-link" href="<%= session.getAttribute("admin") != null ? "dashboard.jsp" : "userDashboard.jsp" %>">
                    Dashboard
                </a>
                <a class="nav-link" href="LogoutServlet">Logout</a>
            </div>
        </div>
    </nav>

    <div class="container-fluid mt-4">
        <div class="row">
            <div class="col-md-12">
                <div class="card shadow">
                    <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
                        <h4 class="mb-0">Book Collection</h4>
                        <% if (session.getAttribute("admin") != null) { %>
                            <a href="addBook.jsp" class="btn btn-light btn-sm">
                                <i class="fas fa-plus me-1"></i>Add Book
                            </a>
                        <% } %>
                    </div>
                    <div class="card-body">
                        <!-- Search Bar -->
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <form action="BookServlet" method="get">
                                    <input type="hidden" name="action" value="search">
                                    <div class="input-group">
                                        <input type="text" name="search" class="form-control" 
                                               placeholder="Search by title, author, or ISBN..." 
                                               value="<%= request.getAttribute("searchTerm") != null ? request.getAttribute("searchTerm") : "" %>">
                                        <button class="btn btn-outline-secondary" type="submit">
                                            <i class="fas fa-search"></i>
                                        </button>
                                    </div>
                                </form>
                            </div>
                            <div class="col-md-6 text-end">
                                <% if (request.getAttribute("searchTerm") != null) { %>
                                    <a href="BookServlet" class="btn btn-secondary btn-sm">Clear Search</a>
                                <% } %>
                            </div>
                        </div>

                        <!-- Success/Error Messages -->
                        <%
                        String success = request.getParameter("success");
                        String error = request.getParameter("error");
                        
                        if ("added".equals(success)) { %>
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                Book added successfully!
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        <% } else if ("updated".equals(success)) { %>
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                Book updated successfully!
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        <% } else if ("deleted".equals(success)) { %>
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                Book deleted successfully!
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        <% } else if ("delete_failed".equals(error)) { %>
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                Failed to delete book! It may be currently issued.
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        <% } %>

                        <!-- Books Table -->
                        <div class="table-responsive">
                            <table class="table table-striped table-hover">
                                <thead class="table-dark">
                                    <tr>
                                        <th>ISBN</th>
                                        <th>Title</th>
                                        <th>Author</th>
                                        <th>Category</th>
                                        <th>Available/Total</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                    @SuppressWarnings("unchecked")
                                    List<Book> books = (List<Book>) request.getAttribute("books");
                                    
                                    if (books != null && !books.isEmpty()) {
                                        for (Book book : books) {
                                    %>
                                    <tr>
                                        <td><%= book.getIsbn() != null ? book.getIsbn() : "-" %></td>
                                        <td><strong><%= book.getTitle() %></strong></td>
                                        <td><%= book.getAuthor() %></td>
                                        <td><%= book.getCategory() != null ? book.getCategory() : "-" %></td>
                                        <td>
                                            <span class="badge bg-<%= book.getAvailableCopies() > 0 ? "success" : "danger" %>">
                                                <%= book.getAvailableCopies() %>/<%= book.getTotalCopies() %>
                                            </span>
                                        </td>
                                        <td>
                                            <div class="btn-group btn-group-sm" role="group">
                                                <a href="BookServlet?action=view&id=<%= book.getId() %>" 
                                                   class="btn btn-outline-info" title="View Details">
                                                    <i class="fas fa-eye"></i>
                                                </a>
                                                <% if (session.getAttribute("admin") != null) { %>
                                                    <a href="editBook.jsp?id=<%= book.getId() %>" 
                                                       class="btn btn-outline-warning" title="Edit">
                                                        <i class="fas fa-edit"></i>
                                                    </a>
                                                    <a href="BookServlet?action=delete&id=<%= book.getId() %>" 
                                                       class="btn btn-outline-danger" title="Delete"
                                                       onclick="return confirm('Are you sure you want to delete this book?')">
                                                        <i class="fas fa-trash"></i>
                                                    </a>
                                                <% } %>
                                            </div>
                                        </td>
                                    </tr>
                                    <% 
                                        }
                                    } else {
                                    %>
                                    <tr>
                                        <td colspan="6" class="text-center text-muted py-4">
                                            <i class="fas fa-book fa-2x mb-2"></i><br>
                                            No books found.
                                            <% if (session.getAttribute("admin") != null) { %>
                                                <br><a href="addBook.jsp" class="btn btn-primary btn-sm mt-2">Add First Book</a>
                                            <% } %>
                                        </td>
                                    </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>