<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%@ page import="com.revshop.Product" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>RevShop - Edit Product</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
<div class="login-container">
    <h2 style="color: #7a7a76;">Edit Product</h2>
    <%
        String id = request.getParameter("id");
        Product product = null;
        
        if (id != null) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/revshop", "root", "12345678");
                String sql = "SELECT * FROM products WHERE id = ?";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setString(1, id);
                ResultSet rs = stmt.executeQuery();
                
                if (rs.next()) {
                    product = new Product();
                    product.setId(rs.getInt("id"));
                    product.setName(rs.getString("name"));
                    product.setDescription(rs.getString("description"));
                    product.setPrice(rs.getBigDecimal("price"));
                    product.setQuantity(rs.getInt("quantity"));
                    product.setCategory(rs.getString("category"));
                    product.setImageUrl(rs.getBytes("image_url"));
                }
                
                rs.close();
                stmt.close();
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("sellerdashboard.jsp?error=Unable+to+load+product+details");
            }
        }
    %>
    <form action="EditProductServlet" method="post" class="login-box" enctype="multipart/form-data">
        <input type="hidden" name="id" value="<%= product != null ? product.getId() : "" %>"><br>
        Name: <input type="text" name="name" value="<%= product != null ? product.getName() : "" %>" required><br>
        Description: <textarea name="description" required><%= product != null ? product.getDescription() : "" %></textarea><br>
        Price: <input type="text" name="price" value="<%= product != null ? product.getPrice() : "" %>" required><br>
        Quantity: <input type="text" name="quantity" value="<%= product != null ? product.getQuantity() : "" %>" required><br>
        Category: <input type="text" name="category" value="<%= product != null ? product.getCategory() : "" %>" required><br>
        Current Image: <img src="<%= product != null ? product.getImageUrl() : "" %>" alt="Product Image" style="max-width: 150px;"><br>
        Change Image: <input type="file" name="image" accept="image/*"><br>
        <input type="submit" class="button1" value="Update Product">
    </form>
</div>
</body>
</html>
