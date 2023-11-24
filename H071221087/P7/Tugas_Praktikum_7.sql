-- Nomor 1
SELECT o.addressLine1, o.addressLine2, o.city, o.country
FROM offices AS o
JOIN employees AS e
USING (officeCode)
JOIN customers AS c
ON e.employeeNumber = c.salesRepEmployeeNumber
WHERE customerNumber IN (SELECT customerNumber
								 FROM payments
								 GROUP BY customerNumber
								 HAVING COUNT(*) = (SELECT COUNT(*)
														  FROM payments
														  GROUP BY customerNumber
														  ORDER BY COUNT(*)
														  LIMIT 1)
);


-- Nomor 2
SELECT CONCAT(e.firstName, ' ', e.lastName) AS Karyawan, SUM(p.amount) AS Pendapatan, e.employeeNumber
FROM employees AS e
JOIN customers AS c 
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments AS p 
USING (customerNumber)
WHERE e.employeeNumber IN (
						(SELECT e.employeeNumber FROM employees AS e 
						JOIN customers AS c 
						ON e.employeeNumber = c.salesRepEmployeeNumber 
						JOIN payments AS p 
						USING (customerNumber) 
						GROUP BY e.employeeNumber ORDER BY SUM(p.amount) DESC LIMIT 1), 
						
						(SELECT e.employeeNumber FROM employees AS e 
						JOIN customers AS c 
						ON e.employeeNumber = c.salesRepEmployeeNumber 
						JOIN payments AS p 
						USING (customerNumber) 
						GROUP BY e.employeeNumber ORDER BY SUM(p.amount) LIMIT 1))
GROUP BY e.employeeNumber;


-- Nomor 3
USE world;
SELECT c.name negara, ((cl.Percentage / 100) * c.Population) 'Pengguna bahasa'
FROM country AS c
JOIN countrylanguage AS cl
ON c.Code = cl.CountryCode 
WHERE LANGUAGE = (SELECT cl.LANGUAGE 
					FROM countrylanguage cl
					JOIN country c
					ON c.Code = cl.CountryCode 
					WHERE Continent = 'asia'
					GROUP BY LANGUAGE
					ORDER BY COUNT(*) DESC 
					LIMIT 1)
ORDER BY `Pengguna bahasa`;


-- Nomor 4
SELECT c.customerName, SUM(amount) AS 'Total pembayaran' , SUM(od.quantityOrdered) AS 'banyak barang' , GROUP_CONCAT(p.productName SEPARATOR ', ') AS 'produk yang dibeli'
FROM customers AS c
JOIN orders AS o 
USING (customerNumber)
JOIN orderdetails AS od 
USING (orderNumber)
JOIN products AS p 
USING (productCode)
JOIN payments 
USING (customerNumber)
GROUP BY c.customerNumber
HAVING SUM(amount) > (SELECT AVG(TotalPaymentCustomer)
							 FROM (select SUM(amount) TotalPaymentCustomer
								    FROM payments
								    GROUP BY customerNumber) totalPurchased);



#Tugas Tambahan
-- Tampilkan pelanggan yang dilayani oleh karyawan yang bekerja di 
-- kantor yang terletak di negara yang diawali dan diakhiri dengan huruf vocal
SELECT c.customerName, CONCAT(e.firstName, ' ', e.lastName) AS employeeName, o.country
FROM customers c
JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN offices o ON e.officeCode = o.officeCode
WHERE SUBSTRING(o.country, 1, 1) IN ('A', 'E', 'I', 'O', 'U')
AND SUBSTRING(o.country, -1, 1) IN ('A', 'E', 'I', 'O', 'U');
