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
/**
 * Servlet implementation class SoldItemsServlet
 */
public class SoldItemsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("id") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String username = (String) session.getAttribute("user");

        // Database connection details
        String DB_URL = "jdbc:mysql://localhost:3306/revshop";
        String DB_USER = "root";
        String DB_PASSWORD = "12345678";
        String query = "SELECT p.id, p.name, p.description, s.prod_price, s.quantity, p.category " +
                       "FROM products p " +
                       "JOIN shipping_info s ON p.id = s.prod_id " +
                       "WHERE p.addby = ? ;";
                      

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();

            // Store result set in request attribute
            request.setAttribute("soldHistory", rs);

            // Forward request to JSP page
            request.getRequestDispatcher("soldItems.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp"); // Redirect to an error page
        }
	}


}
