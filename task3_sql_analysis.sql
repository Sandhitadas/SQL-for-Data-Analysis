
-- Create tables
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS orders;

CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    name TEXT,
    email TEXT,
    city TEXT
);

CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    order_date TEXT,
    total_amount REAL,
    FOREIGN KEY(customer_id) REFERENCES customers(customer_id)
);

-- Insert data
INSERT INTO customers (customer_id, name, email, city) VALUES
(1, 'Alice', 'alice@example.com', 'Mumbai'),
(2, 'Bob', 'bob@example.com', 'Delhi'),
(3, 'Charlie', 'charlie@example.com', 'Kolkata');

INSERT INTO orders (order_id, customer_id, order_date, total_amount) VALUES
(101, 1, '2023-12-01', 250.75),
(102, 2, '2023-12-05', 300.50),
(103, 1, '2023-12-07', 180.00),
(104, 3, '2023-12-10', 99.99),
(105, 2, '2023-12-15', 450.25);

-- Queries
-- SELECT, WHERE
SELECT * FROM customers WHERE city = 'Mumbai';

-- ORDER BY
SELECT * FROM orders ORDER BY total_amount DESC;

-- GROUP BY
SELECT customer_id, COUNT(*) AS order_count, SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id;

-- INNER JOIN
SELECT c.name, o.order_date, o.total_amount
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id;

-- LEFT JOIN
SELECT c.name, o.order_id, o.total_amount
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;

-- Subquery
SELECT name FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
    GROUP BY customer_id
    HAVING SUM(total_amount) > (
        SELECT AVG(total_amount) FROM orders
    )
);

-- Aggregates
SELECT SUM(total_amount) AS total_revenue FROM orders;
SELECT AVG(total_amount) AS avg_order_value FROM orders;

-- View
CREATE VIEW customer_summary AS
SELECT c.name, COUNT(o.order_id) AS total_orders, SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id;

-- Index
CREATE INDEX idx_customer_id ON orders(customer_id);
