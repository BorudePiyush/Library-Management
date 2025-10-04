<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
 <title>User Registration</title>
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
                <a class="nav-link" href="adminLogin.jsp">Admin Login</a>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card p-4 shadow">
                    <h3 class="text-center mb-4">User Registration</h3>
                    
                    <% 
                    String error = request.getParameter("error");
                    if("username_exists".equals(error)) { %>
                        <div class="alert alert-danger">Username already exists!</div>
                    <% } else if("email_exists".equals(error)) { %>
                        <div class="alert alert-danger">Email already exists!</div>
                    <% } else if("registration_failed".equals(error)) { %>
                        <div class="alert alert-danger">Registration failed! Please try again.</div>
                    <% } else if("exception".equals(error)) { %>
                        <div class="alert alert-danger">System error occurred!</div>
                    <% } %>
                    
                    <form action="RegisterServlet" method="post" onsubmit="return validateForm()">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Username *</label>
                                <input type="text" name="username" id="username" class="form-control" required minlength="3" maxlength="50">
                                <div class="form-text">Minimum 3 characters</div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Password *</label>
                                <input type="password" name="password" id="password" class="form-control" required minlength="6">
                                <div class="form-text">Minimum 6 characters</div>
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Email *</label>
                            <input type="email" name="email" id="email" class="form-control" required>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Full Name *</label>
                            <input type="text" name="fullName" id="fullName" class="form-control" required maxlength="100">
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Phone</label>
                            <input type="tel" name="phone" id="phone" class="form-control" maxlength="15">
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Address</label>
                            <textarea name="address" id="address" class="form-control" rows="3" maxlength="500"></textarea>
                        </div>
                        
                        <div class="mb-3 form-check">
                            <input type="checkbox" class="form-check-input" id="terms" required>
                            <label class="form-check-label" for="terms">
                                I agree to the terms and conditions
                            </label>
                        </div>
                        
                        <button type="submit" class="btn btn-success w-100">Register</button>
                    </form>
                    
                    <div class="text-center mt-3">
                        <p>Already have an account? <a href="login.jsp">Login here</a></p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        function validateForm() {
            var password = document.getElementById("password").value;
            var email = document.getElementById("email").value;
            var phone = document.getElementById("phone").value;
            
            if (password.length < 6) {
                alert("Password must be at least 6 characters long!");
                return false;
            }
            
            // Basic email validation
            var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailPattern.test(email)) {
                alert("Please enter a valid email address!");
                return false;
            }
            
            // Phone validation if provided
            if (phone && phone.length > 0) {
                var phonePattern = /^[0-9\+\-\s\(\)]+$/;
                if (!phonePattern.test(phone)) {
                    alert("Please enter a valid phone number!");
                    return false;
                }
            }
            
            return true;
        }
    </script>
</body>
</html>