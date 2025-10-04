<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Library Management System - Welcome</title>
    <meta name="description" content="Modern Library Management System - Manage books, users, and transactions efficiently">
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="style.css" rel="stylesheet">
</head>
<body>
    <!-- Enhanced Header -->
    <header class="header-section">
        <!-- Top Bar -->
        <div class="top-bar bg-dark text-light py-2">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <div class="contact-info">
                            <span class="me-3"><i class="fas fa-envelope me-1"></i> teamlibrary847@gmail.com</span>
                            <span><i class="fas fa-phone me-1"></i> 9322771348</span>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="social-links text-end">
                            <a href="#" class="text-light me-2"><i class="fab fa-facebook-f"></i></a>
                            <a href="#" class="text-light me-2"><i class="fab fa-twitter"></i></a>
                            <a href="#" class="text-light me-2"><i class="fab fa-instagram"></i></a>
                            <a href="#" class="text-light"><i class="fab fa-linkedin-in"></i></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Main Navigation -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-gradient-primary shadow-lg">
            <div class="container">
                <a class="navbar-brand fw-bold fs-3" href="index.jsp">
                    <i class="fas fa-book-open me-2 text-warning"></i>
                    <span class="brand-text">LibraryHub</span>
                </a>
                
                <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item">
                            <a class="nav-link nav-link-hover active" href="index.jsp">
                                <i class="fas fa-home me-1"></i>Home
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link nav-link-hover" href="login.jsp">
                                <i class="fas fa-user me-1"></i>User Login
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link nav-link-hover" href="adminLogin.jsp">
                                <i class="fas fa-user-shield me-1"></i>Admin Login
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link nav-link-hover btn-outline-warning px-3 rounded-pill ms-2" href="register.jsp">
                                <i class="fas fa-user-plus me-1"></i>Register
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
    </header>

    <!-- Main Content -->
    <main class="main-content">
        <!-- Hero Section -->
        <section class="hero-section bg-gradient-primary text-white py-5">
            <div class="container">
                <div class="row align-items-center min-vh-50">
                    <div class="col-lg-6">
                        <h1 class="display-4 fw-bold mb-4 animate-fade-in">
                            Welcome to 
                            <span class="text-warning">LibraryHub</span>
                        </h1>
                        <p class="lead mb-4 animate-fade-in-delay">
                            Your modern digital library management system. Discover, borrow, and manage books with ease.
                        </p>
                        
                        <% if("logged_out".equals(request.getParameter("message"))) { %>
                            <div class="alert alert-success alert-dismissible fade show">
                                <i class="fas fa-check-circle me-2"></i>
                                You have been logged out successfully!
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        <% } %>
                        
                        <div class="hero-buttons mt-4">
                            <a href="register.jsp" class="btn btn-warning btn-lg me-3 rounded-pill px-4">
                                <i class="fas fa-user-plus me-2"></i>Get Started
                            </a>
                            <a href="login.jsp" class="btn btn-outline-light btn-lg rounded-pill px-4">
                                <i class="fas fa-sign-in-alt me-2"></i>Login
                            </a>
                        </div>
                    </div>
                    <div class="col-lg-6 text-center">
                        <div class="hero-image">
                            <i class="fas fa-book-open display-1 text-warning mb-3"></i>
                            <div class="floating-elements">
                                <i class="fas fa-book floating-book-1"></i>
                                <i class="fas fa-graduation-cap floating-book-2"></i>
                                <i class="fas fa-bookmark floating-book-3"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Services Section -->
        <section class="services-section py-5 bg-light">
            <div class="container">
                <div class="row text-center mb-5">
                    <div class="col-12">
                        <h2 class="fw-bold mb-3">Choose Your Access Level</h2>
                        <p class="text-muted">Select the appropriate option based on your role</p>
                    </div>
                </div>
                
                <div class="row g-4">
                    <div class="col-lg-4 col-md-6">
                        <div class="service-card card h-100 border-0 shadow-hover">
                            <div class="card-body p-4 text-center">
                                <div class="service-icon mb-3">
                                    <i class="fas fa-user-graduate fa-3x text-primary"></i>
                                </div>
                                <h5 class="card-title fw-bold">For Students</h5>
                                <p class="card-text text-muted mb-4">
                                    Browse our extensive book collection, track your borrowed items, and manage your library account seamlessly.
                                </p>
                                <a href="login.jsp" class="btn btn-primary rounded-pill px-4">
                                    <i class="fas fa-sign-in-alt me-2"></i>Student Login
                                </a>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-lg-4 col-md-6">
                        <div class="service-card card h-100 border-0 shadow-hover">
                            <div class="card-body p-4 text-center">
                                <div class="service-icon mb-3">
                                    <i class="fas fa-user-plus fa-3x text-success"></i>
                                </div>
                                <h5 class="card-title fw-bold">New User?</h5>
                                <p class="card-text text-muted mb-4">
                                    Join our library community today! Create an account to access thousands of books and digital resources.
                                </p>
                                <a href="register.jsp" class="btn btn-success rounded-pill px-4">
                                    <i class="fas fa-user-plus me-2"></i>Register Now
                                </a>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-lg-4 col-md-6">
                        <div class="service-card card h-100 border-0 shadow-hover">
                            <div class="card-body p-4 text-center">
                                <div class="service-icon mb-3">
                                    <i class="fas fa-user-shield fa-3x text-warning"></i>
                                </div>
                                <h5 class="card-title fw-bold">For Administrators</h5>
                                <p class="card-text text-muted mb-4">
                                    Comprehensive admin panel to manage books, users, transactions, and library operations efficiently.
                                </p>
                                <a href="adminLogin.jsp" class="btn btn-warning rounded-pill px-4">
                                    <i class="fas fa-shield-alt me-2"></i>Admin Access
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Features Section -->
        <section class="features-section py-5">
            <div class="container">
                <div class="row text-center mb-5">
                    <div class="col-12">
                        <h2 class="fw-bold mb-3">Powerful Features</h2>
                        <p class="text-muted">Everything you need for modern library management</p>
                    </div>
                </div>
                
                <div class="row g-4">
                    <div class="col-lg-6">
                        <div class="feature-list">
                            <div class="feature-item d-flex align-items-center mb-3">
                                <div class="feature-icon me-3">
                                    <i class="fas fa-book text-primary"></i>
                                </div>
                                <div>
                                    <h6 class="mb-1 fw-semibold">Smart Book Management</h6>
                                    <p class="text-muted mb-0 small">Advanced cataloging and inventory system</p>
                                </div>
                            </div>
                            
                            <div class="feature-item d-flex align-items-center mb-3">
                                <div class="feature-icon me-3">
                                    <i class="fas fa-users text-success"></i>
                                </div>
                                <div>
                                    <h6 class="mb-1 fw-semibold">User Management</h6>
                                    <p class="text-muted mb-0 small">Complete user registration and profile system</p>
                                </div>
                            </div>
                            
                            <div class="feature-item d-flex align-items-center mb-3">
                                <div class="feature-icon me-3">
                                    <i class="fas fa-exchange-alt text-info"></i>
                                </div>
                                <div>
                                    <h6 class="mb-1 fw-semibold">Issue & Return System</h6>
                                    <p class="text-muted mb-0 small">Streamlined borrowing and return process</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-lg-6">
                        <div class="feature-list">
                            <div class="feature-item d-flex align-items-center mb-3">
                                <div class="feature-icon me-3">
                                    <i class="fas fa-history text-warning"></i>
                                </div>
                                <div>
                                    <h6 class="mb-1 fw-semibold">Transaction History</h6>
                                    <p class="text-muted mb-0 small">Detailed records of all library activities</p>
                                </div>
                            </div>
                            
                            <div class="feature-item d-flex align-items-center mb-3">
                                <div class="feature-icon me-3">
                                    <i class="fas fa-clock text-danger"></i>
                                </div>
                                <div>
                                    <h6 class="mb-1 fw-semibold">Overdue Tracking</h6>
                                    <p class="text-muted mb-0 small">Automated fine calculation and notifications</p>
                                </div>
                            </div>
                            
                            <div class="feature-item d-flex align-items-center mb-3">
                                <div class="feature-icon me-3">
                                    <i class="fas fa-search text-purple"></i>
                                </div>
                                <div>
                                    <h6 class="mb-1 fw-semibold">Advanced Search</h6>
                                    <p class="text-muted mb-0 small">Find books by title, author, ISBN, or category</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Stats Section -->
        <section class="stats-section py-5 bg-gradient-primary text-white">
            <div class="container">
                <div class="row text-center">
                    <div class="col-lg-3 col-md-6 mb-4">
                        <div class="stat-item">
                            <i class="fas fa-book fa-2x mb-2"></i>
                            <h3 class="fw-bold mb-1">10,000+</h3>
                            <p class="mb-0">Books Available</p>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6 mb-4">
                        <div class="stat-item">
                            <i class="fas fa-users fa-2x mb-2"></i>
                            <h3 class="fw-bold mb-1">2,500+</h3>
                            <p class="mb-0">Active Members</p>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6 mb-4">
                        <div class="stat-item">
                            <i class="fas fa-exchange-alt fa-2x mb-2"></i>
                            <h3 class="fw-bold mb-1">50,000+</h3>
                            <p class="mb-0">Books Issued</p>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6 mb-4">
                        <div class="stat-item">
                            <i class="fas fa-star fa-2x mb-2"></i>
                            <h3 class="fw-bold mb-1">4.9/5</h3>
                            <p class="mb-0">User Rating</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </main>
    <!-- Perfect Footer -->
    <footer class="footer-section bg-dark text-light">
        <!-- Main Footer -->
        <div class="footer-main py-5">
            <div class="container">
                <div class="row g-4">
                    <!-- Brand Section -->
                    <div class="col-lg-4 col-md-6">
                        <div class="footer-brand">
                            <h4 class="fw-bold mb-3">
                                <i class="fas fa-book-open me-2 text-warning"></i>
                                LibraryHub
                            </h4>
                            <p class="text-light-muted mb-4">
                                Your trusted digital library management system. We make book discovery and library operations simple, efficient, and enjoyable for everyone.
                            </p>
                            <div class="social-links">
                                <a href="#" class="social-link me-3"><i class="fab fa-facebook-f"></i></a>
                                <a href="#" class="social-link me-3"><i class="fab fa-twitter"></i></a>
                                <a href="#" class="social-link me-3"><i class="fab fa-instagram"></i></a>
                                <a href="#" class="social-link me-3"><i class="fab fa-linkedin-in"></i></a>
                                <a href="#" class="social-link"><i class="fab fa-youtube"></i></a>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Quick Links -->
                    <div class="col-lg-2 col-md-6">
                        <div class="footer-links">
                            <h6 class="fw-semibold mb-3 text-warning">Quick Links</h6>
                            <ul class="list-unstyled">
                                <li class="mb-2"><a href="index.jsp" class="footer-link">Home</a></li>
                                <li class="mb-2"><a href="login.jsp" class="footer-link">User Login</a></li>
                                <li class="mb-2"><a href="register.jsp" class="footer-link">Register</a></li>
                                <li class="mb-2"><a href="adminLogin.jsp" class="footer-link">Admin Portal</a></li>
                                <li class="mb-2"><a href="#" class="footer-link">About Us</a></li>
                            </ul>
                        </div>
                    </div>
                    
                    <!-- Services -->
                    <div class="col-lg-3 col-md-6">
                        <div class="footer-links">
                            <h6 class="fw-semibold mb-3 text-warning">Services</h6>
                            <ul class="list-unstyled">
                                <li class="mb-2"><a href="#" class="footer-link">Book Catalog</a></li>
                                <li class="mb-2"><a href="#" class="footer-link">Digital Library</a></li>
                                <li class="mb-2"><a href="#" class="footer-link">Research Resources</a></li>
                                <li class="mb-2"><a href="#" class="footer-link">Study Rooms</a></li>
                                <li class="mb-2"><a href="#" class="footer-link">Help Center</a></li>
                            </ul>
                        </div>
                    </div>
                    
                    <!-- Contact Info -->
                    <div class="col-lg-3 col-md-6">
                        <div class="footer-contact">
                            <h6 class="fw-semibold mb-3 text-warning">Contact Info</h6>
                            <div class="contact-item d-flex align-items-start mb-3">
                                <i class="fas fa-map-marker-alt text-warning me-3 mt-1"></i>
                                <div>
                                    <p class="mb-0 text-light-muted">123 Library Street<br>Keshavnagar,Pune</p>
                                </div>
                            </div>
                            <div class="contact-item d-flex align-items-center mb-3">
                                <i class="fas fa-phone text-warning me-3"></i>
                                <p class="mb-0 text-light-muted">9322771348</p>
                            </div>
                            <div class="contact-item d-flex align-items-center mb-3">
                                <i class="fas fa-envelope text-warning me-3"></i>
                                <p class="mb-0 text-light-muted">teamlibrary847@example.com</p>
                            </div>
                            <div class="contact-item d-flex align-items-center">
                                <i class="fas fa-clock text-warning me-3"></i>
                                <p class="mb-0 text-light-muted">Mon - Fri: 8:00 AM - 8:00 PM</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Footer Bottom -->
        <div class="footer-bottom bg-darker py-3">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <p class="mb-0 text-light-muted">
                            © 2025 LibraryHub. All rights reserved.
                        </p>
                    </div>
                    <div class="col-md-6">
                        <div class="footer-bottom-links text-end">
                            <a href="#" class="footer-link me-3">Privacy Policy</a>
                            <a href="#" class="footer-link me-3">Terms of Service</a>
                            <a href="#" class="footer-link">Cookie Policy</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </footer>

    <!-- Back to Top Button -->
    <button class="back-to-top" id="backToTop" title="Back to Top">
        <i class="fas fa-chevron-up"></i>
    </button>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Custom JavaScript -->
    <script>
        // Back to top functionality
        window.addEventListener('scroll', function() {
            const backToTop = document.getElementById('backToTop');
            if (window.pageYOffset > 300) {
                backToTop.style.display = 'block';
            } else {
                backToTop.style.display = 'none';
            }
        });

        document.getElementById('backToTop').addEventListener('click', function() {
            window.scrollTo({
                top: 0,
                behavior: 'smooth'
            });
        });

        // Smooth scrolling for anchor links
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({
                        behavior: 'smooth'
                    });
                }
            });
        });

        // Card hover effects
        document.querySelectorAll('.service-card').forEach(card => {
            card.addEventListener('mouseenter', function() {
                this.style.transform = 'translateY(-10px)';
            });
            
            card.addEventListener('mouseleave', function() {
                this.style.transform = 'translateY(0)';
            });
        });
    </script>
</body>
</html>
    