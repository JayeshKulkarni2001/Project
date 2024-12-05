<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>RevShop - Wishlist</title>
<link rel="stylesheet" href="theme.css">
<link rel="stylesheet"
    href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style>
header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 10px;
    background-color: #000000;
}

.header-title {
    color: white;
}

.logout-link {
    color: white;
}

.content {
    max-width: 1200px;
    margin: 20px auto;
    background-color: #fff;
    padding: 20px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    border-radius: 8px;
}
</style>
</head>
<body style="background-color: black;">
    <div class="content">
        <h2>My Wishlist</h2>
        <table class="table">
            <thead>
                <tr>
                    <th>Product ID</th>
                    <th>Product Name</th>
                    <th>Price</th>
                    <th>Date Added</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    int userId = (int) session.getAttribute("id");
                    if (userId != 0) {
                        String DB_URL = "jdbc:mysql://localhost:3306/revshop";
                        String DB_USER = "root";
                        String DB_PASSWORD = "12345678";
                        
                        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                            String sql = "SELECT w.product_id, p.name, p.price, w.date_added " +
                                         "FROM wishlist w JOIN products p ON w.product_id = p.id " +
                                         "WHERE w.user_id = ?";
                            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                                stmt.setInt(1, userId);
                                ResultSet rs = stmt.executeQuery();
                                while (rs.next()) {
                                    int productId = rs.getInt("product_id");
                                    String productName = rs.getString("name");
                                    double price = rs.getDouble("price");
                                    Timestamp dateAdded = rs.getTimestamp("date_added");
                %>
                <tr>
                    <td><%= productId %></td>
                    <td><%= productName %></td>
                    <td>₹<%= price %></td>
                    <td><%= dateAdded %></td>
                    <td>
                        <form action="DeleteFromWishlistServlet" method="post">
                            <input type="hidden" name="productId" value="<%= productId %>">
                            <button type="submit" class="btn btn-danger">Remove</button>
                        </form>
                    </td>
                </tr>
                <%
                                }
                            }
                        } catch (SQLException e) {
                            e.printStackTrace();
                            out.println("Error fetching wishlist items.");
                        }
                    } else {
                %>
                <tr>
                    <td colspan="5">You must be logged in to view your wishlist.</td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
