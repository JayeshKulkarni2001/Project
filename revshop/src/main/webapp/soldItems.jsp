<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, jakarta.servlet.http.*, jakarta.servlet.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order History</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="theme.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            margin-top: 50px;
        }
        .table {
            background-color: #fff;
            border: 1px solid #dee2e6;
        }
        .table thead th {
            background-color: #343a40;
            color: #fff;
        }
        .table tbody tr:nth-child(odd) {
            background-color: #f2f2f2;
        }
        .content {
    max-width: 1200px;
    margin: 20px auto;
    background-color: #fff;
    padding: 20px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    border-radius: 8px;
}
.header-title {
    color: white;
}
    </style>
</head>
<header>
    <div class="header-title">&copy;RevShop</div>
    <a href="SellerDashboardServlet"
        class="btn btn-outline-light ml-2 logout-link"
        style="align-items: right;">Back to Dashboard</a>
</header>
<body style="background-color: black;">
    <div class="content">
        <h2 class="text-center mb-4" style="color: black;">Sold Items</h2>

        <table class="table table-striped table-bordered">
            <thead>
                <tr>
             
                    <th>Product Name</th>
                    <th>Description</th>
                    <th>Product Price</th>
                    <th>Quantity</th>
                    <th>Category</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    // Retrieve order history from request attribute
                    ResultSet rs = (ResultSet) request.getAttribute("soldHistory");
                    
                    if (rs != null) {
                        while (rs.next()) {
                            String prodName = rs.getString("name");
                            String prodDescription = rs.getString("description");
                            double prodPrice = rs.getDouble("prod_price");
                            int quantity = rs.getInt("quantity");
                            String category = rs.getString("category");
                            
                            %>
                            <tr>
                                <td><%= prodName %></td>
                                <td><%= prodDescription %>
                                <td><%= prodPrice %></td>
                                <td><%= quantity %></td>
                                <td><%= category %></td>
                            </tr>
                            <% 
                        }
                    } else {
                        %>
                        <tr>
                            <td colspan="12" class="text-center">No products sold.</td>
                        </tr>
                        <% 
                    }
                %>
            </tbody>
        </table>

    </div>

    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
