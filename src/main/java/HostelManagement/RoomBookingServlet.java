package HostelManagement;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/roomBooking")
public class RoomBookingServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("studentId") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        int studentId = (int) session.getAttribute("studentId");
        String roomNumber = req.getParameter("roomNumber");

        try {
            PrintWriter pw = resp.getWriter();
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hostel_db", "root", "root");

            // Check if the room is available
            String checkQuery = "SELECT status FROM rooms WHERE room_number=?";
            PreparedStatement checkStmt = conn.prepareStatement(checkQuery);
            checkStmt.setString(1, roomNumber);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next() && rs.getString("status").equals("Available")) {
                // Update room status
                String updateQuery = "UPDATE rooms SET status='Occupied' WHERE room_number=?";
                PreparedStatement updateStmt = conn.prepareStatement(updateQuery);
                updateStmt.setString(1, roomNumber);
                int updated = updateStmt.executeUpdate();

                if (updated > 0) {
                    pw.println("<script>alert('Room booked successfully!'); window.location='dashboard.jsp';</script>");
                } else {
                    pw.println("<script>alert('Room booking failed. Try again!'); window.location='roomBooking.jsp';</script>");
                }
                updateStmt.close();
            } else {
                pw.println("<script>alert('Selected room is not available!'); window.location='roomBooking.jsp';</script>");
            }

            rs.close();
            checkStmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
