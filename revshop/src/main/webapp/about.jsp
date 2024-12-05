<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>About Us</title>
<style type="text/css">
header {
	background-color: #000;
	color: white;
	padding: 20px;
	text-align: center;
}

#abt {
	background-color: #f4f4f4; /* Light gray background */
	padding: 40px 20px; /* Spacing around the content */
	text-align: center; /* Center-align the text */
	border-radius: 10px; /* Rounded corners for the section */
	margin: 20px 0; /* Space above and below the section */
}

body {
	font-family: Arial, sans-serif;
	background-color: #f4f4f4;
	color: #333;
	margin: 0;
	padding: 0;
}
.container {
 max-width: 1200px;
            margin: 20px auto;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
}
</style>
</head>
<body>

	<header>
		<h1>About Us</h1>
	</header>

	<section id="abt">
		<div class="container">
			<div class="about-content">
				<div class="about-text">
					<p>Welcome to RevShop! We are a dedicated e-commerce platform
						offering a wide range of products for both buyers and sellers. Our
						mission is to provide a secure, user-friendly, and versatile
						shopping experience. Whether you're here to browse or to manage
						your business, RevShop is designed to cater to your needs.</p>
					<p>Founded in 2024, RevShop has quickly grown to become a
						trusted name in the e-commerce world. We are committed to
						delivering quality products and exceptional service to our users.
						Join us and discover a shopping experience like no other!</p>
				</div>
			</div>
		</div>
	</section>

	<!-- Footer Section -->
	<footer style="background-color: #fff; color: #000; padding: 20px; text-align: center;">
    <div style="display: flex; justify-content: space-between; flex-wrap: wrap; max-width: 1200px; margin: 0 auto;">
        <!-- About Section -->
        <div style="flex: 1; min-width: 200px; margin: 10px;">
            <h3 style="color: #000;">About RevShop</h3>
            <p style="line-height: 1.6;">RevShop is a versatile e-commerce platform offering a wide range of products for buyers and sellers. Our mission is to provide a secure and user-friendly shopping experience.</p>
        </div>
        <!-- Quick Links Section -->
        <div style="flex: 1; min-width: 200px; margin: 10px;">
            <h3 style="color: #000;">Quick Links</h3>
            <ul style="list-style: none; padding: 0;">
                <li><a href="index.jsp" style="color: #000; text-decoration: none;" onmouseover="this.style.color='#7a7a76'" onmouseout="this.style.color='#000'">Home</a></li>
                <li><a href="about.jsp" style="color: #000; text-decoration: none;" onmouseover="this.style.color='#7a7a76'" onmouseout="this.style.color='#000'">About Us</a></li>
                <li><a href="terms.jsp" style="color: #000; text-decoration: none;" onmouseover="this.style.color='#7a7a76'" onmouseout="this.style.color='#000'">Terms & Conditions</a></li>
                <li><a href="privacy.jsp" style="color: #000; text-decoration: none;" onmouseover="this.style.color='#7a7a76'" onmouseout="this.style.color='#000'">Privacy Policy</a></li>
            </ul>
        </div>
        <!-- Contact Section -->
        <div style="flex: 1; min-width: 200px; margin: 10px;">
            <h3 style="color: #000;">Contact Us</h3>
            <p style="line-height: 1.6;">Email: support@revshop.com</p>
            <p style="line-height: 1.6;">Phone: +123-456-7890</p>
            <p style="line-height: 1.6;">Address: 123 RevShop Street, City, Country</p>
        </div>
    </div>
    <div style="border-top: 1px solid #333; padding-top: 20px; margin-top: 20px;">
        <p>&copy; 2024 RevShop. All Rights Reserved.</p>
    </div>
</footer>
</body>
</html>