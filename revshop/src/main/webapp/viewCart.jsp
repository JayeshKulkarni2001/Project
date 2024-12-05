<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>RevShop - Buyer Dashboard</title>
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
<!-- Add Bootstrap JS and dependencies -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script
    src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script
    src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<header>
    <div class="header-title">&copy;RevShop</div>
    <a href="buyerDashboard.jsp"
        class="btn btn-outline-light ml-2 logout-link"
        style="align-items: right;">Back to Products</a> 
        <a href="LogoutServlet"
        class="btn btn-outline-light ml-2 logout-link"
        style="align-items: right;">Logout</a>
</header>
</head>
<body style="background-color: black;">
    <div class="content">
        <h2>Your Cart</h2>
        <table class="table">
            <thead>
                <tr>
                    <th>Product ID</th>
                    <th>Product Name</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Total</th>
                    <th>Action</th>
                    <th>Checkout</th> <!-- New column for checkout -->
                </tr>
            </thead>
            <tbody>
                <%
                    int username = (int) session.getAttribute("id");
                    if (username != 0) {
                        // Database connection details
                        String DB_URL = "jdbc:mysql://localhost:3306/revshop";
                        String DB_USER = "root";
                        String DB_PASSWORD = "12345678";
                        
                        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                            String sql = "SELECT p.id, p.name, p.price, c.quantity " +
                                         "FROM Cart c JOIN Products p ON c.product_id = p.id " +
                                         "WHERE c.user_id = ?";
                            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                                stmt.setInt(1, username);
                                ResultSet rs = stmt.executeQuery();
                                while (rs.next()) {
                                    int productId = rs.getInt("id");
                                    String productName = rs.getString("name");
                                    double price = rs.getDouble("price");
                                    int quantity = rs.getInt("quantity");
                                    double total = price * quantity;
                %>
                <tr>
                    <td><%= productId %></td>
                    <td><%= productName %></td>
                    <td>₹<%= price %></td>
                    <td><%= quantity %></td>
                    <td>₹<%= total %></td>
                    <td>
                        <form action="DeleteFromCartServlet" method="post">
                            <input type="hidden" name="productId" value="<%= productId %>">
                            <button type="submit" class="btn btn-danger">Delete</button>
                        </form>
                    </td>
                    <td>
                        <!-- Button for checkout that redirects to payment.jsp -->
                        <form action="payment.jsp" method="post">
                            <input type="hidden" name="totalAmount" value="<%= total %>">
                            <button type="submit" class="btn btn-success">Checkout</button>
                        </form>
                    </td>
                </tr>
                <%
                                }
                            }
                        } catch (SQLException e) {
                            e.printStackTrace();
                            out.println("Error fetching cart items.");
                        }
                    } else {
                %>
                <tr>
                    <td colspan="7">You must be logged in to view your cart.</td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
