package HostelManagement; 

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/deleteBooking")
public class DeleteBookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // DB credentials
    private static final String DB_URL = "jdbc:mysql://localhost:3306/hostel_db"; 
    private static final String DB_USER = "root";
    private static final String DB_PASS = "root"; 

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int bookingId = Integer.parseInt(request.getParameter("id"));

        Connection conn = null;
        PreparedStatement getRoomStmt = null;
        PreparedStatement deleteStmt = null;
        PreparedStatement updateRoomStmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);

            // Step 1: Get room_id of the booking
            String getRoomSql = "SELECT room_id FROM bookings WHERE id = ?";
            getRoomStmt = conn.prepareStatement(getRoomSql);
            getRoomStmt.setInt(1, bookingId);
            ResultSet rs = getRoomStmt.executeQuery();

            int roomId = -1;
            if (rs.next()) {
                roomId = rs.getInt("room_id");
            }

            // Step 2: Delete the booking
            String deleteSql = "DELETE FROM bookings WHERE id = ?";
            deleteStmt = conn.prepareStatement(deleteSql);
            deleteStmt.setInt(1, bookingId);
            deleteStmt.executeUpdate();

            // Step 3: Update room status to 'available'
            if (roomId != -1) {
                String updateSql = "UPDATE rooms SET status = 'available' WHERE id = ?";
                updateRoomStmt = conn.prepareStatement(updateSql);
                updateRoomStmt.setInt(1, roomId);
                updateRoomStmt.executeUpdate();
            }

            // Redirect to viewBookings servlet/page
            response.sendRedirect("viewBookings");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error deleting booking.");
        } finally {
            try { if (getRoomStmt != null) getRoomStmt.close(); } catch (Exception e) {}
            try { if (deleteStmt != null) deleteStmt.close(); } catch (Exception e) {}
            try { if (updateRoomStmt != null) updateRoomStmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }
}
