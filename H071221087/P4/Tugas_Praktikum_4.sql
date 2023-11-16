-- nomor 1
SELECT * FROM customers
SELECT * FROM payments

SELECT c.customerName AS 'Nama Customer', c.country AS 'Negara', p.paymentDate AS 'tanggal'
FROM customers AS c 
JOIN payments AS p 
USING (customerNumber)
WHERE paymentDate >= '2005-01-01'
ORDER BY paymentDate;



-- nomor 2
SELECT * FROM customers
SELECT * FROM products
SELECT * FROM productlines 
SELECT * FROM orderdetails
SELECT * FROM orders

SELECT DISTINCT c.customerName AS 'Nama Customer', p.productName, pl.textDescription
FROM customers AS c
JOIN orders AS o
USING (customerNumber)
JOIN orderdetails AS od
USING (orderNumber)
JOIN products AS p
USING (productCode)
JOIN productlines AS pl
USING (productLine)
WHERE productName = 'The Titanic'



-- nomor 3
SELECT * FROM products
SELECT * FROM orderdetails

ALTER TABLE products
ADD status VARCHAR (20);

SELECT *
FROM orderdetails
ORDER BY quantityOrdered DESC
LIMIT 1;

UPDATE products
JOIN orderdetails AS od 
USING (productCode)
SET STATUS = 'best selling'
WHERE productCode = 'S12_4675'
ORDER BY quantityOrdered DESC
LIMIT 1;

SELECT p.productCode, p.productName, od.quantityOrdered, p.status
FROM products AS p
JOIN orderdetails AS od 
USING (productCode)
ORDER BY quantityOrdered DESC
LIMIT 1;




-- nomor 4
SELECT * FROM customers 
SELECT * FROM orders
WHERE STATUS = 'cancelled'

ALTER TABLE orders DROP FOREIGN KEY orders_ibfk_1;
ALTER TABLE orders ADD FOREIGN KEY (customerNumber) REFERENCES customers(customerNumber) ON DELETE CASCADE;

ALTER TABLE orderdetails DROP FOREIGN KEY orderdetails_ibfk_1;
ALTER TABLE orderdetails ADD FOREIGN KEY (orderNumber) REFERENCES orders(orderNumber) ON DELETE CASCADE;

ALTER TABLE payments DROP FOREIGN KEY payments_ibfk_1;
ALTER TABLE payments ADD FOREIGN KEY (customerNumber) REFERENCES customers(customerNumber) ON DELETE CASCADE;

DELETE customers
FROM customers
JOIN orders AS o
USING (customerNumber)
WHERE o.`status` = 'Cancelled'


-- Tugas Tambahan 
ALTER TABLE customers 
ADD STATUS VARCHAR(20); 

UPDATE customers 
SET STATUS = "Regular"

UPDATE customers 
JOIN payments 
USING (customerNumber)
JOIN orders 
USING (customerNumber)
JOIN orderDetails
USING (orderNumber)
SET customers.STATUS = "VIP" 
WHERE payments.amount > 100000 OR orderDetails.quantityOrdered > 50
SELECT customerName, `status` FROM customers 
WHERE customers.Status = "VIP" 
