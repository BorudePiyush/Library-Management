<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="dao.*, model.*" %>
<%@ page import="java.util.List" %>
<%
    // Check if admin is logged in
    if(session.getAttribute("admin") == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
    
    // Initialize DAOs and get statistics
    BookDAO bookDAO = new BookDAO();
    userDAO userDAO = new userDAO();
    TransactionDAO transactionDAO = new TransactionDAO();
    
    int totalBooks = bookDAO.getAllBooks().size();
    int totalUsers = userDAO.getAllUsers().size();
    int activeTransactions = transactionDAO.getActiveTransactions().size();
    int overdueTransactions = transactionDAO.getOverdueTransactions().size();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin Dashboard - Library Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="style.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="dashboard.jsp">
                <i class="fas fa-tachometer-alt me-2"></i>Admin Dashboard
            </a>
            <div class="navbar-nav ms-auto">
                <span class="navbar-text me-3">
                    Welcome, <%= session.getAttribute("admin") %>
                </span>
                <a href="LogoutServlet" class="btn btn-outline-light btn-sm">
                    <i class="fas fa-sign-out-alt me-1"></i>Logout
                </a>
            </div>
        </div>
    </nav>

    <div class="container-fluid mt-4">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-3">
                <div class="card">
                    <div class="card-header bg-secondary text-white">
                        <h6 class="mb-0"><i class="fas fa-bars me-2"></i>Menu</h6>
                    </div>
                    <div class="list-group list-group-flush">
                        <a href="dashboard.jsp" class="list-group-item list-group-item-action active">
                            <i class="fas fa-home me-2"></i>Dashboard
                        </a>
                        <a href="BookServlet" class="list-group-item list-group-item-action">
                            <i class="fas fa-book me-2"></i>Manage Books
                        </a>
                        <a href="UserServlet" class="list-group-item list-group-item-action">
                            <i class="fas fa-users me-2"></i>Manage Users
                        </a>
                        <a href="TransactionServlet?action=active" class="list-group-item list-group-item-action">
                            <i class="fas fa-exchange-alt me-2"></i>Active Transactions
                        </a>
                        <a href="TransactionServlet?action=overdue" class="list-group-item list-group-item-action">
                            <i class="fas fa-exclamation-triangle me-2"></i>Overdue Books
                        </a>
                        <a href="TransactionServlet?action=list" class="list-group-item list-group-item-action">
                            <i class="fas fa-history me-2"></i>Transaction History
                        </a>
                    </div>
                </div>
            </div>
            
            <!-- Main Content -->
            <div class="col-md-9">
                <h2 class="mb-4">Dashboard Overview</h2>
                
                <!-- Statistics Cards -->
                <div class="row mb-4">
                    <div class="col-md-3 mb-3">
                        <div class="card bg-primary text-white">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <h6 class="card-title">Total Books</h6>
                                        <h3 class="mb-0"><%= totalBooks %></h3>
                                    </div>
                                    <div class="align-self-center">
                                        <i class="fas fa-book fa-2x"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-3 mb-3">
                        <div class="card bg-success text-white">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <h6 class="card-title">Total Users</h6>
                                        <h3 class="mb-0"><%= totalUsers %></h3>
                                    </div>
                                    <div class="align-self-center">
                                        <i class="fas fa-users fa-2x"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-3 mb-3">
                        <div class="card bg-info text-white">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <h6 class="card-title">Active Issues</h6>
                                        <h3 class="mb-0"><%= activeTransactions %></h3>
                                    </div>
                                    <div class="align-self-center">
                                        <i class="fas fa-book-reader fa-2x"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-3 mb-3">
                        <div class="card bg-warning text-white">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <h6 class="card-title">Overdue</h6>
                                        <h3 class="mb-0"><%= overdueTransactions %></h3>
                                    </div>
                                    <div class="align-self-center">
                                        <i class="fas fa-exclamation-triangle fa-2x"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Quick Actions -->
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="mb-0"><i class="fas fa-bolt me-2"></i>Quick Actions</h5>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-4 mb-3">
                                        <div class="d-grid">
                                            <a href="addBook.jsp" class="btn btn-primary btn-lg">
                                                <i class="fas fa-plus-circle me-2"></i>Add New Book
                                            </a>
                                        </div>
                                    </div>
                                    <div class="col-md-4 mb-3">
                                        <div class="d-grid">
                                            <a href="TransactionServlet?action=issueForm" class="btn btn-success btn-lg">
                                                <i class="fas fa-book-open me-2"></i>Issue Book
                                            </a>
                                        </div>
                                    </div>
                                    <div class="col-md-4 mb-3">
                                        <div class="d-grid">
                                            <a href="TransactionServlet?action=returnForm" class="btn btn-warning btn-lg">
                                                <i class="fas fa-undo me-2"></i>Return Book
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Recent Transactions -->
                <div class="row mt-4">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="mb-0"><i class="fas fa-clock me-2"></i>Recent Transactions</h5>
                            </div>
                            <div class="card-body">
                                <%
                                List<Transaction> recentTransactions = transactionDAO.getActiveTransactions();
                                if (recentTransactions != null && !recentTransactions.isEmpty()) {
                                    int limit = Math.min(5, recentTransactions.size());
                                %>
                                <div class="table-responsive">
                                    <table class="table table-striped">
                                        <thead>
                                            <tr>
                                                <th>User</th>
                                                <th>Book</th>
                                                <th>Issue Date</th>
                                                <th>Due Date</th>
                                                <th>Status</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <% for (int i = 0; i < limit; i++) {
                                                Transaction transaction = recentTransactions.get(i);
                                            %>
                                            <tr>
                                                <td><%= transaction.getUserName() %></td>
                                                <td><%= transaction.getBookTitle() %></td>
                                                <td><%= transaction.getIssueDate() %></td>
                                                <td><%= transaction.getDueDate() %></td>
                                                <td>
                                                    <span class="badge bg-<%= transaction.getStatus().equals("OVERDUE") ? "danger" : "success" %>">
                                                        <%= transaction.getStatus() %>
                                                    </span>
                                                </td>
                                            </tr>
                                            <% } %>
                                        </tbody>
                                    </table>
                                </div>
                                <% } else { %>
                                    <p class="text-muted">No active transactions found.</p>
                                <% } %>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
