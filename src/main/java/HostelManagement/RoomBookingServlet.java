package HostelManagement;
import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/roomBooking")
public class RoomBookingServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("studentId") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        int studentId = (int) session.getAttribute("studentId");
        String roomId = req.getParameter("roomId");
        String checkin = req.getParameter("checkin");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hostel_db", "root", "root");

            // Insert booking
            PreparedStatement insert = conn.prepareStatement("INSERT INTO bookings (student_id, room_id, checkin_date) VALUES (?, ?, ?)");
            insert.setInt(1, studentId);
            insert.setInt(2, Integer.parseInt(roomId));
            insert.setDate(3, Date.valueOf(checkin));
            insert.executeUpdate();

            // Update room status to Booked
            PreparedStatement update = conn.prepareStatement("UPDATE rooms SET status = 'Booked' WHERE id = ?");
            update.setInt(1, Integer.parseInt(roomId));
            update.executeUpdate();

            conn.close();
            resp.sendRedirect("dashboard.jsp?msg=success");

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("error.jsp");
        }
    }
}
