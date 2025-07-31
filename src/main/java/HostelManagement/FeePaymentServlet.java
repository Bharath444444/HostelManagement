package HostelManagement;

import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/payFee")
public class FeePaymentServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("studentId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int studentId = (int) session.getAttribute("studentId");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hostel_db", "root", "root");

            PreparedStatement ps = conn.prepareStatement(
                "UPDATE bookings SET fee_status = 'Paid' WHERE student_id = ?"
            );
            ps.setInt(1, studentId);
            int rowsUpdated = ps.executeUpdate();

            if (rowsUpdated > 0) {
                session.setAttribute("feeMessage", "✅ Payment successful!");
            } else {
                session.setAttribute("feeMessage", "❌ Payment failed. No booking found.");
            }

            ps.close();
            conn.close();
            response.sendRedirect("feePayment.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("feeMessage", "⚠️ Error occurred during payment.");
            response.sendRedirect("feePayment.jsp");
        }
    }
}
