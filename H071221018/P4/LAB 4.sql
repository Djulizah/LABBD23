
#no1
SELECT c.customerName AS 'Nama Customer', c.country AS 'Negara', p.paymentDate AS 'tanggal'
FROM customers AS c
INNER JOIN payments AS p
ON c.customerNumber = p.customerNumber
WHERE p.paymentDate > '2005-01-01'
ORDER BY p.paymentDate ;

#no2
SELECT DISTINCT c.customerName AS 'Nama customer', p.productName, p.productDescription AS 'textDescription'
FROM customers AS c
INNER JOIN orders AS o
ON c.customerNumber = o.customerNumber
INNER JOIN orderdetails AS o1
ON o.orderNumber = o1.orderNumber
INNER JOIN products AS p
ON p.productCode = o1.productCode
WHERE p.productName = 'The Titanic';

#
#no3
ALTER TABLE products
ADD COLUMN `status` VARCHAR(20);

SELECT p.productCode,p.productName,od.quantityOrdered,p.`status`
FROM products AS p
INNER JOIN orderdetails AS od
ON od.productCode=p.productCode
ORDER BY od.quantityOrdered DESC
LIMIT 1

UPDATE products AS p
SET `status` = 'best selling'
WHERE p.productCode = 'S12_4675'

#no 4
SELECT c.customerName , o.`status`
FROM customers AS c
INNER JOIN orders AS o
ON o.customerNumber = c.customerNumber
WHERE o.`status`='Cancelled'

DELETE customers FROM customers
INNER JOIN orders 
ON orders.customerNumber = customers.customerNumber
WHERE orders.`status`='Cancelled'

ALTER TABLE orders DROP FOREIGN KEY orders_ibfk_1;
ALTER TABLE payments DROP FOREIGN KEY payments_ibfk_1
ALTER TABLE orderdetails DROP FOREIGN KEY orderdetails_ibfk_1

#soal tambahan
SELECT customerName , `status` FROM customers
ALTER TABLE customers
ADD COLUMN `status` VARCHAR(20)

UPDATE customers
SET `status` = 'reguler'

SELECT * FROM payments
UPDATE customers
INNER JOIN payments
ON customers.customerNumber= payments.customerNumber
INNER JOIN orders 
ON orders.customerNumber= customers.customerNumber
INNER JOIN orderdetails
ON orderdetails.orderNumber=orders.orderNumber
SET customers.`status` = 'VIP'
WHERE payments.amount > 100000 OR orderdetails.quantityOrdered > 50
