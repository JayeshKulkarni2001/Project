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

//@WebServlet("/PaymentServlet")
public class PaymentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve shipping information from the form
    	 HttpSession session = request.getSession(false);
    	 if (session == null) {
             response.sendRedirect("login.jsp");
             return;
         }

         Integer userid = (Integer) session.getAttribute("id");
         if (userid == null) {
             response.sendRedirect("login.jsp");
             return;
         }
         
        String fullName = request.getParameter("fullName");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String zipCode = request.getParameter("zipCode");
        String country = request.getParameter("country");

        // Database connection details
        String DB_URL = "jdbc:mysql://localhost:3306/revshop";
        String DB_USER = "root";
        String DB_PASSWORD = "12345678";

        
        // SQL query to get product details from cart
        String getCartSql = "SELECT p.id, p.name, p.price, c.quantity FROM Cart c JOIN Products p ON c.product_id = p.id WHERE c.user_id = ?";

        // SQL query to insert shipping information
        String insertShippingSql = "INSERT INTO shipping_info (full_name, address, city, state, zip_code, country, user_id, prod_id, prod_name, prod_price, quantity) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement getCartStmt = conn.prepareStatement(getCartSql);
             PreparedStatement insertShippingStmt = conn.prepareStatement(insertShippingSql)) {

            // Retrieve product details from cart
            getCartStmt.setInt(1, userid);
            ResultSet rs = getCartStmt.executeQuery();

            // Process each product and insert into shipping_info table
            while (rs.next()) {
                int prodId = rs.getInt("id");
                String prodName = rs.getString("name");
                double prodPrice = rs.getDouble("price");
                int quantity = rs.getInt("quantity");

                insertShippingStmt.setString(1, fullName);
                insertShippingStmt.setString(2, address);
                insertShippingStmt.setString(3, city);
                insertShippingStmt.setString(4, state);
                insertShippingStmt.setString(5, zipCode);
                insertShippingStmt.setString(6, country);
                insertShippingStmt.setInt(7, userid);
                insertShippingStmt.setInt(8, prodId);
                insertShippingStmt.setString(9, prodName);
                insertShippingStmt.setDouble(10, prodPrice);
                insertShippingStmt.setInt(11, quantity);

                insertShippingStmt.executeUpdate();
            }
            // Redirect to a confirmation page (you can create a confirmation.jsp page)
            response.sendRedirect("payment.jsp?orderSuccess=true");
            
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle SQL error and redirect to an error page
            response.sendRedirect("./BuyerDashboardServlet");
        }
    }
}
