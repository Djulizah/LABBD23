USE classicmodels
#no1
SELECT c.customerName, p.productName, pa.paymentDate, o.status
FROM customers AS c
JOIN payments AS pa
ON pa.customerNumber = c.customerNumber
JOIN orders AS o
ON c.customerNumber = o.customerNumber
JOIN orderdetails AS od
ON od.orderNumber = o.orderNumber
JOIN products AS p
ON p.productCode = od.productCode
WHERE p.productName LIKE '%ferrari%' AND o.status= 'Shipped'
LIMIT 3

#no2
#a
SELECT c.customerName, MONTHNAME(pa.paymentDate), CONCAT(e.firstName, " " ,e.lastName), pa.amount
FROM customers AS c
JOIN payments AS pa
ON pa.customerNumber = c.customerNumber
JOIN employees AS e
ON e.employeeNumber = c.salesRepEmployeeNumber
WHERE MONTHNAME (pa.paymentDate) = 'November'

#b
SELECT c.customerName, MONTHNAME(pa.paymentDate),  CONCAT(e.firstName, " " ,e.lastName), pa.amount
FROM customers AS c
JOIN payments AS pa
ON pa.customerNumber = c.customerNumber
JOIN employees AS e
ON e.employeeNumber = c.salesRepEmployeeNumber
WHERE MONTHNAME(pa.paymentDate) = 'November'
ORDER BY pa.amount DESC
LIMIT 1

#c
SELECT c.customerName, p.productName
FROM customers AS c
JOIN employees AS e
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments AS pa
ON pa.customerNumber = c.customerNumber
JOIN orders AS o
ON c.customerNumber = o.customerNumber
JOIN orderdetails AS od
ON od.orderNumber = o.orderNumber
JOIN products AS p
ON p.productCode = od.productCode
WHERE MONTHNAME(pa.paymentDate) = 'November' AND c.customerName = 'Corporate Gift Ideas Co.'


#d
SELECT c.customerName, group_concat(p.productName)
FROM customers AS c
JOIN employees AS e
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments AS pa
ON pa.customerNumber = c.customerNumber
JOIN orders AS o
ON c.customerNumber = o.customerNumber
JOIN orderdetails AS od
ON od.orderNumber = o.orderNumber
JOIN products AS p
ON p.productCode = od.productCode
WHERE MONTHNAME(pa.paymentDate) = 'November' AND c.customerName = 'Corporate Gift Ideas Co.'

#no3
SELECT c.customerName, o.orderDate, o.shippedDate, ABS(DATEDIFF(o.orderdate, o.shippedDate)) AS 'Telah menunggu selama'
FROM customers AS c
JOIN orders AS o
ON o.customerNumber = c.customerNumber
WHERE c.customerName = 'GiftsForHim.com'
ORDER BY o.orderDate DESC
LIMIT 1

#no4
USE world
SELECT * FROM city
SELECT * FROM country

-- diketahui A
SELECT co.code, co.Name, co.LifeExpectancy
FROM country AS co
WHERE co.code LIKE 'C%K'
-- WHERE co.code LIKE 'C%' AND co.code LIKE '%K'
-- diketahaui B
SELECT co.code, co.Name, co.LifeExpectancy
FROM country AS co
WHERE co.lifeexpectancy IS NOT NULL 
-- jawaban
SELECT co.code, co.Name, co.LifeExpectancy
FROM country AS co
WHERE co.code LIKE 'C%K' AND co.lifeexpectancy IS NOT NULL 

-- soal tambahan
USE classicmodels
SELECT c.customerName , DAYNAME(pa.paymentDate)
FROM customers AS c
JOIN payments AS pa
USING(customerNumber)
WHERE DAYNAME(pa.paymentDate) = "Sunday" 
AND LEFT(c.customerName, 1) 
IN ('a', 'i', 'u', 'e', 'o')

SELECT c.customerName , DAYNAME(pa.paymentDate)
FROM customers AS c
JOIN payments AS pa
USING(customerNumber)
WHERE DAYNAME(pa.paymentDate) = "Sunday" 
AND (c.customerName LIKE 'a%' or c.customerName LIKE 'i%' or c.customerName LIKE 'u%' 
or c.customerName LIKE 'e%' or c.customerName LIKE 'o%')

SELECT c.customerName , DAYNAME(pa.paymentDate)
FROM customers AS c
JOIN payments AS pa
USING(customerNumber)
WHERE DAYNAME(pa.paymentDate) = "Sunday" 
AND c.customerName REGEXP '^[aiueo]'



