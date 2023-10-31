--- No 1
SELECT c.customerName AS 'Nama Customer', c.country AS 'Negara', p.paymentDate AS 'Tanggal' 
FROM customers c
JOIN payments p
ON c.customerNumber = p.customerNumber
WHERE p.paymentDate > '2004-12-31'
ORDER BY p.paymentDate;


-- No 2
SELECT distinct c.customerName AS 'Nama customer', p.productName, pl.textDescription
FROM customers c 
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderDetails od ON o.orderNumber = od.orderNumber
JOIN products p ON od.productCode = p.productCode
JOIN productlines pl ON p.productLine = pl.productLine
WHERE p.productName = 'The Titanic';


-- No 3
ALTER TABLE products
ADD `status` VARCHAR(20);

DESCRIBE products
SELECT * FROM products

SELECT p.productCode, p.productName, od.quantityOrdered, p.status
FROM products p
JOIN orderDetails od ON p.productCode = od.productCode
ORDER BY od.quantityOrdered DESC
LIMIT 1;

UPDATE products
SET `status` = 'best selling'
WHERE productCode = 'S12_4675';


-- No 4 
ALTER TABLE orders
DROP FOREIGN KEY orders_ibfk_1;

ALTER TABLE orders
ADD FOREIGN KEY (customerNumber)
REFERENCES customers (customerNumber)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE payments
DROP FOREIGN KEY payments_ibfk_1;

ALTER TABLE orders
ADD FOREIGN KEY (customerNumber)
REFERENCES customers (customerNumber)
ON DELETE CASCADE
ON UPDATE CASCADE;


ALTER TABLE orderDetails
DROP FOREIGN KEY orderDetails_ibfk_1;

ALTER TABLE orderDetails
ADD FOREIGN KEY (orderNumber)
REFERENCES customers (orderNumber)
ON DELETE CASCADE
ON UPDATE CASCADE;


DELETE c
FROM customers c
JOIN orders o
ON c.customerNumber = o.customerNumber
WHERE o.`status` = 'Cancelled';

SELECT c.customerName, o.status
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
WHERE o.`status` = 'cancelled';






-- Soal tambahan
ALTER TABLE customers
ADD `status` VARCHAR(20);

SELECT DISTINCT c.customerNumber, c.customerName, p.amount, od.quantityOrdered, c.`status`
FROM customers c
JOIN payments p 
ON c.customerNumber = p.customerNumber
JOIN orders o
ON c.customerNumber = o.customerNumber
JOIN orderdetails od 
ON o.orderNumber = od.orderNumber
WHERE p.amount > 100000 OR od.quantityOrdered >= 50;

UPDATE customers c
JOIN payments p 
ON c.customerNumber = p.customerNumber
JOIN orders o
ON c.customerNumber = o.customerNumber
JOIN orderdetails od
ON o.orderNumber = od.orderNumber
SET c.`status` = 'VIP'  
WHERE p.amount > 100000 OR od.quantityOrdered >= 50;

UPDATE customers
SET `status` = 'Regular';

DESCRIBE customers;

SELECT * FROM customers







