<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<%
    HttpSession userSession = request.getSession(false);
    if (userSession == null || !"admin".equals(userSession.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }
    String adminName = (String) userSession.getAttribute("adminName");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            background: #f7f9fc;
        }
        .dashboard-card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s, box-shadow 0.3s;
            background-color: #fff;
        }
        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 16px rgba(0,0,0,0.2);
        }
        .card-icon {
            font-size: 40px;
            color: #0d6efd;
            margin-bottom: 10px;
        }
        .navbar-brand {
            font-size: 24px;
            font-weight: bold;
        }
    </style>
</head>
<body>

    <nav class="navbar navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="#">GGU HOSTELS</a>
            <span class="navbar-text">Welcome, <%= adminName %>!</span>
            <a href="logout" class="btn btn-danger">Logout</a>
        </div>
    </nav>

    <!-- Dashboard Cards -->
    <div class="container mt-5">
        <div class="row text-center g-4">

            <!-- Manage Rooms -->
            <div class="col-md-4">
                <div class="card dashboard-card p-4">
                    <i class="bi bi-house-fill card-icon"></i>
                    <h5 class="card-title">Manage Rooms</h5>
                    
                    <p class="card-text">Add, edit or remove rooms from hostel.</p>
                    <a href="viewRooms" class="btn btn-primary">Manage</a>
                </div>
            </div>

            <!-- View Bookings -->
            <div class="col-md-4">
                <div class="card dashboard-card p-4">
                    <i class="bi bi-journal-check card-icon"></i>
                    <h5 class="card-title">View Bookings</h5>
                    <p class="card-text">Monitor and update student bookings.</p>
                    <a href="viewBookings" class="btn btn-success">View</a>
                </div>
            </div>

            <!-- Visitor Logs -->
            <div class="col-md-4">
                <div class="card dashboard-card p-4">
                    <i class="bi bi-people-fill card-icon"></i>
                    <h5 class="card-title">Visitor Logs</h5>
                    <p class="card-text">Track and manage all visitor entries.</p>
                    <a href="viewVisitors" class="btn btn-danger">Access</a>
                </div>
            </div>

        </div>
    </div>


</body>
</html>