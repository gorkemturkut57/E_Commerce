-- Veritabaný oluþturulmasý
CREATE DATABASE Ecommerce;
GO

-- Veritabanýný kullanma
USE Ecommerce;
GO

-- Customers tablosu oluþturulmasý
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY IDENTITY(1,1),
    first_name NVARCHAR(50),
    last_name NVARCHAR(50),
    email NVARCHAR(100),
    join_date DATE
);
GO

-- Products tablosu oluþturulmasý
CREATE TABLE Products (
    product_id INT PRIMARY KEY IDENTITY(1,1),
    product_name NVARCHAR(100),
    category NVARCHAR(50),
    price DECIMAL(10, 2)
);
GO

-- Orders tablosu oluþturulmasý
CREATE TABLE Orders (
    order_id INT PRIMARY KEY IDENTITY(1,1),
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
GO

-- Order_Items tablosu oluþturulmasý
CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY IDENTITY(1,1),
    order_id INT,
    product_id INT,
    quantity INT,
    total_price DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
GO

-- Reviews tablosu oluþturulmasý
CREATE TABLE Reviews (
    review_id INT PRIMARY KEY IDENTITY(1,1),
    product_id INT,
    customer_id INT,
    rating INT CHECK(rating >= 1 AND rating <= 5),
    review_text NVARCHAR(MAX),
    review_date DATE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
GO

-- Customers tablosuna veri ekleme
INSERT INTO Customers (first_name, last_name, email, join_date) VALUES
('Ali', 'Yýlmaz', 'ali.yilmaz@example.com', '2024-01-15'),
('Ayþe', 'Kaya', 'ayse.kaya@example.com', '2024-02-10'),
('Mehmet', 'Demir', 'mehmet.demir@example.com', '2024-03-05');
GO

-- Products tablosuna veri ekleme
INSERT INTO Products (product_name, category, price) VALUES
('Laptop', 'Elektronik', 3500.00),
('Kulaklýk', 'Aksesuar', 150.00),
('Mouse', 'Aksesuar', 75.00),
('Klavye', 'Aksesuar', 125.00),
('Telefon', 'Elektronik', 2500.00);
GO

-- Orders tablosuna veri ekleme
INSERT INTO Orders (customer_id, order_date) VALUES
(1, '2024-04-01'),
(2, '2024-04-02'),
(3, '2024-04-05');
GO

-- Order_Items tablosuna veri ekleme
INSERT INTO Order_Items (order_id, product_id, quantity, total_price) VALUES
(1, 1, 1, 3500.00),
(1, 3, 2, 150.00),
(2, 2, 1, 150.00),
(2, 4, 1, 125.00),
(3, 5, 1, 2500.00);
GO

-- Reviews tablosuna veri ekleme
INSERT INTO Reviews (product_id, customer_id, rating, review_text, review_date) VALUES
(1, 1, 5, 'Harika bir laptop!', '2024-04-02'),
(3, 1, 4, 'Fiyatýna göre güzel bir mouse.', '2024-04-03'),
(5, 2, 2, 'Beklentimi karþýlamadý.', '2024-04-06'),
(2, 3, 4, 'Kulaklýk kaliteli ses veriyor.', '2024-04-07');
GO

SELECT p.product_name, SUM(oi.quantity) AS total_sold
FROM Products p
JOIN Order_Items oi ON p.product_id = oi.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC;
GO

SELECT c.first_name, c.last_name, SUM(oi.total_price) AS total_revenue
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Order_Items oi ON o.order_id = oi.order_id
GROUP BY c.first_name, c.last_name
ORDER BY total_revenue DESC;
GO

SELECT 
    FORMAT(o.order_date, 'yyyy-MM') AS month, 
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.total_price) AS total_sales
FROM Orders o
JOIN Order_Items oi ON o.order_id = oi.order_id
GROUP BY FORMAT(o.order_date, 'yyyy-MM')
ORDER BY month;
GO

SELECT p.product_name, AVG(r.rating) AS average_rating
FROM Products p
JOIN Reviews r ON p.product_id = r.product_id
GROUP BY p.product_name
ORDER BY average_rating DESC;
GO

