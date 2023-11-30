-- NOMOR 1
(SELECT c.customerName, p.ProductName, sum(od.quantityOrdered * od.priceEach) modal
FROM customers c
JOIN orders
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products p 
USING (productCode)
GROUP BY customerNumber
ORDER BY modal DESC
LIMIT 3)
UNION 
(SELECT c.customerName, p.ProductName, sum(od.quantityOrdered * od.priceEach) modal
FROM customers c
JOIN orders
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products p 
USING (productCode)
GROUP BY customerNumber
ORDER BY modal
LIMIT 3);


-- NOMOR 2
SELECT Kota FROM 
(SELECT COUNT(CONCAT(e.firstName, " ", e.lastName)) AS 'Nama Karyawan atau Pelanggan', o.city AS 'Kota'
FROM employees AS e
JOIN offices AS o
USING (officeCode)
WHERE e.firstName LIKE "L%"
UNION
SELECT customerName, city  FROM customers AS c
WHERE customerName LIKE "L%") AS a
GROUP BY Kota
ORDER BY COUNT('Nama Karyawan atau Pelanggan') DESC LIMIT 1;


-- NOMOR 3
SELECT CONCAT(e.firstName, " ", e.lastName) AS 'Nama karyawan/pelanggan', 'karyawan' AS "status"
FROM employees AS e
WHERE e.officeCode IN (SELECT e.officeCode 
							FROM employees AS e
							GROUP BY e.officeCode
							HAVING COUNT(*) = (SELECT COUNT(*)
                                                FROM employees
                                                GROUP BY officeCode
                                                ORDER BY COUNT(*) LIMIT 1))
UNION 
SELECT c.customerName, "pelanggan"
FROM customers AS c
WHERE customerNumber IN (SELECT c.customerNumber
								FROM customers AS c
								JOIN employees AS e
								ON c.salesRepEmployeeNumber = e.employeeNumber
								WHERE e.officeCode IN (SELECT e.officeCode 
															  FROM employees AS e
															  GROUP BY e.officeCode
															  HAVING COUNT(*) = (SELECT COUNT(*)
                                                FROM employees
                                                GROUP BY officeCode
                                                ORDER BY COUNT(*) LIMIT 1)))                              
ORDER BY `nama karyawan/pelanggan`;


-- NOMOR 4
SELECT tanggal, GROUP_CONCAT(riwayat SEPARATOR ' dan ') riwayat
FROM (SELECT o.orderDate AS tanggal, CONCAT('memesan barang') AS riwayat
FROM orders o
WHERE YEAR(o.orderDate) = 2003 AND MONTH(o.orderDate) = 4
UNION
SELECT p.paymentdate AS tanggal, CONCAT('membayar pesanan') AS riwayat
FROM payments AS p
WHERE YEAR(p.paymentDate) = 2003 AND MONTH(p.paymentDate) = 4) AS kombinasi
GROUP BY tanggal
ORDER BY tanggal;

