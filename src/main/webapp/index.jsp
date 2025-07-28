<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hostel Management System</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
     
</head>
<body class="bg-light">

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="index.jsp">GGU HOSTELS</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="register.jsp">Register</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="login.jsp">Login</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
<!-- Hero Section with Logo -->
<header class="text-center d-flex align-items-center justify-content-center" style="
    background-color: #f8f9fa;
    height: 100vh;
">
    <div class="container">
        <!-- GGU Logo -->
        <img src="https://ggu.edu.in/wp-content/uploads/2025/03/ggu-new-logo.png" alt="GGU Logo" class="mb-4" style="max-width: 150px;">
        
        <!-- Title and Description -->
        <h1 class="display-5 fw-bold text-dark">Welcome to Hostel Management System</h1>
        <p class="lead text-dark">A simple and efficient way to manage student hostel bookings and payments.</p>
        
        <!-- Action Buttons -->
        <a href="register.jsp" class="btn btn-outline-dark me-3">New Student Registration</a>
        <a href="login.jsp" class="btn btn-dark">Login (Student/Admin)</a>
    </div>
</header>

    
    <!-- Bootstrap JS -->
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>
