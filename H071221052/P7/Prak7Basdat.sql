USE classicmodels;

# NO 1
SELECT DISTINCT o.addressLine1,
       o.addressLine2,
       o.city AS 'kota',
       o.country AS 'negara',
       c.customerNumber,
       COUNT(p.amount) AS 'jumlah pembayaran'
FROM employees e
JOIN customers c 
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN offices o 
USING (officeCode)
JOIN payments p 
ON c.customerNumber = p.customerNumber
GROUP BY c.customerNumber
HAVING COUNT(*) = (
        SELECT COUNT(*)
        FROM payments
        GROUP BY customerNumber
        ORDER BY COUNT(*)
        LIMIT 1 )
        
#tanpa distinict			
SELECT o.addressLine1,
       o.addressLine2,
       o.city AS 'kota',
       o.country AS 'negara',
       c.customerNumber,
       COUNT(p.amount) AS 'jumlah pembayaran'
FROM employees e
JOIN customers c 
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN offices o 
USING (officeCode)
JOIN payments p 
ON c.customerNumber = p.customerNumber
GROUP BY c.customerNumber
HAVING COUNT(*) = (
        SELECT COUNT(*)
        FROM payments
        GROUP BY customerNumber
        ORDER BY COUNT(*)
        LIMIT 1 )

# No 2
SELECT CONCAT(e.firstName, ' ', e.lastName) 'nama employee', 
		SUM(p.amount) 'pendapatan'
FROM employees e
JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments p
USING (customernumber)
GROUP BY e.employeeNumber
HAVING SUM(p.amount) = 
		(SELECT SUM(p.amount) FROM payments p
		JOIN customers c
		USING (customernumber)
		JOIN employees e
		ON e.employeeNumber = c.salesRepEmployeeNumber
		GROUP BY e.employeeNumber
		ORDER BY SUM(p.amount) DESC
		LIMIT 1)
OR SUM(p.amount) = 
		(SELECT SUM(p.amount) FROM payments p
		JOIN customers c
		USING (customernumber)
		JOIN employees e
		ON e.employeeNumber = c.salesRepEmployeeNumber
		GROUP BY e.employeeNumber
		ORDER BY SUM(p.amount)
		LIMIT 1);

# No 3
USE world;

SELECT
    c.`Name` 'Negara',
    (c.Population * cl.Percentage) 'Pengguna Bahasa'
FROM country c
JOIN countrylanguage cl
ON c.`Code` = cl.CountryCode
WHERE cl.`language` = 
		(SELECT countrylanguage.`language`
		FROM countrylanguage
		JOIN country
		ON country.`Code` = countrylanguage.CountryCode
		WHERE country.Continent = 'Asia'
		GROUP BY countrylanguage.`language`
		ORDER BY COUNT(countrylanguage.`language`) DESC
		LIMIT 1)
ORDER BY (c.Population * cl.Percentage);

# No 4
USE classicmodels;

SELECT c.customerName, 
		SUM(p.amount) AS 'Total pembayaran', 
		SUM(od.quantityOrdered) 'banyak barang', 
		GROUP_CONCAT(pr.productName SEPARATOR '; ')'produk yang dibeli'
FROM payments p
JOIN customers c
USING (customerNumber)
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products pr
USING (productcode)
GROUP BY customerNumber
HAVING SUM(p.amount) > 
		(SELECT AVG(jumlah)
		FROM (
			SELECT SUM(amount) 'jumlah'
			FROM payments
			GROUP BY customernumber) AS a)
ORDER BY SUM(p.amount) desc; 


-- soal tambahan
-- 1

SELECT distinct customerName FROM customers
JOIN orders
USING(customerNumber)
JOIN orderdetails
USING(orderNumber)
JOIN products
USING(productCode)
WHERE productCode = (SELECT productCode FROM products
ORDER BY quantityInStock
LIMIT 1 ) 








