CREATE DATABASE Foxtale_Brand;
USE Foxtale_Brand;

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price INT
);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_details (
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO products VALUES
(101,'Foxtale Niacinamide Serum','Serum',549),
(102,'Foxtale Salicylic Acid Cleanser','Cleanser',399),
(103,'Foxtale Hydrating Moisturizer','Moisturizer',449),
(104,'Foxtale Glow Sunscreen SPF 50','Sunscreen',499),
(105,'Foxtale Retinol Night Cream','Treatment',699),
(106,'Foxtale Vitamin C Face Wash','Cleanser',299),
(107,'Foxtale Barrier Repair Cream','Moisturizer',599),
(108,'Foxtale AHA BHA Exfoliator','Treatment',649),
(109,'Foxtale Purple Clay Mask','FaceMask',679),
(110,'Foxtale Brightening Lipbalm','Lipbalm',399),
(111,'Foxtale Oil Balancing Moisturizer','Moisturizer',449),
(112,'Foxtale Salicylic Acid Exfoliating BodyWash','BodyWash',499);

INSERT INTO customers VALUES
(1,'Pooja','Bangalore'),
(2,'Roopa','Hyderabad'),
(3,'Ananya','Mumbai'),
(4,'Krishna','Chennai'),
(5,'Shakeer','Kadapa'),
(6,'Sindu','Chennai'),
(7,'Sridhar','Banglore'),
(8,'HaswithRam','Banglore');

INSERT INTO orders VALUES
(1001,1,'2024-01-10'),
(1002,2,'2024-01-15'),
(1003,1,'2024-02-05'),
(1004,3,'2024-02-20'),
(1005,4,'2025-03-12'),
(1006,5,'2025-04-04'),
(1007,6,'2025-04-22'),
(1008,1,'2025-05-01'),
(1009,7,'2025-05-12'),
(1010,8,'2025-06-04'),
(1011,5,'2025-07-15');

INSERT INTO order_details VALUES
(1001,101,1),
(1001,103,1),
(1002,102,1),
(1003,104,2),
(1004,103,1),
(1005,101,1),
(1005,102,1),
(1006,105,2),
(1007,106,1),
(1008,107,3),
(1009,105,2),
(1010,109,1),
(1011,110,2),
(1008,112,1),
(1007,108,2);

select * from products;
select * from customers;
select * from orders;
select * from order_details;

# Total Revenue

SELECT 
    SUM(od.quantity * p.price) AS total_revenue
FROM order_details od
JOIN products p ON od.product_id = p.product_id;

# Revenue by Product

SELECT 
    p.product_name,
    SUM(od.quantity * p.price) AS revenue
FROM order_details od
JOIN products p ON od.product_id = p.product_id
GROUP BY p.product_name
ORDER BY revenue DESC;

# Category-wise Sales

SELECT 
    p.category,
    SUM(od.quantity * p.price) AS category_revenue
FROM order_details od
JOIN products p ON od.product_id = p.product_id
GROUP BY p.category;

#  Monthly Sales Trend

SELECT 
    MONTH(o.order_date) AS month,
    SUM(od.quantity * p.price) AS revenue
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
GROUP BY MONTH(o.order_date)
ORDER BY month;

#  Top Customers

SELECT 
    c.customer_name,
    SUM(od.quantity * p.price) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
GROUP BY c.customer_name
ORDER BY total_spent DESC;




















