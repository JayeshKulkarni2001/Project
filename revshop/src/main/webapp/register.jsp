<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>User Registration</title>
<link rel="stylesheet" href="styles.css">
</head>
<body>
	<div class="login-container">
		<form class="login-box" action="ServletRegister" method="post">
			<h2>Register</h2>
			<div>
				<label for="name">Name</label> <input type="text" id="name"
					name="name" required>
			</div>
			<div>
				<label for="email">Email</label> <input type="email" id="email"
					name="email" required>
			</div>
			<div>
				<label for="password">Password</label> <input type="password"
					id="password" name="password" required>
			</div>
			<div>
				<label for="role">Register as</label> <select id="role" name="role"
					required>
					<option value="" disabled selected>Select Role</option>
					<option value="buyer">Buyer</option>
					<option value="seller">Seller</option>
				</select>
			</div>
			<div>
				<input type="submit" value="Register" class="button1">
			</div>
			<p class="signup-link">
			Already have an account? <a href="login.jsp">Login here</a>
		</p>
		</form>
	</div>
</body>
</html>
