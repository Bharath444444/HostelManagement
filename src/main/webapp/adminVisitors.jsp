<%@ page import="java.util.*, HostelManagement.VisitorLog" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <title>Admin - Visitor Logs</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<nav class="navbar navbar-dark bg-dark">
    <div class="container-fluid d-flex justify-content-between">
        <a class="navbar-brand" href="#">GGU HOSTELS</a>
        <span class="navbar-text text-white">Welcome, <%= adminName %>!</span>
        <a href="logout" class="btn btn-danger">Logout</a>
    </div>
</nav>

<div class="container mt-4">
    <h2 class="text-center mb-4">Visitor Logs</h2>

    <div class="table-responsive">
        <table class="table table-bordered table-hover text-center">
            <thead class="thead-dark">
                <tr>
                    <th>Visitor Name</th>
                    <th>Student ID</th>
                    <th>Relation</th>
                    <th>Purpose</th>
                    <th>Visit Date</th>
                    <th>Visit Time</th>
                    <th>Created At</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
            <%
                List<VisitorLog> logs = (List<VisitorLog>) request.getAttribute("visitorLogs");
                if (logs != null && !logs.isEmpty()) {
                    for (VisitorLog log : logs) {
            %>
                <tr>
                    <td><%= log.getVisitorName() %></td>
                    <td><%= log.getStudentId() %></td>
                    <td><%= log.getRelation() %></td>
                    <td><%= log.getPurpose() %></td>
                    <td><%= log.getVisitDate() %></td>
                    <td><%= log.getVisitTime() %></td>
                    <td><%= log.getCreatedAt() %></td>
                    <td>
                        <form action="deleteVisitor" method="post">
                            <input type="hidden" name="studentId" value="<%= log.getStudentId() %>">
                            <input type="hidden" name="visitTime" value="<%= log.getVisitTime() %>">
                            <input type="hidden" name="visitDate" value="<%= log.getVisitDate() %>">
                            <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                        </form>
                    </td>
                </tr>
            <%
                    }
                } else {
            %>
                <tr>
                    <td colspan="8">No visitor logs available.</td>
                </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
