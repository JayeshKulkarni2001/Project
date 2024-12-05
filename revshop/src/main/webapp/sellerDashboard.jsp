<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="com.revshop.Product" %>
<%@ page session="true" %>
<%
    String username = (String) session.getAttribute("user");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RevShop - Seller Dashboard</title>
    <link rel="stylesheet" href="theme.css">
       <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style>
        header {
            display: flex;
            justify-content: space-between; /* Distribute space between items */
            align-items: center; /* Center items vertically */
            padding: 10px;
            background-color: #000000; /* Example background color */
        }
        .header-title {
            color: white; /* Example text color */
        }
        .logout-link {
            color: white; /* Example link color */
        }
    </style>
    <!-- Add Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    
    <header>
        <div class="header-title">&copy;RevShop</div>
        <a href="SoldItemsServlet" class="btn btn-outline-light ml-2 logout-link" style="align-items: right;">Sold Items</a>
        <a href="LogoutServlet" class="btn btn-outline-light ml-2 logout-link" style="align-items: right;">Logout</a>
    </header>
</head>
<body style="background-color: black;">
    

    <div class="dashboard">
        <h4 style="color: white;">Hello, <%= username %>!</h4>
        <p style="color: white;" align="center">Manage your products and view your sales here.</p>
        
        <section id="seller-products">
            <h2 style="color: white;" align="center">Your Products</h2>
            <a href="addProduct.jsp" class="btn btn-outline-light ml-2 logout-link">Add New Product</a>
            <!-- <a href="addProduct.jsp" style="color: white;" class="button">Add New Product</a> -->
            <div class="product-list">
                 <%
                    List<?> productsObj = (List<?>) session.getAttribute("sellerProducts");
                    if (productsObj != null && productsObj instanceof List<?>) {
                        @SuppressWarnings("unchecked")
                        List<Product> sellerProducts = (List<Product>) productsObj;
                        for (Product product : sellerProducts) {
                %>
                    <div class="product-item">
                         <form action="SellerDashboardServlet" method="get">
                            <img src="data:image/jpeg;base64,<%= product.getImageBase64() %>" alt="<%= product.getName() %>" style="max-width: 150px; max-height: 150px;">
                            <h3 style="color: black;"><%= product.getName() %></h3>
                            <p style="color: black;">₹<%= product.getPrice() %></p>
                        </form>
                        <form action="editProduct.jsp" method="post" style="display: inline;">
                            <input type="hidden" name="id" value="<%= product.getId() %>">
                            <input type="submit" value="Edit" class="button">
                        </form>
                        <form action="DeleteProductServlet" method="post" style="display: inline;">
                            <input type="hidden" name="id" value="<%= product.getId() %>">
                            <input type="submit" value="Delete" class="button" onclick="return confirm('Are you sure you want to delete this product?');">
                        </form>
                    </div>
                <%
                        }
                    } else {
                %>
                    <p>No products found.</p>
                <%
                    }
                %>
            </div>
        </section>
    </div>

    <jsp:include page="footer.html" />
</body>
</html>
