package HostelManagement;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
@WebServlet("/feePayment")
public class FeePaymentServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("studentId") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        int studentId = Integer.parseInt(req.getParameter("studentId"));
        String amountStr = req.getParameter("amount");

        // Debugging: Print values in the console
        System.out.println("Student ID: " + studentId);
        System.out.println("Amount: " + amountStr);

        if (amountStr == null || amountStr.isEmpty()) {
            System.out.println("Amount is missing!");
            resp.sendRedirect("feePayment.jsp");
            return;
        }

        double amount = Double.parseDouble(amountStr);

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hostel_db", "root", "root");

            String sql = "INSERT INTO payments (student_id, amount, status) VALUES (?, ?, 'Paid')";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, studentId);
            stmt.setDouble(2, amount);

            int i = stmt.executeUpdate();

            if (i > 0) {
                System.out.println("Payment Successful!");
                resp.sendRedirect("dashboard.jsp");
            } else {
                System.out.println("Payment Failed!");
                resp.sendRedirect("feePayment.jsp");
            }

            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
