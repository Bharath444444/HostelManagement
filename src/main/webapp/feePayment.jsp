<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    HttpSession userSession = request.getSession(false);
    if (userSession == null || userSession.getAttribute("studentName") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String studentName = (String) userSession.getAttribute("studentName");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Fee Payment</title>
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
    <%
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        int studentId = (int) session.getAttribute("studentId");
        boolean hasBooking = false;
        String roomType = "";
        double rent = 0.0;
        String feeStatus = "";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hostel_db", "root", "root");

            // Check booking
            ps = conn.prepareStatement("SELECT b.room_id, r.room_type, r.rent, b.fee_status FROM bookings b JOIN rooms r ON b.room_id = r.id WHERE b.student_id = ?");
            ps.setInt(1, studentId);
            rs = ps.executeQuery();

            if (rs.next()) {
                hasBooking = true;
                roomType = rs.getString("room_type");
                rent = rs.getDouble("rent");
                feeStatus = rs.getString("fee_status");
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    %>

    <% if (hasBooking) { %>
        <div class="card shadow-lg">
            <div class="card-header bg-dark text-white">
                <h4>Fee Payment Details</h4>
            </div>
            <div class="card-body">
                <p><strong>Room Type:</strong> <%= roomType %></p>
                <p><strong>Room Rent:</strong> Rs:<%= rent %></p>
                <p><strong>Payment Status:</strong> 
                    <% if ("Paid".equalsIgnoreCase(feeStatus)) { %>
                        <span class="badge bg-success">Paid</span>
                    <% } else { %>
                        <span class="badge bg-warning text-dark">Unpaid</span>
                    <% } %>
                </p>

                <% if (!"Paid".equalsIgnoreCase(feeStatus)) { %>
                    <form action="payFee" method="post">
                        <button type="submit" class="btn btn-primary mt-3">Pay Now</button>
                    </form>
                <% } %>
            </div>
        </div>
    <% } else { %>
        <div class="alert alert-danger text-center">
            <strong>No room booking found.</strong><br>
            Please <a href="roomBooking.jsp" class="alert-link">book a room</a> to proceed with fee payment.
        </div>
    <% } %>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
