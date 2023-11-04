USE classicmodels;

#1
SELECT c.customerName AS "Nama Customer", c.country AS "Negara", p.paymentDate AS "tanggal"
FROM customers c
JOIN payments p
ON c.customerNumber = c.customerNumber
WHERE p.paymentDate >= '2005-01-01' ORDER BY p.paymentDate ASC ;

#2
SELECT DISTINCT c.customerName AS 'Nama customer', p.productName, pl.textDescription 
FROM customers c
JOIN orders o
ON c.customerNumber = o.customerNumber
JOIN orderdetails od
ON o.orderNumber = od.orderNumber
JOIN products p
ON od.productCode = p.productCode
JOIN productLines pl
ON p.productLine = pl.productLine
WHERE p.productName = 'The Titanic';

#3  
ALTER TABLE products ADD `status` VARCHAR(20);

UPDATE products
SET `status` = 'best selling'
WHERE productCode = 'S12_4675';

SELECT p.productCode, p.productName, od.quantityOrdered, p.`status` 
FROM products p
JOIN orderdetails od
ON p.productCode = od.productCode
ORDER BY quantityOrdered DESC 
LIMIT 1;

-- SELECT * FROM orderdetails;
SELECT * FROM orders

#4
-- ALTER TABLE orderdetails DROP orderdetails FOREIGN KEY orderdetails_ibfk_1;
-- ALTER TABLE orderdetails ADD FOREIGN KEY (orderNumber) references orders (orderNumber) ON DELETE CASCADE;
-- 
-- DROP DATABASE classicmodels 
-- 
-- DELETE FROM orders
-- WHERE 'status' = 'cancelled'

SELECT  customers.customerNumber , orders.`status` 
FROM customers 
JOIN orders 
ON customers.customerNumber = orders.customerNumber
JOIN orderdetails 
ON orderdetails.orderNumber = orderdetails.orderNumber
WHERE orders.`status` = "Cancelled"

ALTER TABLE orders DROP FOREIGN KEY orders_ibfk_1;
ALTER TABLE payments DROP FOREIGN KEY payments_ibfk_1;
ALTER TABLE orderdetails DROP FOREIGN KEY orderdetails_ibfk_1;

-- DELETE customers FROM customers
-- JOIN orders 
-- ON customers.customerNumber = orders.customerNumber
-- WHERE orders.`status` = 'cancelled'; 

SELECT * FROM customers
SELECT * FROM orders;orderdetails 

#soal tambahan
ALTER TABLE customers ADD `status` VARCHAR(20);


UPDATE customers
INNER JOIN payments 
ON customers.customerNumber = payments.customerNumber
JOIN orders
ON orders.customerNumber = customers.customerNumber
JOIN orderdetails 
ON orderdetails.ordernumber = orders.orderNumber
SET customers.status = 'VIP' WHERE payments.amount > 100000 OR orderdetails.quantityOrdered > 50;

UPDATE customers SET `status` = 'Regular';
SELECT STATUS FROM customers;

DESC customers

SELECT STATUS FROM customers;
