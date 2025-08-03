package HostelManagement;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/viewVisitorLogs")
public class ViewVisitorLogsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        List<VisitorLog> logs = new ArrayList<>();

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // Replace with your DB URL, username, password
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hostel_db", "root", "root");

            String sql = "SELECT * FROM visitor_log ORDER BY created_at DESC";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();

            while (rs.next()) {
                VisitorLog log = new VisitorLog();
                log.setStudentId(rs.getString("student_id"));
                log.setVisitorName(rs.getString("visitor_name"));
                log.setRelation(rs.getString("relation"));
                log.setVisitTime(rs.getString("visit_time"));
                log.setVisitDate(rs.getString("visit_date"));
                log.setPurpose(rs.getString("purpose"));
                log.setCreatedAt(rs.getTimestamp("created_at"));

                logs.add(log);
            }

            request.setAttribute("visitorLogs", logs);
            request.getRequestDispatcher("adminVisitors.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (stmt != null) stmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }
}
