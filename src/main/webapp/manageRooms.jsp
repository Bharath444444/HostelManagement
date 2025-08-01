<%@ page import="java.util.*, HostelManagement.Room" %>
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
    <title>Manage Rooms</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
 <nav class="navbar navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="#">GGU HOSTELS</a>
            <span class="navbar-text">Welcome, <%= adminName %>!</span>
            <a href="logout" class="btn btn-danger">Logout</a>
        </div>
    </nav>
<div class="container mt-5">
    <h2 class="mb-4">Manage Rooms</h2>

    <!-- Add Room Form -->
    <form action="addRoom" method="post" class="mb-4">
        <div class="row g-3">
            <div class="col-md-3">
                <input type="text" name="roomNumber" class="form-control" placeholder="Room Number" required>
            </div>
            <div class="col-md-3">
                <input type="text" name="roomType" class="form-control" placeholder="Room Type" required>
            </div>
            <div class="col-md-3">
                <input type="number" name="rent" class="form-control" placeholder="Rent" required>
            </div>
            <div class="col-md-3">
                <select name="status" class="form-control" required>
                    <option value="Available">Available</option>
                    <option value="Booked">Booked</option>
                </select>
            </div>
        </div>
        <button type="submit" class="btn btn-primary mt-3">Add Room</button>
    </form>

    <!-- Rooms Table -->
    <table class="table table-bordered">
        <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Room Number</th>
                <th>Type</th>
                <th>Rent</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <%
                List<Room> roomList = (List<Room>) request.getAttribute("roomList");
                if (roomList != null && !roomList.isEmpty()) {
                    for (Room room : roomList) {
            %>
            <tr>
                <td><%= room.getId() %></td>
                <td><%= room.getRoomNumber() %></td>
                <td><%= room.getRoomType() %></td>
                <td><%= room.getRent() %></td>
                <td><%= room.getStatus() %></td>
                <td>
  <div class="d-flex gap-2">
    <form action="editRoom" method="post" class="d-flex">
      <input type="hidden" name="id" value="<%= room.getId() %>">
      <input type="text" name="rent" value="<%= room.getRent() %>" style="width:70px;" class="form-control form-control-sm me-1">
      <button type="submit" class="btn btn-sm btn-success">Update</button>
    </form>

    <form action="deleteRoom" method="post" onsubmit="return confirm('Are you sure?');">
      <input type="hidden" name="id" value="<%= room.getId() %>">
      <button type="submit" class="btn btn-sm btn-danger">Delete</button>
    </form>
  </div>
</td>
                
            </tr>
            <%
                    }
                } else {
            %>
            <tr>
                <td colspan="6" class="text-center">No rooms available.</td>
            </tr>
            <% } %>
        </tbody>
    </table>
</div>

</body>
</html>
