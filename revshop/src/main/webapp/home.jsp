<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.revshop.Product" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RevShop - Home</title>
    
    <!-- Link to your CSS file -->
    <link rel="stylesheet" href="styles.css">

    <!-- Add Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

    <!-- Add Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <style>
        /* Custom styles to make the navbar pure black */
        .navbar {
            background-color: #000000; /* Pure black background */
        }
        .navbar-dark .navbar-nav .nav-link,
        .navbar-dark .navbar-brand {
            color: #ffffff; /* White text color for contrast */
        }
        .navbar-dark .navbar-nav .nav-link.active,
        .navbar-dark .navbar-nav .nav-link:hover {
            color: #dddddd; /* Light gray color on hover or active state */
        }
        .navbar-toggler-icon {
            background-image: url('data:image/svg+xml;charset=utf8,<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" viewBox="0 0 30 30"><path stroke="%23ffffff" stroke-width="2" d="M 5 7 L 25 7"/><path stroke="%23ffffff" stroke-width="2" d="M 5 15 L 25 15"/><path stroke="%23ffffff" stroke-width="2" d="M 5 23 L 25 23"/></svg>'); /* White hamburger icon */
        }
        .btn {
        width: auto;
        }
        .btn-outline-light {
            color: #ffffff;
            border-color: #ffffff;
        }
        .btn-outline-light:hover {
            background-color: #ffffff;
            color: #000000;
        }
        
    </style>
</head>

<body style="background-color: black;">
    <!-- Bootstrap Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <a class="navbar-brand" href="#">RevShop</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item active">
                    <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
                </li>
                <!-- Add other nav items here if needed -->
            </ul>
            <!-- Form for search and buttons -->
			<form class="form-inline my-2 my-lg-0 ml-auto"
				action="ProductDetailsServlet" method="GET">
				<input class="form-control mr-sm-2" type="search" name="query"
					placeholder="Search products" aria-label="Search">
				<button class="btn btn-outline-light ml-2" style="width: 50px;" type="submit">Search</button>			
				</form>
			<a href="login.jsp" class="btn btn-outline-light ml-2">Login</a>
            <a href="register.jsp" class="btn btn-outline-light ml-2">Register</a>
        </div>
    </nav>

    <section id="carousel">
        <div id="productCarousel" class="carousel slide" data-ride="carousel">
            <ol class="carousel-indicators">
                <li data-target="#productCarousel" data-slide-to="0" class="active"></li>
                <li data-target="#productCarousel" data-slide-to="1"></li>
                <li data-target="#productCarousel" data-slide-to="2"></li>
            </ol>
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img src="img/rtx.jpg" class="d-block w-100" alt="Rev R1 Headphones">
                    <div class="carousel-caption d-none d-md-block">
                        <!-- Caption for the first slide -->
                    </div>
                </div>
                <div class="carousel-item">
                    <img src="img/msi.jpg" class="d-block w-100" alt="Rev rem Wired">
                    <div class="carousel-caption d-none d-md-block">
                        <!-- Caption for the second slide -->
                    </div>
                </div>
                <div class="carousel-item">
                    <img src="img/msi2.jpg" class="d-block w-100" alt="Rev revo Wireless">
                    <div class="carousel-caption d-none d-md-block">
                        <!-- Caption for the third slide -->
                    </div>
                </div>
            </div>
            <a class="carousel-control-prev" href="#productCarousel" role="button" data-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
            </a>
            <a class="carousel-control-next" href="#productCarousel" role="button" data-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
            </a>
        </div>
    </section>

    <section id="featured-products">
        <h2 style="align-content: center; color: white;">Featured Products</h2>
        <div class="product-list">
            <%
                // Retrieve the product list from the request
                Object productListObj = request.getAttribute("productList");
                if (productListObj instanceof List) {
                    @SuppressWarnings("unchecked")
                    List<Product> productList = (List<Product>) productListObj;

                    // Check if the product list is not null and has elements
                    if (productList != null && !productList.isEmpty()) {
                        for (Product product : productList) {
            %>
                <div class="product-item">
                    <img src="data:image/jpeg;base64,<%= product.getImageBase64() %>" alt="<%= product.getName() %>" style="max-width: 150px; max-height: 150px;">
                    <h3><%= product.getName() %></h3>
                    <p>₹<%= product.getPrice() %></p>
                    <!-- Button trigger modal -->
                    <button type="button" style="background-color:black;" class="btn btn-outline-light ml-2" data-toggle="modal" data-target="#productModal<%= product.getId() %>">
                        View Details
                    </button>

                    <!-- Modal -->
                    <div class="modal fade" id="productModal<%= product.getId() %>" tabindex="-1" role="dialog" aria-labelledby="productModalLabel<%= product.getId() %>" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="productModalLabel<%= product.getId() %>"><%= product.getName() %></h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <img src="data:image/jpeg;base64,<%= product.getImageBase64() %>" alt="<%= product.getName() %>" style="max-width: 100%; height: auto;">
                                    <p><strong>Description:</strong> <%= product.getDescription() %></p>
                                    <p><strong>Price:</strong> ₹<%= product.getPrice() %></p>
                                    <p><strong>Category:</strong> <%= product.getCategory() %></p>
                                    <p><strong>Quantity:</strong> <%= product.getQuantity() %></p>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            <% 
                        }
                    } else {
            %>
                <p>No products available.</p>
            <% 
                    }
                } else {
            %>
                <p>Error: Product list is not available.</p>
            <% 
                }
            %>
        </div>
    </section>

    <footer>
        <jsp:include page="footer.html" />
        <p>&copy; 2024 RevShop. All rights reserved.</p>
    </footer>
</body>

</html>
