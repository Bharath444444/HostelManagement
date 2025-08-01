package HostelManagement;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/editRoom")
public class EditRoomServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String idStr = request.getParameter("id");
        String rentStr = request.getParameter("rent");

        try {
            int id = Integer.parseInt(idStr);
            double rent = Double.parseDouble(rentStr);

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hostel_db", "root", "root");

            String query = "UPDATE rooms SET rent = ? WHERE id = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setDouble(1, rent);
            ps.setInt(2, id);

            ps.executeUpdate();
            response.sendRedirect("viewRooms");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().print("Error updating rent.");
        }
    }
}
