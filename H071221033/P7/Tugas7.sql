USE classicmodels

-- no1
#subquery1
SELECT c.customername, COUNT(pay.amount)
FROM customers c
JOIN payments pay USING(customernumber)
GROUP BY c.customerName
ORDER BY COUNT(pay.amount)
LIMIT 1
#full
SELECT ofc.addressLine1, ofc.addressLine2, ofc.city, ofc.country 
FROM offices ofc
JOIN employees e USING(officecode)
JOIN customers c on c.salesRepEmployeeNumber = e.employeeNumber
JOIN payments pay USING(customernumber)
GROUP BY c.customername
HAVING COUNT(pay.amount) = (
	SELECT COUNT(pay.amount)
	FROM customers c
	JOIN payments pay USING(customernumber)
	GROUP BY c.customerName
	ORDER BY COUNT(pay.amount)
	LIMIT 1)


-- no2 
#subquery2
SELECT CONCAT(e.firstname, " ", e.lastname) AS 'nama employee', SUM(pay.amount)
FROM employees e
JOIN customers c ON e.employeeNumber = c.salesrepemployeenumber
JOIN payments pay USING(customernumber)
GROUP BY e.employeenumber
ORDER BY SUM(pay.amount) 
LIMIT 1 
#full
SELECT CONCAT(e.firstname, " ", e.lastname) AS 'nama employee', SUM(pay.amount) AS 'pendapatan'
FROM employees e
JOIN customers c ON e.employeeNumber = c.salesrepemployeenumber
JOIN payments pay USING(customernumber)
WHERE e.employeenumber IN (
	-- pendapatan terkecil
	(SELECT e.employeenumber
	FROM employees e
	JOIN customers c ON e.employeeNumber = c.salesrepemployeenumber
	JOIN payments pay USING(customernumber)
	GROUP BY e.employeenumber
	ORDER BY SUM(pay.amount) 
	LIMIT 1), 
	-- pendapatan terbesar
	(SELECT e.employeenumber
	FROM employees e
	JOIN customers c ON e.employeeNumber = c.salesrepemployeenumber
	JOIN payments pay USING(customernumber)
	GROUP BY e.employeenumber
	ORDER BY SUM(pay.amount) DESC 
	LIMIT 1)
	)
	GROUP BY e.employeenumber
	

-- no3 
#subquery3
SELECT cl.`language`, COUNT(`language`) 
FROM countrylanguage cl
JOIN country ct ON cl.CountryCode = ct.`code`
WHERE ct.continent = 'asia'
GROUP BY `language` 
ORDER BY COUNT(`language`) DESC 
LIMIT 1
#full
SELECT ct.`name`, (ct.population * cl.Percentage) AS 'banyak pengguna'
FROM country ct
JOIN countrylanguage cl ON ct.`Code` = cl.CountryCode
WHERE cl.`Language` = 
	(SELECT cl.`language` FROM countrylanguage cl
	JOIN country ct ON cl.CountryCode = ct.`code`
	WHERE ct.continent = 'asia'
	GROUP BY `language` 
	ORDER BY COUNT(`language`) DESC 
	LIMIT 1)
ORDER BY `banyak pengguna` DESC 


-- no4
SELECT c.customerName, SUM(pay.amount) AS 'total pembayaran', SUM(od.quantityordered) AS 'total barang', GROUP_CONCAT(pro.productname)
FROM customers c
JOIN payments pay USING(customernumber)
JOIN orders o USING(customernumber)
JOIN orderdetails od USING(ordernumber)
JOIN products pro USING(productcode)
GROUP BY c.customername
HAVING SUM(pay.amount) > 
	(SELECT ROUND(AVG(jumlah), 2) AS 'avg' 
	FROM (SELECT SUM(amount) AS 'jumlah' 
	FROM payments 
	GROUP BY customernumber) AS jum)
ORDER BY `total pembayaran` DESC 


-- no5 12
#subquery5
SELECT c.customername, CONCAT(e.firstname, " ", e.lastname) AS 'karyawan', SUM(pay.amount) AS total_pembayaran
FROM customers c
JOIN employees e ON c.salesrepemployeenumber = e.employeenumber 
JOIN payments pay USING(customernumber)
GROUP BY c.customername
ORDER BY `total_pembayaran`
LIMIT 1
#full
SELECT ofc.officecode, ofc.addressline1, ofc.country
FROM offices ofc
JOIN employees e USING(officecode)
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments pay USING(customernumber)
GROUP BY c.customername
HAVING SUM(pay.amount) = 
	(SELECT SUM(amount) AS total_pembayaran
	FROM payments
	JOIN customers c USING(customernumber) 
	GROUP BY c.customername
	ORDER BY `total_pembayaran`
	LIMIT 1)