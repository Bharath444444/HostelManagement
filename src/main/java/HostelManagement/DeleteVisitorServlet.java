package HostelManagement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/deleteVisitor")
public class DeleteVisitorServlet extends HttpServlet {

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/hostel_db";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "root";  // replace with your password

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String studentId = request.getParameter("studentId");
        String visitDate = request.getParameter("visitDate");
        String visitTime = request.getParameter("visitTime");

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS);

            String sql = "DELETE FROM visitor_log WHERE student_id = ? AND visit_date = ? AND visit_time = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, studentId);
            stmt.setString(2, visitDate);
            stmt.setString(3, visitTime);

            stmt.executeUpdate();
            response.sendRedirect("adminVisitors.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error deleting visitor log.");
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
