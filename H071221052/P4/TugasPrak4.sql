USE classicmodels
SELECT * FROM customers 
SELECT * FROM products
SELECT * FROM orderdetails
SELECT * FROM orders
SELECT * FROM payments 
-- Nomor 1
SELECT c.customerName AS 'Nama Customer', c.country AS 'Negara', p.paymentDate AS 'tanggal'
FROM customers AS C
JOIN payments AS p ON c.customerNumber = p.customerNumber
WHERE paymentDate > '2004-12-31'
-- WHERE paymentDate >= '2005-01-01' 
ORDER BY paymentDate 

-- Nomor 2
SELECT DISTINCT c.customerName AS 'Nama Customer' , p.productName, p.productDescription AS 'textDescription'
FROM customers AS C
JOIN orders AS o ON c.customerNumber = o.customerNumber
JOIN orderdetails as o2 ON o.orderNumber = o2.orderNumber
JOIN products AS  p ON o2.productCode = p.productCode
WHERE p.productName = 'The Titanic' 

-- Nomor 3
ALTER TABLE products 
ADD status VARCHAR (20);
DESCRIBE products

SELECT * FROM orderdetails
ORDER BY quantityOrdered DESC 
LIMIT 1;

UPDATE products
SET status = 'best selling'
WHERE productCode = 'S12_4675'
SELECT * FROM products

SELECT p.productCode, p.productName, o2.quantityOrdered, p.status
FROM products AS p
JOIN orderdetails AS o2
ON o2.productCode = p.productCode 
ORDER BY quantityOrdered DESC 
LIMIT 1; 

-- Nomor4
SELECT * FROM orders
WHERE status = 'cancelled';
SELECT * FROM orderdetails;
SELECT * FROM customers

ALTER TABLE orders DROP FOREIGN KEY orders_ibfk_1;
ALTER TABLE orders ADD FOREIGN KEY (customerNumber) REFERENCES customers (customerNumber) ON DELETE CASCADE;

ALTER TABLE payments DROP FOREIGN KEY payments_ibfk_1;
ALTER TABLE payments ADD FOREIGN KEY (customerNumber) REFERENCES customers (customerNumber) ON DELETE CASCADE;

ALTER TABLE orderdetails DROP FOREIGN KEY orderdetails_ibfk_1;
ALTER TABLE orderdetails ADD FOREIGN KEY (orderNumber) REFERENCES orders (orderNumber) ON DELETE CASCADE;

DELETE customers FROM customers
JOIN orders
ON customers.customerNumber = orders.customerNumber
WHERE orders.status = 'cancelled';

SELECT * FROM customers
SELECT c.customerName, o.`status` FROM customers c
JOIN orders o
ON c.customerNumber = o.customerNumber
WHERE o.`status` = 'cancelled';

-- soal tambahan
ALTER TABLE customers
ADD STATUS VARCHAR (20) DEFAULT 'reguler';
ALTER TABLE customers DROP STATUS  

UPDATE customers
SET customers.status = "Reguler"

UPDATE customers 
JOIN payments ON customers.customerNumber = payments.customerNumber
JOIN orders ON customers.customerNumber = orders.customerNumber
JOIN orderdetails ON orders.orderNumber = orderdetails.orderNumber
SET customers.status = "VIP"
WHERE payments.amount > 100000 OR orderdetails.quantityOrdered > 50;

DESCRIBE customers
SELECT * FROM payments
SELECT * FROM orderdetails

SELECT customerNumber, status FROM customers

