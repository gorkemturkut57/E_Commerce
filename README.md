# eCommerce SQL Database Project

This project demonstrates the creation and management of a simple eCommerce database using SQL Server. It includes tables for Customers, Products, Orders, Order_Items, and Reviews, as well as SQL scripts for creating these tables, inserting sample data, and running queries to extract useful business insights.

## Table of Contents

- [Project Overview](#project-overview)
- [Database Structure](#database-structure)
  - [Customers Table](#customers-table)
  - [Products Table](#products-table)
  - [Orders Table](#orders-table)
  - [Order_Items Table](#order_items-table)
  - [Reviews Table](#reviews-table)
- [Setup Instructions](#setup-instructions)
- [Sample Data](#sample-data)
- [SQL Queries](#sql-queries)
  - [Product Sales Summary](#product-sales-summary)
  - [Customer Revenue Summary](#customer-revenue-summary)
  - [Monthly Sales Summary](#monthly-sales-summary)
  - [Product Rating Summary](#product-rating-summary)
- [How to Use](#how-to-use)
- [Conclusion](#conclusion)

## Project Overview

This project aims to create a basic SQL-based eCommerce database that supports fundamental functionalities like tracking customers, products, orders, and customer reviews. It also includes SQL queries to generate reports, which can help in analyzing sales trends, customer spending patterns, and product ratings.

## Database Structure

The database consists of the following tables:

### Customers Table

The `Customers` table stores information about the customers registered in the eCommerce system.

| Column Name  | Data Type  | Description                         |
|--------------|------------|-------------------------------------|
| customer_id  | INT        | Primary key, unique customer ID     |
| first_name   | NVARCHAR(50) | Customer's first name              |
| last_name    | NVARCHAR(50) | Customer's last name               |
| email        | NVARCHAR(100)| Customer's email address           |
| join_date    | DATE       | Date when the customer joined       |

### Products Table

The `Products` table contains details about the products available for sale.

| Column Name   | Data Type  | Description                           |
|---------------|------------|---------------------------------------|
| product_id    | INT        | Primary key, unique product ID        |
| product_name  | NVARCHAR(100)| Name of the product                 |
| category      | NVARCHAR(50) | Product category                    |
| price         | DECIMAL(10, 2)| Price of the product              |

### Orders Table

The `Orders` table keeps track of customer orders.

| Column Name   | Data Type  | Description                           |
|---------------|------------|---------------------------------------|
| order_id      | INT        | Primary key, unique order ID          |
| customer_id   | INT        | Foreign key, ID of the customer       |
| order_date    | DATE       | Date when the order was placed        |

### Order_Items Table

The `Order_Items` table records the details of each item in an order.

| Column Name   | Data Type  | Description                           |
|---------------|------------|---------------------------------------|
| order_item_id | INT        | Primary key, unique order item ID     |
| order_id      | INT        | Foreign key, ID of the order          |
| product_id    | INT        | Foreign key, ID of the product        |
| quantity      | INT        | Quantity of the product ordered       |
| total_price   | DECIMAL(10, 2)| Total price of the ordered items  |

### Reviews Table

The `Reviews` table captures customer feedback on products.

| Column Name   | Data Type  | Description                           |
|---------------|------------|---------------------------------------|
| review_id     | INT        | Primary key, unique review ID         |
| product_id    | INT        | Foreign key, ID of the product        |
| customer_id   | INT        | Foreign key, ID of the customer       |
| rating        | INT        | Rating given by the customer (1-5)    |
| review_text   | NVARCHAR(MAX)| Textual feedback                   |
| review_date   | DATE       | Date of the review                    |

## Setup Instructions

Follow these instructions to set up the eCommerce database on your SQL Server instance:

1. **Clone the repository**:
   ```bash
   git clone https://github.com/gorkemturkut57/ecommerce-sql-database.git
   cd ecommerce-sql-database
   ```

2. **Open the SQL script**:
   - Open `ecommerce_database.sql` in your preferred SQL Server Management Studio.

3. **Execute the script**:
   - Run the script to create the database, tables, and insert sample data.

4. **Verify the database**:
   - Check if the database and tables have been created successfully with the sample data.

## Sample Data

### Customers

| Customer ID | First Name | Last Name | Email                       | Join Date  |
|-------------|------------|-----------|-----------------------------|------------|
| 1           | Ali        | Yılmaz    | ali.yilmaz@example.com      | 2024-01-15 |
| 2           | Ayşe       | Kaya      | ayse.kaya@example.com       | 2024-02-10 |
| 3           | Mehmet     | Demir     | mehmet.demir@example.com    | 2024-03-05 |

### Products

| Product ID | Product Name | Category    | Price  |
|------------|--------------|-------------|--------|
| 1          | Laptop       | Elektronik  | 3500.00|
| 2          | Kulaklık     | Aksesuar    | 150.00 |
| 3          | Mouse        | Aksesuar    | 75.00  |
| 4          | Klavye       | Aksesuar    | 125.00 |
| 5          | Telefon      | Elektronik  | 2500.00|

### Orders

| Order ID | Customer ID | Order Date |
|----------|-------------|------------|
| 1        | 1           | 2024-04-01 |
| 2        | 2           | 2024-04-02 |
| 3        | 3           | 2024-04-05 |

### Order_Items

| Order Item ID | Order ID | Product ID | Quantity | Total Price |
|---------------|----------|------------|----------|-------------|
| 1             | 1        | 1          | 1        | 3500.00     |
| 2             | 1        | 3          | 2        | 150.00      |
| 3             | 2        | 2          | 1        | 150.00      |
| 4             | 2        | 4          | 1        | 125.00      |
| 5             | 3        | 5          | 1        | 2500.00     |

### Reviews

| Review ID | Product ID | Customer ID | Rating | Review Text                           | Review Date |
|-----------|------------|-------------|--------|---------------------------------------|-------------|
| 1         | 1          | 1           | 5      | Harika bir laptop!                    | 2024-04-02  |
| 2         | 3          | 1           | 4      | Fiyatına göre güzel bir mouse.        | 2024-04-03  |
| 3         | 5          | 2           | 2      | Beklentimi karşılamadı.               | 2024-04-06  |
| 4         | 2          | 3           | 4      | Kulaklık kaliteli ses veriyor.        | 2024-04-07  |

## SQL Queries

Below are the queries provided in this project:

### Product Sales Summary

This query calculates the total quantity sold for each product and orders the results in descending order of sales.

```sql
SELECT p.product_name, SUM(oi.quantity) AS total_sold
FROM Products p
JOIN Order_Items oi ON p.product_id = oi.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC;
```

### Customer Revenue Summary

This query calculates the total revenue generated by each customer and orders the results in descending order of revenue.

```sql
SELECT c.first_name, c.last_name, SUM(oi.total_price) AS total_revenue
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Order_Items oi ON o.order_id = oi.order_id
GROUP BY c.first_name, c.last_name
ORDER BY total_revenue DESC;
```

### Monthly Sales Summary

This query provides a summary of total orders and total sales for each month.

```sql
SELECT 
    FORMAT(o.order_date, 'yyyy-MM') AS month, 
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.total_price) AS total_sales
FROM Orders o
JOIN Order_Items oi ON o.order_id = oi.order_id
GROUP BY FORMAT(o.order_date, 'yyyy-MM')
ORDER BY month;
```

### Product Rating Summary

This query calculates the average rating for each product and orders the results by average rating in descending order.

```sql
SELECT p.product_name, AVG(r.rating) AS average_rating
FROM Products p
JOIN Reviews r

 ON p.product_id = r.product_id
GROUP BY p.product_name
ORDER BY average_rating DESC;
```

## How to Use

1. **Set up the database**:
   - Follow the [Setup Instructions](#setup-instructions) to initialize the database and tables.

2. **Run the SQL queries**:
   - Open the SQL script containing the queries in your SQL Server Management Studio.
   - Execute the queries to generate reports.

3. **Analyze the results**:
   - Use the query results to analyze sales trends, customer preferences, and product ratings.

## Conclusion

This eCommerce SQL database project provides a foundational setup for managing an online store's data, including customer records, product inventory, order tracking, and customer reviews. The SQL scripts offer valuable insights into business performance and can be extended to support more complex analytics and functionalities.

Feel free to contribute by adding new features or optimizing existing queries. If you encounter any issues or have suggestions, please open an issue or pull request.

---

Make sure to replace `https://github.com/yourusername/ecommerce-sql-database.git` with the actual URL of your GitHub repository. If you have additional notes or need to include specific requirements, feel free to customize the README file to fit your project's needs.
