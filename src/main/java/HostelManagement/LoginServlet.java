package HostelManagement;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String role = req.getParameter("role");

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            resp.setContentType("text/html");
            PrintWriter pw = resp.getWriter();

            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hostel_db", "root", "root");

            if ("student".equals(role)) {
                stmt = conn.prepareStatement("SELECT * FROM students WHERE email=? AND password=?");
                stmt.setString(1, email);
                stmt.setString(2, password);
                rs = stmt.executeQuery();

                if (rs.next()) {
                    HttpSession session = req.getSession();
                    session.setAttribute("studentId", rs.getInt("id"));
                    session.setAttribute("studentName", rs.getString("name"));
                    session.setMaxInactiveInterval(30 * 60);
                    session.setAttribute("role", "student");
                    resp.sendRedirect("dashboard.jsp");
                } else {
                    resp.sendRedirect("login.jsp?error=invalid");
                }

            } else if ("admin".equals(role)) {
                stmt = conn.prepareStatement("SELECT * FROM admins WHERE email=? AND password=?");
                stmt.setString(1, email);
                stmt.setString(2, password);
                rs = stmt.executeQuery();

                if (rs.next()) {
                    HttpSession session = req.getSession();
                    session.setAttribute("adminEmail", rs.getString("email"));
                    session.setAttribute("adminName", rs.getString("name")); // optional if name column exists
                    session.setMaxInactiveInterval(30 * 60);
                    session.setAttribute("role", "admin");
                    resp.sendRedirect("adminDashboard.jsp");
                } else {
                    resp.sendRedirect("login.jsp?error=invalid");
                }
            } else {
                resp.sendRedirect("login.jsp?error=invalid");
            }

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("login.jsp?error=invalid");
        } finally {
            // Clean up
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (stmt != null) stmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }
}
