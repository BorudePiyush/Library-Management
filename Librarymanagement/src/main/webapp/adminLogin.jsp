<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
 <title>Admin Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="style.css" rel="stylesheet">

</head>
<body class="bg-light">
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="index.jsp">Library Management</a>
            <div class="navbar-nav ms-auto">
                <a class="nav-link" href="index.jsp">Home</a>
                <a class="nav-link" href="login.jsp">User Login</a>
                <a class="nav-link" href="register.jsp">Register</a>
            </div>
        </div>
    </nav>

    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-4">
                <div class="card p-4 shadow">
                    <h3 class="text-center mb-3">Admin Login</h3>
                    
                    <% String error = request.getParameter("error"); 
                       if("invalid".equals(error)){ %>
                       <div class="alert alert-danger">Invalid admin credentials!</div>
                    <% } else if("exception".equals(error)) { %>
                       <div class="alert alert-danger">System error occurred!</div>
                    <% } %>
                    
                    <form action="AdminLoginServlet" method="post">
                        <div class="mb-3">
                            <label class="form-label">Username</label>
                            <input type="text" name="username" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Password</label>
                            <input type="password" name="password" class="form-control" required>
                        </div>
                        <button type="submit" class="btn btn-primary w-100">Login</button>
                    </form>
                    
                    <div class="text-center mt-3">
                        <small class="text-muted">Default: admin/admin123</small>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
