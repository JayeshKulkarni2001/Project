<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment and Shipping Information</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #fff;
            color: #000;
        }
        .container {
            margin-top: 50px;
            max-width: 600px;
        }
        .card {
            background-color: #000;
            border: 1px solid #333;
        }
        .card-header {
            background-color: #000;
            border-bottom: 1px solid #333;
        }
        .btn-primary {
            background-color: #333;
            border: none;
        }
        .btn-primary:hover {
            background-color: #444;
        }
        .form-control {
            background-color: #000;
            border: 1px solid #333;
            color: #fff;
        }
        .form-control:focus {
            background-color: #000;
            border-color: #555;
            color: #fff;
        }
        /* Popup styling */
        .popup-container {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: #000;
            color: #fff;
            padding: 20px;
            border-radius: 10px;
            text-align: center;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.5);
        }
        .popup-container h2 {
            margin-bottom: 20px;
        }
        .btn-back {
            background-color: #fff;
            color: #000;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }
        .btn-back:hover {
            background-color: #ddd;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="card">
            <div class="card-header">
                <h4 class="card-title text-white">Shipping and Payment Information</h4>
            </div>
            <div class="card-body">
                <form action="PaymentServlet" method="post">
                    <h5 class="text-white">Shipping Information</h5>
                    <div class="form-group">
                        <label for="fullName" class="text-white">Full Name</label>
                        <input type="text" class="form-control" id="fullName" name="fullName" placeholder="John Doe" required>
                    </div>
                    <div class="form-group">
                        <label for="address" class="text-white">Address</label>
                        <input type="text" class="form-control" id="address" name="address" placeholder="123 Main St, Apt 4B" required>
                    </div>
                    <div class="form-group">
                        <label for="city" class="text-white">City</label>
                        <input type="text" class="form-control" id="city" name="city" placeholder="New York" required>
                    </div>
                    <div class="form-group">
                        <label for="state" class="text-white">State</label>
                        <input type="text" class="form-control" id="state" name="state" placeholder="NY" required>
                    </div>
                    <div class="form-group">
                        <label for="zipCode" class="text-white">ZIP Code</label>
                        <input type="text" class="form-control" id="zipCode" name="zipCode" placeholder="10001" required>
                    </div>
                    <div class="form-group">
                        <label for="country" class="text-white">Country</label>
                        <input type="text" class="form-control" id="country" name="country" placeholder="United States" required>
                    </div>

                    <h5 class="text-white mt-4">Payment Information</h5>
                    <div class="form-group">
                        <label for="nameOnCard" class="text-white">Name on Card</label>
                        <input type="text" class="form-control" id="nameOnCard" placeholder="John Doe" required>
                    </div>
                    <div class="form-group">
                        <label for="cardNumber" class="text-white">Card Number</label>
                        <input type="text" class="form-control" id="cardNumber" placeholder="1234 5678 9012 3456" required>
                    </div>
                    <div class="form-row">
                        <div class="col">
                            <div class="form-group">
                                <label for="expiryDate" class="text-white">Expiration Date</label>
                                <input type="text" class="form-control" id="expiryDate" placeholder="MM/YY" required>
                            </div>
                        </div>
                        <div class="col">
                            <div class="form-group">
                                <label for="cvv" class="text-white">CVV</label>
                                <input type="text" class="form-control" id="cvv" placeholder="123" required>
                            </div>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-primary btn-block">Complete Purchase</button>
                </form>
            </div>
        </div>
    </div>
 <!-- Popup container -->
    <div class="popup-container" id="popup">
        <h2>Order Successful!</h2>
        <p>Thank you for shopping with us.</p>
        <button class="btn-back" onclick="window.location.href='BuyerDashboardServlet'">Back to Dashboard</button>
    </div>
    
    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script>
        // Check if there's a query parameter indicating the order is successful
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.has('orderSuccess')) {
            document.getElementById('popup').style.display = 'block';
        }
    </script>
</body>
</html>
