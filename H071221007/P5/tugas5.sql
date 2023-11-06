-- NO. 1

SELECT c.customerName, pd.productName, p.paymentDate, o.`status`
FROM customers c
JOIN orders o
ON o.customerNumber = c.customerNumber
JOIN orderdetails od
ON od.orderNumber = o.orderNumber
JOIN products pd
ON pd.productCode = od.productCode
JOIN payments p
ON p.customerNumber = c.customerNumber
WHERE pd.productName LIKE '%ferrari%' AND o.`status` = 'Shipped'

-- NO. 2

-- a.

SELECT c.customerName, p.paymentDate, CONCAT(e.firstname, ' ', e.lastname)
FROM customers c
JOIN payments p
ON p.customerNumber = c.customerNumber
JOIN employees e
ON e.employeeNumber = c.salesRepEmployeeNumber
WHERE MONTH(p.paymentDate) = 11

-- b.

SELECT c.customerName, p.paymentDate, e.firstname, e.lastname
FROM customers c
JOIN payments p
ON p.customerNumber = c.customerNumber
JOIN employees e
ON e.employeeNumber = c.salesRepEmployeeNumber
WHERE MONTH(p.paymentDate) = 11
ORDER BY amount DESC 
LIMIT 1

-- c.

SELECT c.customerName, pd.productName
FROM customers c
JOIN payments p
ON p.customerNumber = c.customerNumber
JOIN employees e
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders o
ON o.customerNumber = c.customerNumber
JOIN orderdetails od
ON od.ordernumber = o.orderNumber
JOIN products pd
ON pd.productCode = od.productCode
WHERE MONTH(p.paymentDate) = 11 AND c.customerName = 'Corporate Gift Ideas Co.'
ORDER BY amount DESC 

-- d.

SELECT GROUP_CONCAT(pd.productName), c.customerName 
FROM customers c
JOIN payments p
ON p.customerNumber = c.customerNumber
JOIN employees e
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders o
ON o.customerNumber = c.customerNumber
JOIN orderdetails od
ON od.ordernumber = o.orderNumber
JOIN products pd
ON pd.productCode = od.productCode
WHERE MONTH(p.paymentDate) = 11 AND c.customerName = 'Corporate Gift Ideas Co.'
ORDER BY amount DESC 

-- 3.

SELECT c.customerName, o.orderDate, o.shippedDate, o.shippedDate-o.orderDate AS 'Waktu Tunggu'
FROM customers c
JOIN orders o
ON o.customerNumber = c.customerNumber
WHERE c.customerName = 'GiftsForHim.com'
ORDER BY o.orderDate DESC

-- 4. 

USE world

SELECT `code`, lifeExpectancy
FROM country
WHERE `code` LIKE 'C%K' 
AND lifeExpectancy IS NOT NULL

SELECT `name` FROM country
WHERE `code` = 'COK'


-- Soal Tambahan


SELECT c.customerName, p.paymentDate
FROM customers c
JOIN payments p
ON p.customerNumber = c.customerNumber
WHERE DAYNAME(p.paymentDate) = 'sunday'
AND (c.customerName LIKE 'a%'
OR c.customerName LIKE 'i%'
OR c.customerName LIKE 'u%'
OR c.customerName LIKE 'e%'
OR c.customerName LIKE 'o%')


SELECT * FROM customers c
JOIN payments p
ON p.customerNumber = c.customerNumber
WHERE DAYNAME(p.paymentDate) = 'sunday' 
AND customerName REGEXP '^[aeiou]';