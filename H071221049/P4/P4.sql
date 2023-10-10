-- NO. 1 --

SELECT 
	c.customerName AS 'Nama Customer',
	c.country AS 'Negara',
	p.paymentDate AS 'Tanggal'
FROM customers AS c
JOIN payments AS p
ON c.customerNumber = p.customerNumber
WHERE p.paymentDate >= '2005-01-01'
ORDER BY p.paymentDate;

-- NO. 2 --

SELECT DISTINCT 
	c.customerName AS 'Nama customer',
	p.productName,
	pl.textDescription
FROM customers AS c
JOIN orders AS o
ON c.customerNumber = o.customerNumber
JOIN orderdetails AS od
ON o.orderNumber = od.orderNumber
JOIN products AS p
ON od.productCode = p.productCode
JOIN productlines pl
ON p.productLine = pl.productLine
WHERE p.productName = 'The Titanic';

-- NO. 3 -- 

ALTER TABLE products
ADD `status` VARCHAR(20);

DESC products

SELECT * FROM orderdetails 
ORDER BY quantityOrdered DESC
LIMIT 1;

UPDATE products AS p
SET `status` = 'best selling'
WHERE p.productCode = 'S12_4675';

SELECT 
	p.productCode,
	p.productName,
	od.quantityOrdered,
	p.`status`
FROM products AS p
JOIN orderdetails AS od
ON p.productCode = od.productCode
WHERE p.`status` = 'best selling'
ORDER BY od.quantityOrdered DESC 
LIMIT 1;

-- NO. 4 --

SELECT c.customerName, o.`status` 
FROM orders AS o
JOIN customers AS c
ON c.customerNumber = o.customerNumber
WHERE o.`status` = 'cancelled';

SELECT DISTINCT `status` FROM orders;

ALTER TABLE orderdetails 
DROP FOREIGN KEY orderdetails_ibfk_1;

ALTER TABLE payments
DROP FOREIGN KEY payments_ibfk_1;

ALTER TABLE orders 
DROP FOREIGN KEY orders_ibfk_1;

DELETE customers FROM customers
JOIN orders 
ON customers.customerNumber = orders.customerNumber
WHERE orders.`status` = 'Cancelled';

ALTER TABLE orderdetails 
ADD FOREIGN KEY(ordernumber) REFERENCES orders (ordernumber) ON DELETE CASCADE; 

DELETE FROM orders
WHERE `status` = 'cancelled';

-- Soal Tambahan --

ALTER TABLE customers
ADD `status` VARCHAR(20);

SELECT * FROM customers
DESCRIBE customers

UPDATE customers 
SET `status` = 'Reguler'

UPDATE customers AS c
JOIN payments AS p
ON p.customernumber = c.customernumber
JOIN orders AS o
ON c.customerNumber = o.customerNumber
JOIN orderdetails AS od
ON o.orderNumber = od.orderNumber
SET c.`status` = 'VIP'
WHERE p.amount > 100000 or od.quantityOrdered >= 50;

SELECT c.customername, p.amount, od.quantityOrdered, c.`status`
FROM customers AS c
JOIN payments AS p
ON p.customernumber = c.customernumber
JOIN orders AS o
ON c.customerNumber = o.customerNumber
JOIN orderdetails AS od
ON o.orderNumber = od.orderNumber
WHERE p.amount > 100000 or od.quantityOrdered >= 50;