package com.revshop;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


//@WebServlet("/sellerDashboard")
public class SellerDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp"); // Redirect to login if session or user is null
            return;
        }
        
        String username = (String) request.getSession().getAttribute("user");
        System.out.println("username: "+username);
        List<Product> sellerProducts = new ArrayList<>();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            // Load JDBC driver (optional for newer versions)
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish a connection
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/revshop", "root", "12345678");

            // Prepare SQL query
            String sql = "SELECT * FROM products WHERE addby = ?";
            statement = connection.prepareStatement(sql);
            statement.setString(1, username);

            // Execute query
            resultSet = statement.executeQuery();

            // Process results
            while (resultSet.next()) {
                Product product = new Product();
                product.setId(resultSet.getInt("id"));
                product.setName(resultSet.getString("name"));
                product.setDescription(resultSet.getString("description"));
                product.setPrice(resultSet.getBigDecimal("price"));
                product.setQuantity(resultSet.getInt("quantity"));
                product.setCategory(resultSet.getString("category"));
                product.setImageUrl(resultSet.getBytes("image_url")); // Assuming image_url is a BLOB or BYTE[]

                sellerProducts.add(product);
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace(); // Log the exception
            // Handle exceptions
            throw new ServletException("Database access error occurred", e);
        } finally {
            // Close resources
            try {
                if (resultSet != null) resultSet.close();
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        // Set data as request attribute
        request.setAttribute("sellerProducts", sellerProducts);
        session.setAttribute("sellerProducts", sellerProducts);
        // Forward to JSP
        request.getRequestDispatcher("sellerDashboard.jsp").forward(request, response);
    }

}
