<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add Book - Library Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="style.css" rel="stylesheet">
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
                    <div class="card-header bg-primary text-white">
                        <h4 class="mb-0">Add New Book</h4>
                    </div>
                    <div class="card-body">
                        <%
                        String error = request.getParameter("error");
                        if("add_failed".equals(error)) { %>
                            <div class="alert alert-danger">Failed to add book! Please try again.</div>
                        <% } else if("exception".equals(error)) { %>
                            <div class="alert alert-danger">System error occurred!</div>
                        <% } %>
                        
                        <form action="BookServlet" method="post" onsubmit="return validateForm()">
                            <input type="hidden" name="action" value="add">
                            
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">ISBN *</label>
                                    <input type="text" name="isbn" id="isbn" class="form-control" required maxlength="20">
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Title *</label>
                                    <input type="text" name="title" id="title" class="form-control" required maxlength="200">
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Author *</label>
                                    <input type="text" name="author" id="author" class="form-control" required maxlength="100">
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Publisher</label>
                                    <input type="text" name="publisher" id="publisher" class="form-control" maxlength="100">
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-4 mb-3">
                                    <label class="form-label">Category</label>
                                    <select name="category" id="category" class="form-select">
                                        <option value="">Select Category</option>
                                        <option value="Fiction">Fiction</option>
                                        <option value="Non-Fiction">Non-Fiction</option>
                                        <option value="Science">Science</option>
                                        <option value="Technology">Technology</option>
                                        <option value="History">History</option>
                                        <option value="Biography">Biography</option>
                                        <option value="Education">Education</option>
                                        <option value="Literature">Literature</option>
                                        <option value="Philosophy">Philosophy</option>
                                        <option value="Art">Art</option>
                                        <option value="Other">Other</option>
                                    </select>
                                </div>
                                <div class="col-md-4 mb-3">
                                    <label class="form-label">Total Copies *</label>
                                    <input type="number" name="totalCopies" id="totalCopies" class="form-control" required min="1" max="1000" value="1">
                                </div>
                                <div class="col-md-4 mb-3">
                                    <label class="form-label">Publication Year</label>
                                    <input type="number" name="publicationYear" id="publicationYear" class="form-control" min="1800" max="2024">
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-12 text-center">
                                    <button type="submit" class="btn btn-primary btn-lg me-2">Add Book</button>
                                    <a href="BookServlet" class="btn btn-secondary btn-lg">Cancel</a>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        function validateForm() {
            var totalCopies = document.getElementById("totalCopies").value;
            var publicationYear = document.getElementById("publicationYear").value;
            
            if (totalCopies < 1) {
                alert("Total copies must be at least 1!");
                return false;
            }
            
            if (publicationYear && (publicationYear < 1800 || publicationYear > 2024)) {
                alert("Please enter a valid publication year!");
                return false;
            }
            
            return true;
        }
    </script>
</body>
</html>