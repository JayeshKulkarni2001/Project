package com.revshop;

import jakarta.servlet.ServletException;
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

//@WebServlet("/productDetailsServlet")
public class ProductDetailsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        List<Product> productList = new ArrayList<>();
        Connection connection = null;

        String query = request.getParameter("query");
        String sql;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/revshop", "root", "12345678");

            if (query != null && !query.trim().isEmpty()) {
                sql = "SELECT * FROM products WHERE name LIKE ? OR description LIKE ? OR category LIKE ?";
                PreparedStatement statement = connection.prepareStatement(sql);
                String searchPattern = "%" + query + "%";
                statement.setString(1, searchPattern);
                statement.setString(2, searchPattern);
                statement.setString(3, searchPattern);
                ResultSet resultSet = statement.executeQuery();

                while (resultSet.next()) {
                    Product product = new Product();
                    product.setId(resultSet.getInt("id"));
                    product.setName(resultSet.getString("name"));
                    product.setDescription(resultSet.getString("description"));
                    product.setPrice(resultSet.getBigDecimal("price"));
                    product.setQuantity(resultSet.getInt("quantity"));
                    product.setCategory(resultSet.getString("category"));
                    product.setImageUrl(resultSet.getBytes("image_url"));

                    productList.add(product);
                }

                resultSet.close();
                statement.close();
            } else {
                // If no query is provided, retrieve all products
                sql = "SELECT * FROM products";
                PreparedStatement statement = connection.prepareStatement(sql);
                ResultSet resultSet = statement.executeQuery();

                while (resultSet.next()) {
                    Product product = new Product();
                    product.setId(resultSet.getInt("id"));
                    product.setName(resultSet.getString("name"));
                    product.setDescription(resultSet.getString("description"));
                    product.setPrice(resultSet.getBigDecimal("price"));
                    product.setQuantity(resultSet.getInt("quantity"));
                    product.setCategory(resultSet.getString("category"));
                    product.setImageUrl(resultSet.getBytes("image_url"));

                    productList.add(product);
                }

                resultSet.close();
                statement.close();
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }

        request.setAttribute("productList", productList);
        request.getRequestDispatcher("home.jsp").forward(request, response);
    }
}
