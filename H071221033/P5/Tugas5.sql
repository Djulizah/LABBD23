USE classicmodels

-- no1
SELECT c.customername, pro.productname, pay.paymentdate, o.`status`
FROM customers c
JOIN payments pay USING (customerNumber)
JOIN orders o USING (customerNumber)
JOIN orderdetails od USING (ordernumber)
JOIN products pro USING (productcode)
WHERE c.customerName = 'Signal Gift Stores' AND pro.productName LIKE '%Ferrari%'

-- no2
SELECT * FROM employees
SELECT * FROM customers
-- a
SELECT c.customerName, pay.paymentDate, CONCAT(firstname, " ", lastname) AS NamaKaryawan, pay.amount 
FROM customers c
JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN payments pay USING (customerNumber)
WHERE MONTH(pay.paymentdate) = 11
-- b
#SELECT c.customerName, pay.paymentDate, pay.amount
SELECT c.customerName, pay.paymentDate, CONCAT(firstname, " ", lastname) AS NamaKaryawan, pay.amount
FROM customers c
JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN payments pay USING (customernumber)
WHERE MONTH(pay.paymentdate) = 11
ORDER BY pay.amount DESC 
LIMIT 1
-- c
SELECT c.customerName, pro.productname
FROM customers c
JOIN payments pay USING (customerNumber)
JOIN orders o USING (customerNumber)
JOIN orderdetails USING (orderNumber)
JOIN products pro USING (productCode)
WHERE c.customerName = 'Corporate Gift Ideas Co.' AND MONTH(pay.paymentdate) = 11
-- d
SELECT c.customerName, GROUP_CONCAT(pro.productname)
FROM customers c
JOIN payments pay USING (customerNumber)
JOIN orders o USING (customerNumber)
JOIN orderdetails USING (orderNumber)
JOIN products pro USING (productCode)
WHERE c.customerName = 'Corporate Gift Ideas Co.' AND MONTH(pay.paymentdate) = 11

-- no3
SELECT c.customerName, o.orderDate, o.shippedDate, o.comments, ABS(DATEDIFF (o.orderDate, o.shippedDate)) AS waitingDays
FROM customers c
JOIN orders o USING (customerNumber)
WHERE c.customerName = 'GiftsForHim.com'
ORDER BY o.orderdate DESC 

-- no4
USE world
SELECT * FROM country
WHERE `code` LIKE 'c%k' AND lifeExpectancy IS NOT NULL 

-- no5
SELECT * FROM payments
SELECT c.customerName, pay.paymentDate, DAYNAME(pay.paymentDate) AS HariPembayaran
FROM customers c
JOIN payments pay USING (customerNumber)
WHERE DAYNAME(pay.paymentDate) = 'sunday' AND LEFT (c.customerName, 1) IN ('a', 'i', 'u', 'e', 'o') 