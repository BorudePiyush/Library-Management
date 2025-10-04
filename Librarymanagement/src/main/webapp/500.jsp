<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Internal Server Error - Library Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="style.css" rel="stylesheet">

<body class="bg-light">
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-8 text-center">
                <div class="card shadow">
                    <div class="card-body p-5">
                        <h1 class="display-1 text-danger">500</h1>
                        <h2 class="mb-4">Internal Server Error</h2>
                        <p class="text-muted mb-4">
                            Sorry, something went wrong on our end. The server encountered an internal error 
                            and was unable to complete your request.
                        </p>
                        <p class="text-muted mb-4">
                            Please try again later or contact the system administrator if the problem persists.
                        </p>
                        <div class="d-grid gap-2 d-md-block">
                            <a href="../index.jsp" class="btn btn-primary">Go Home</a>
                            <a href="javascript:history.back()" class="btn btn-secondary">Go Back</a>
                        </div>
                        
                        <% if (request.getAttribute("jakarta.servlet.error.exception") != null) { %>
                            <details class="mt-4 text-start">
                                <summary class="btn btn-outline-secondary btn-sm">Technical Details</summary>
                                <div class="mt-3 p-3 bg-light rounded">
                                    <h6>Error Details:</h6>
                                    <p><strong>Exception:</strong> <%= request.getAttribute("jakarta.servlet.error.exception_type") %></p>
                                    <p><strong>Message:</strong> <%= request.getAttribute("jakarta.servlet.error.message") %></p>
                                    <p><strong>Request URI:</strong> <%= request.getAttribute("jakarta.servlet.error.request_uri") %></p>
                                </div>
                            </details>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>