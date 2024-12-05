package com.revshop;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class OrderHistoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("id") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("id");

        // Database connection details
        String DB_URL = "jdbc:mysql://localhost:3306/revshop";
        String DB_USER = "root";
        String DB_PASSWORD = "12345678";
        String query = "SELECT s.id, s.full_name, s.address, s.city, s.state, s.zip_code, s.country, s.prod_id, p.name AS prod_name, p.price AS prod_price, c.quantity, s.created_at " +
                       "FROM shipping_info s " +
                       "JOIN products p ON s.prod_id = p.id " +
                       "JOIN cart c ON c.product_id = s.prod_id " +
                       "WHERE s.user_id = ?";

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            // Store result set in request attribute
            request.setAttribute("orderHistory", rs);

            // Forward request to JSP page
            request.getRequestDispatcher("orderHistory.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp"); // Redirect to an error page
        }
    }
}
