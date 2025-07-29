<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="javax.naming.*, javax.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
    HttpSession userSession = request.getSession(false);
    if (userSession == null || userSession.getAttribute("studentId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    int studentId = (int) userSession.getAttribute("studentId");

    // Connect and fetch available rooms
    List<Map<String, String>> rooms = new ArrayList<>();
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hostel_db", "root", "root");
        PreparedStatement ps = conn.prepareStatement("SELECT * FROM rooms WHERE status = 'Available'");
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Map<String, String> room = new HashMap<>();
            room.put("id", rs.getString("id"));
            room.put("room_number", rs.getString("room_number"));
            room.put("room_type", rs.getString("room_type"));
            rooms.add(room);
        }
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Room Booking</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="dashboard.jsp">Hostel Management</a>
            <a href="logout" class="btn btn-danger">Logout</a>
        </div>
    </nav>

    <div class="container mt-5">
        <h3 class="mb-4">Available Rooms</h3>
        <div class="row">
            <% if (rooms.size() == 0) { %>
                <p>No rooms available at the moment.</p>
            <% } %>
            <% for (Map<String, String> room : rooms) { %>
                <div class="col-md-4 mb-4">
                    <div class="card shadow-sm">
                        <div class="card-body">
                            <h5 class="card-title">Room <%= room.get("room_number") %></h5>
                            <p class="card-text">Type: <strong><%= room.get("room_type") %></strong></p>
                            <form method="post" action="RoomBookingServlet">
                                <input type="hidden" name="roomId" value="<%= room.get("id") %>">
                                <label>Check-in Date:</label>
                                <input type="date" name="checkin" class="form-control mb-2" required>
                                <button type="submit" class="btn btn-primary w-100">Book Now</button>
                            </form>
                        </div>
                    </div>
                </div>
            <% } %>
        </div>
    </div>
</body>
</html>
