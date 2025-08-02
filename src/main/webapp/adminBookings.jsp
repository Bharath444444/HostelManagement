<%@ page import="java.util.*, HostelManagement.Booking" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    HttpSession userSession = request.getSession(false);
    if (userSession == null || !"admin".equals(userSession.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }
    String adminName = (String) userSession.getAttribute("adminName");
%>
<html>
<head>
    <title>Admin - View Bookings</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<nav class="navbar navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="#">GGU HOSTELS</a>
            <span class="navbar-text">Welcome, <%= adminName %>!</span>
            <a href="logout" class="btn btn-danger">Logout</a>
        </div>
    </nav>
    <div class="container mt-4">
        <h2>All Bookings</h2>
        <table class="table table-bordered table-striped mt-3">
            <thead class="thead-dark">
                <tr>
                    <th>ID</th>
                    <th>Student ID</th>
                    <th>Room No</th>
                    <th>Check-in Date</th>
                    <th>Fee Status</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
            <%
                List<Booking> bookings = (List<Booking>) request.getAttribute("bookings");
                for (Booking b : bookings) {
            %>
                <tr>
                    <td><%= b.getId() %></td>
                    <td><%= b.getStudentId() %></td>
                    <td><%= b.getRoomNumber() %></td>
                    <td><%= b.getCheckinDate() %></td>
                    <td><%= b.getFeeStatus() %></td>
                    <td>
                        <form action="deleteBooking" method="post" onsubmit="return confirm('Are you sure to delete?');">
                            <input type="hidden" name="id" value="<%= b.getId() %>">
                            <button class="btn btn-sm btn-danger">Delete</button>
                        </form>
                    </td>
                </tr>
            <% } %>
            </tbody>
        </table>
    </div>
</body>
</html>
