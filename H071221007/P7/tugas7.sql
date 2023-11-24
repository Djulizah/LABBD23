-- NO 1-- 
SELECT DISTINCT o.addressline1, 
		o.addressLine2, 
		o.city, 
		o.country 
FROM employees e
JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN offices o
USING(officeCode)
WHERE c.customerNumber IN (
		SELECT customerNumber FROM payments
		GROUP BY customernumber
		HAVING COUNT(*) = 
			(SELECT COUNT(*) FROM payments
			GROUP BY customernumber
			ORDER BY COUNT(*)
			LIMIT 1));


-- No2
SELECT CONCAT(e.firstName, ' ', e.lastName) 'nama employee', 
		SUM(p.amount) pendapatan
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



-- No 3	
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
ORDER BY `pengguna bahasa` DESC;



-- No 4
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
ORDER BY `banyak barang` DESC; 



#Tampilkan semua produk yang pernah dibeli oleh customer dengan 
-- creditLimit antara 1 – 50000
SELECT DISTINCT(c.customerName), group_concat(p.productName SEPARATOR ", "), c.creditLimit
FROM customers c
JOIN orders o
USING(customerNumber)
JOIN orderdetails od
USING(ordernumber)
JOIN products p
USING(productCode)
GROUP BY c.customerName
HAVING 
(c.creditLimit < 50000) AND (c.creditLimit > 1);