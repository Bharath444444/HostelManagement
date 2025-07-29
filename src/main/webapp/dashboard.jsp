<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
    HttpSession userSession = request.getSession(false);
    if (userSession == null || userSession.getAttribute("studentName") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String studentName = (String) userSession.getAttribute("studentName");
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard | Hostel Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
</head>
<body>
    <nav class="navbar navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="#">Hostel Management</a>
            <span class="navbar-text">Welcome, <%= studentName %>!</span>
            <a href="logout" class="btn btn-danger">Logout</a>
        </div>
    </nav>
<% 
    String msg = request.getParameter("msg");
    if ("success".equals(msg)) {
%>
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        ✅ Room booked successfully!
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
<% 
    }
%>
    <div class="container mt-5">
        <h2>Dashboard</h2>
        <p>Welcome <strong><%= studentName %></strong>, select an option below:</p>
        <a href="roomBooking.jsp" class="btn btn-primary">Book a Room</a>
        <a href="feePayment.jsp" class="btn btn-success">Pay Fees</a>
        <a href="visitorLog.jsp" class="btn btn-info">Visitor Log</a>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>
