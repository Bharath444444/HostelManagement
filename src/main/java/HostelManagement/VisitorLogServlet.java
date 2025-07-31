package HostelManagement;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/visitorLog")
public class VisitorLogServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("studentId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int studentId = (int) session.getAttribute("studentId");
        String visitorName = request.getParameter("visitorName");
        String relation = request.getParameter("relation");
        String visitDate = request.getParameter("visitDate");
        String visitTime = request.getParameter("visitTime");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hostel_db", "root", "root");

            String sql = "INSERT INTO visitor_log (student_id, visitor_name, relation, visit_date, visit_time) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, studentId);
            ps.setString(2, visitorName);
            ps.setString(3, relation);
            ps.setDate(4, Date.valueOf(visitDate));
            ps.setTime(5, Time.valueOf(visitTime + ":00")); // appending seconds if missing

            int rowsInserted = ps.executeUpdate();
            conn.close();

            if (rowsInserted > 0) {
                request.setAttribute("message", "Visitor log added successfully.");
            } else {
                request.setAttribute("message", "Failed to add visitor log.");
            }

            RequestDispatcher rd = request.getRequestDispatcher("visitorLog.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "An error occurred while adding visitor log.");
            RequestDispatcher rd = request.getRequestDispatcher("visitorLog.jsp");
            rd.forward(request, response);
        }
    }
}
