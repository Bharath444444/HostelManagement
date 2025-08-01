<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
    
    if (session == null || session.getAttribute("studentName") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String studentName = (String) session.getAttribute("studentName");
    int studentId = (int) session.getAttribute("studentId"); 
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Visitor Log</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
     <nav class="navbar navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="#">GGU HOSTELS</a>
            <span class="navbar-text">Welcome, <%= studentName %>!</span>
            <a href="logout" class="btn btn-danger">Logout</a>
        </div>
    </nav>
    <div class="container mt-5">
        <h3 class="mb-4">Log a Visitor</h3>

        <% if ("success".equals(request.getParameter("status"))) { %>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                Visitor logged successfully.
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        <% } else if ("error".equals(request.getParameter("status"))) { %>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                Something went wrong. Try again.
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        <% } %>

        <form action="visitorLog" method="post" class="row g-3">
            <div class="col-md-6">
                <label for="visitorName" class="form-label">Visitor Name</label>
                <input type="text" class="form-control" id="visitorName" name="visitorName" required>
            </div>
            <div class="col-md-6">
                <label for="relation" class="form-label">Relation</label>
                <input type="text" class="form-control" id="relation" name="relation" required>
            </div>
            <div class="col-md-6">
                <label for="visitDate" class="form-label">Visit Date</label>
                <input type="date" class="form-control" id="visitDate" name="visitDate" required>
            </div>
            <div class="col-md-6">
                <label for="visitTime" class="form-label">Visit Time</label>
                <input type="time" class="form-control" id="visitTime" name="visitTime" required>
            </div>
            <div class="col-12">
                <label for="purpose" class="form-label">Purpose</label>
                <textarea class="form-control" id="purpose" name="purpose" rows="3" required></textarea>
            </div>
            <div class="col-12">
                <button type="submit" class="btn btn-primary">Log Visitor</button>
            </div>
        </form>

        <hr class="my-5">

        <h4>Your Visitor Logs</h4>
        <table class="table table-bordered table-striped mt-3">
            <thead class="table-dark">
                <tr>
                    <th>#</th>
                    <th>Visitor Name</th>
                    <th>Relation</th>
                    <th>Visit Date</th>
                    <th>Visit Time</th>
                    <th>Purpose</th>
                    <th>Logged At</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hostel_db", "root", "root");
                        PreparedStatement ps = conn.prepareStatement("SELECT * FROM visitor_log WHERE student_id = ? ORDER BY created_at DESC");
                        ps.setInt(1, studentId);
                        ResultSet rs = ps.executeQuery();
                        int count = 1;
                        while (rs.next()) {
                %>
                <tr>
                    <td><%= count++ %></td>
                    <td><%= rs.getString("visitor_name") %></td>
                    <td><%= rs.getString("relation") %></td>
                    <td><%= rs.getDate("visit_date") %></td>
                    <td><%= rs.getTime("visit_time") %></td>
                    <td><%= rs.getString("purpose") %></td>
                    <td><%= rs.getTimestamp("created_at") %></td>
                </tr>
                <%
                        }
                        conn.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                %>
            </tbody>
        </table>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
