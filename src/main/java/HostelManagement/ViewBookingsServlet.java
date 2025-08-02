package HostelManagement;

import HostelManagement.Booking;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/viewBookings")
public class ViewBookingsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Booking> bookings = new ArrayList<>();

        try {
            Class.forName("com.mysql.jdbc.Driver"); // or com.mysql.cj.jdbc.Driver if using newer MySQL
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hostel_db", "root", "root");
            String sql = "SELECT b.id, b.student_id, r.room_number, b.checkin_date, b.fee_status " +
                    "FROM bookings b JOIN rooms r ON b.room_id = r.id";

            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Booking b = new Booking();
                b.setId(rs.getInt("id"));
                b.setStudentId(rs.getInt("student_id"));
                b.setRoomNumber(rs.getString("room_number")); // New field
                b.setCheckinDate(rs.getString("checkin_date"));
                b.setFeeStatus(rs.getString("fee_status"));

                bookings.add(b);
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("bookings", bookings);
        request.getRequestDispatcher("adminBookings.jsp").forward(request, response);
    }
}
