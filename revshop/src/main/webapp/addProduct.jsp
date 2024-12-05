<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>RevShop - Seller Dashboard</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
<div class="login-container">
    <h2 style="color: #7a7a76;">Add Product</h2>
    <form action="AddProductServlet" method="post" class="login-box" enctype="multipart/form-data">
        Name: <input type="text" name="name" required><br>
        Description: <textarea name="description" required></textarea><br>
        Price: <input type="text" name="price" required><br>
        Quantity: <input type="text" name="quantity" required><br>
        Category: <input type="text" name="category" required><br>
         Image: <input type="file" name="image" accept="image/*" required><br>
        <input type="submit" class="button1" value="Add Product">
    </form>
    </div>
</body>
</html>
