<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="dao.*, model.*" %>
<%@ page import="java.util.List" %>
<%
    // Check if user is logged in
    if(session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    User user = (User) session.getAttribute("user");
    TransactionDAO transactionDAO = new TransactionDAO();
    BookDAO bookDAO = new BookDAO();
    
    List<Transaction> userTransactions = transactionDAO.getUserTransactions(user.getId());
    int activeTransactions = 0;
    for (Transaction t : userTransactions) {
        if (t.getStatus() == Transaction.TransactionStatus.ISSUED) {
            activeTransactions++;
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>User Dashboard - Library Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="css/style.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="userDashboard.jsp">
                <i class="fas fa-user me-2"></i>User Dashboard
            </a>
            <div class="navbar-nav ms-auto">
                <span class="navbar-text me-3">
                    Welcome, <%= user.getFullName() %>
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
                        <a href="userDashboard.jsp" class="list-group-item list-group-item-action active">
                            <i class="fas fa-home me-2"></i>Dashboard
                        </a>
                        <a href="BookServlet" class="list-group-item list-group-item-action">
                            <i class="fas fa-book me-2"></i>Browse Books
                        </a>
                        <a href="TransactionServlet?action=user" class="list-group-item list-group-item-action">
                            <i class="fas fa-history me-2"></i>My Transactions
                        </a>
                        <a href="userProfile.jsp" class="list-group-item list-group-item-action">
                            <i class="fas fa-user-edit me-2"></i>My Profile
                        </a>
                    </div>
                </div>
            </div>
            
            <!-- Main Content -->
            <div class="col-md-9">
                <h2 class="mb-4">Dashboard Overview</h2>
                
                <!-- User Statistics -->
                <div class="row mb-4">
                    <div class="col-md-4 mb-3">
                        <div class="card bg-primary text-white">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <h6 class="card-title">Books Borrowed</h6>
                                        <h3 class="mb-0"><%= userTransactions.size() %></h3>
                                    </div>
                                    <div class="align-self-center">
                                        <i class="fas fa-book fa-2x"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-4 mb-3">
                        <div class="card bg-success text-white">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <h6 class="card-title">Currently Reading</h6>
                                        <h3 class="mb-0"><%= activeTransactions %></h3>
                                    </div>
                                    <div class="align-self-center">
                                        <i class="fas fa-book-reader fa-2x"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-4 mb-3">
                        <div class="card bg-info text-white">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <h6 class="card-title">Member Since</h6>
                                        <h5 class="mb-0"><%= user.getRegistrationDate().toString().substring(0, 10) %></h5>
                                    </div>
                                    <div class="align-self-center">
                                        <i class="fas fa-calendar fa-2x"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Quick Actions -->
                <div class="row mb-4">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="mb-0"><i class="fas fa-bolt me-2"></i>Quick Actions</h5>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <div class="d-grid">
                                            <a href="BookServlet" class="btn btn-primary btn-lg">
                                                <i class="fas fa-search me-2"></i>Browse Books
                                            </a>
                                        </div>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <div class="d-grid">
                                            <a href="TransactionServlet?action=user" class="btn btn-success btn-lg">
                                                <i class="fas fa-history me-2"></i>My Transaction History
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Current Books -->
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="mb-0"><i class="fas fa-book-open me-2"></i>Currently Reading</h5>
                            </div>
                            <div class="card-body">
                                <%
                                boolean hasActiveTransactions = false;
                                for (Transaction transaction : userTransactions) {
                                    if (transaction.getStatus() == Transaction.TransactionStatus.ISSUED) {
                                        hasActiveTransactions = true;
                                        break;
                                    }
                                }
                                
                                if (hasActiveTransactions) {
                                %>
                                <div class="table-responsive">
                                    <table class="table table-striped">
                                        <thead>
                                            <tr>
                                                <th>Book Title</th>
                                                <th>Author</th>
                                                <th>Issue Date</th>
                                                <th>Due Date</th>
                                                <th>Status</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <% for (Transaction transaction : userTransactions) {
                                                if (transaction.getStatus() == Transaction.TransactionStatus.ISSUED) {
                                            %>
                                            <tr>
                                                <td><%= transaction.getBookTitle() %></td>
                                                <td><%= transaction.getBookAuthor() %></td>
                                                <td><%= transaction.getIssueDate().toString().substring(0, 10) %></td>
                                                <td><%= transaction.getDueDate() %></td>
                                                <td>
                                                    <span class="badge bg-<%= transaction.getStatus().equals("OVERDUE") ? "danger" : "success" %>">
                                                        <%= transaction.getStatus() %>
                                                    </span>
                                                </td>
                                            </tr>
                                            <% } } %>
                                        </tbody>
                                    </table>
                                </div>
                                <% } else { %>
                                    <div class="text-center py-4">
                                        <i class="fas fa-book fa-3x text-muted mb-3"></i>
                                        <p class="text-muted">You haven't borrowed any books yet.</p>
                                        <a href="BookServlet" class="btn btn-primary">Browse Books</a>
                                    </div>
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