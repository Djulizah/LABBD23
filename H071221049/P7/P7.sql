-- NO. 1

SELECT 
	CONCAT(o.addressLine1, ' | ', o.addressLine2, ' | ', o.city, ' | ', o.country) AS Alamat,
	c.customerNumber,
	COUNT(p.amount)
FROM offices o
JOIN employees e
USING (officecode)
JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments p
USING (customernumber)
GROUP BY c.customerNumber
HAVING COUNT(p.amount) = 
	(
	SELECT COUNT(p.amount)
	FROM customers c
	JOIN payments p
	USING(customernumber)
	GROUP BY p.amount
	LIMIT 1
	);

-- NO. 2

SELECT CONCAT(e.firstName, ' ', e.lastName) AS 'Nama Employee', SUM(p.amount) AS Pendapatan
FROM employees e
JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments p
USING(customernumber)
GROUP BY e.employeeNumber
HAVING SUM(p.amount) = 
	(SELECT SUM(p.amount)
	FROM employees e
	JOIN customers c
	ON e.employeeNumber = c.salesRepEmployeeNumber
	JOIN payments p
	USING(customernumber)
	GROUP BY e.employeeNumber
	ORDER BY SUM(p.amount) DESC
	LIMIT 1) OR
SUM(p.amount) = 
	(SELECT SUM(p.amount)
	FROM employees e
	JOIN customers c
	ON e.employeeNumber = c.salesRepEmployeeNumber
	JOIN payments p
	USING(customernumber)
	GROUP BY e.employeeNumber
	ORDER BY sum(p.amount) ASC 
	LIMIT 1);

-- NO. 3

SELECT
   c.`Name` AS 'Negara',
   c.Population * cl.Percentage AS 'Pengguna Bahasa'
FROM country c
JOIN countrylanguage cl
ON c.Code = cl.CountryCode
WHERE cl.Language = 
	(SELECT cl.Language 
	FROM countrylanguage AS cl
	JOIN country c
	ON c.Code = cl.CountryCode
	WHERE c.Continent = "Asia"
	GROUP BY cl.Language
	ORDER BY COUNT(cl.Language) DESC 
	LIMIT 1
	)
ORDER BY `Pengguna Bahasa` DESC;
	
-- NO. 4
		
SELECT 
	c.customerName, 
	SUM(p.amount) AS 'Total Pembayaran',
	SUM(od.quantityOrdered) AS 'Banyak Barang',
	GROUP_CONCAT(pr.productName SEPARATOR ', ') AS 'Produk yang Dibeli'
FROM customers c
JOIN payments p
USING (customerNumber)
JOIN orders 
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products pr
USING (productCode)
GROUP BY c.customerName
HAVING SUM(p.amount) > (
	SELECT AVG(total)
	FROM (
		SELECT SUM(p.amount) AS total
		FROM customers c
		JOIN payments p
		USING (customerNumber)
		GROUP BY c.customerNumber) AS avg_total);
		
		
-- Soal Tambahan

# Tampilkan nama pelanggan yang pernah membeli produk dengan quantityOrdered tertinggi

SELECT DISTINCT customerName
FROM customers c
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
WHERE productCode =
	(SELECT p.productCode
	FROM products p
	GROUP BY productCode
	ORDER BY SUM(od.quantityOrdered) DESC
	LIMIT 1)
	