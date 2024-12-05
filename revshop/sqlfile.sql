create database revshop;
use revshop;
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    role VARCHAR(20) NOT NULL
);

CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    quantity INT NOT NULL,
    category VARCHAR(255),
    image_url LONGBLOB,
    addby VARCHAR(255) NOT NULL
);
-- use revshop;
select id,name,description,price,quantity,category,  image_url,addby from products;

CREATE TABLE Cart (
    cart_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL, -- or session_id if you're using sessions instead of user accounts
    product_id INT NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id), -- Assumes you have a Users table
    FOREIGN KEY (product_id) REFERENCES products(id) -- Assumes you have a Products table
);

ALTER TABLE Cart
ADD CONSTRAINT unique_cart_item UNIQUE (user_id, product_id);

select * from Cart;
SELECT p.id, p.name, p.price, c.quantity FROM Cart c JOIN products p ON c.product_id = p.id WHERE c.user_id = 2;

CREATE TABLE shipping_info (
    id INT AUTO_INCREMENT PRIMARY KEY, -- or SERIAL in PostgreSQL
    full_name VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(50) NOT NULL,
    zip_code VARCHAR(20) NOT NULL,
    country VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE shipping_info
ADD user_id INT,  -- Add the user_id column
ADD CONSTRAINT fk_user
FOREIGN KEY (user_id) REFERENCES users(id);

ALTER TABLE shipping_info
ADD CONSTRAINT unique_id_user_id UNIQUE (id, user_id);

ALTER TABLE shipping_info
ADD COLUMN prod_id INT,
ADD CONSTRAINT fk_product
FOREIGN KEY (prod_id) REFERENCES products(id);

ALTER TABLE shipping_info
ADD CONSTRAINT unique_prod_id UNIQUE (prod_id);

ALTER TABLE shipping_info
ADD COLUMN prod_name VARCHAR(255),
ADD COLUMN prod_price DECIMAL(10, 2),
ADD COLUMN quantity INT;

-- ALTER TABLE shipping_info
-- DROP foreign key fk_product;

-- ALTER TABLE shipping_info
-- DROP Index unique_prod_id;

-- ALTER TABLE shipping_info
-- ADD CONSTRAINT fk_product
-- FOREIGN KEY (prod_id) REFERENCES products(id);

CREATE TABLE wishlist (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    date_added TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

