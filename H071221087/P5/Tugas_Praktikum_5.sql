-- Nomor 1
SELECT c.customerName, p.productName, py.paymentDate, o.`status`
FROM customers AS c
JOIN payments AS py 
USING (customerNumber)
JOIN orders AS o
USING (customerNumber)
JOIN orderdetails AS od 
USING (orderNumber)
JOIN products AS p 
USING (productCode)
WHERE p.productName LIKE '%Ferrari%' 
AND o.`status` = 'Shipped'
LIMIT 3;


-- Nomor 2
#A
SELECT c.customerName AS 'Nama customer', p.paymentDate AS 'Tanggal pembayaran',p.amount AS 'Data pembayaran', CONCAT(e.firstName, ' ', e.lastName) AS 'FullName'
FROM customers AS c
JOIN employees AS e
ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN payments AS p
ON c.customerNumber = p.customerNumber
WHERE MONTH(p.paymentDate) = 11;

#B
SELECT c.customerName AS 'Nama customer', p.paymentDate AS 'Tanggal pembayaran', CONCAT(e.firstName, ' ', e.lastName) AS employeeName, p.amount
FROM customers AS c 
JOIN payments AS p 
ON c.customerNumber = p.customerNumber
JOIN employees AS e
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE MONTH(p.paymentDate) = 11
ORDER BY p.amount DESC
LIMIT 1;

#C
SELECT c.customerName, p.productName
FROM customers AS c
JOIN payments AS py
USING (customerNumber)
JOIN orders AS o
USING (customerNumber)
JOIN orderdetails AS od
USING (orderNumber)
JOIN products AS p
USING (productCode) 
WHERE MONTH (py.paymentDate) = 11
AND customerName LIKE '%corporate%'

#D
SELECT c.customerName, GROUP_CONCAT(p.productName SEPARATOR ', ') AS 'produk yang dibeli'
FROM customers AS c
JOIN payments AS py
USING (customerNumber)
JOIN orders AS o 
ON c.customerNumber = o.customerNumber
JOIN orderdetails AS od
ON o.orderNumber = od.orderNumber
JOIN products AS p 
ON od.productCode = p.productCode
WHERE c.customerName LIKE '%corporate%';


-- Nomor 3
SELECT c.customerName, o.orderDate, o.shippedDate, (o.shippedDate - o.orderDate) AS 'Delay'
FROM customers AS c
JOIN orders AS o 
USING (customerNumber)
WHERE c.customerName = 'GiftsForHim.com' 


-- Nomor 4
USE world;
SELECT * FROM country
WHERE CODE LIKE "C%K" AND lifeExpectancy IS NOT NULL 


-- Tugas Tambahan
-- Tampilkan pembayaran yang dilakukan oleh customer pada hari minggu 
-- dan namanya diawali huruf vocal

SELECT c.customerName, p.productName, DAYNAME(py.paymentDate)
FROM customers AS c
JOIN payments AS py
USING (customerNumber)
JOIN products AS p 
WHERE DAYNAME(py.paymentDate) = 'sunday' 
AND (c.customerName LIKE 'a%,' 
OR c.customerName LIKE 'i%' 
OR c.customerName LIKE 'u%' 
OR c.customerName LIKE 'e%' 
OR c.customerName LIKE 'o%')



SELECT c.customerName, p.paymentDate, DAYNAME(p.paymentDate)
FROM customers c
JOIN payments p
USING (customerNumber)
WHERE DAYNAME(p.paymentDate) = 'SUNDAY' 
AND LEFT(c.customerName, 1) IN ('a', 'i', 'u', 'e', 'o')


SELECT c.customerName, p.productName, py.paymentDate, o.`status`
FROM customers AS c
JOIN payments AS py 
USING (customerNumber)
JOIN orders AS o
USING (customerNumber)
JOIN orderdetails AS od 
USING (orderNumber)
JOIN products AS p 
USING (productCode)
WHERE p.productName LIKE '%Ferrari%' 
AND o.`status` = 'Sunday'
