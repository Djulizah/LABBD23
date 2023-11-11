-- NO. 1

(SELECT 
	c.customerName,
	pr.productName,
	pr.buyPrice * SUM(od.quantityOrdered) AS Modal
FROM customers c
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products pr
USING (productCode)
GROUP BY c.customerName
ORDER BY Modal DESC 
LIMIT 3)
UNION 
(SELECT 
	c.customerName,
	pr.productName,
	pr.buyPrice * SUM(od.quantityOrdered) AS Modal
FROM customers c
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products pr
USING (productCode)
GROUP BY c.customerName
ORDER BY Modal ASC 
LIMIT 3);

-- NO. 2

SELECT 
	city AS Total
FROM ( 
	SELECT o.city
	FROM employees e
	JOIN offices o
	USING (officeCode)
	WHERE firstName LIKE 'L%'
	UNION ALL 
	SELECT c.city
	FROM customers c
	WHERE customerName LIKE 'L%') AS a
GROUP BY city
ORDER BY COUNT(*) DESC 
LIMIT 1;
	
-- NO. 3

SELECT CONCAT(e.firstName, ' ', e.lastName) AS 'Nama Karyawan/Pelanggan', 'Karyawan' AS 'Status'
FROM employees e
WHERE officeCode IN (
	SELECT officeCode 
	FROM employees
	GROUP BY officeCode
	HAVING COUNT(*) = (
		SELECT COUNT(officeCode) AS 'Jumlah Karyawan'
		FROM employees
		GROUP BY officeCode
		ORDER BY `Jumlah Karyawan`
		LIMIT 1
	)
)
UNION 
SELECT c.customerName, 'Pelanggan'
FROM customers c
JOIN employees e
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE e.officeCode IN (
	SELECT officeCode
	FROM employees 
	GROUP BY officeCode
	HAVING COUNT(*) = (
		SELECT COUNT(officeCode) AS 'Jumlah Karyawan'
		FROM employees
		GROUP BY officeCode
		ORDER BY `Jumlah Karyawan`
		LIMIT 1
	)
)
ORDER BY `Nama Karyawan/Pelanggan`;

-- NO. 4

SELECT tanggal, GROUP_CONCAT(riwayat SEPARATOR 'dan') AS riwayat
FROM (
	SELECT paymentDate AS tanggal, 'membayar pesanan' AS riwayat
	FROM payments
	WHERE MONTH(paymentDate) = 4 AND YEAR(paymentDate) = 2003
	UNION 
	SELECT orderDate AS tanggal, 'memesan barang' AS riwayat
	FROM orders
	WHERE MONTH(orderDate) = 4 AND YEAR(orderDate) = 2003
	) AS dataCustomers
GROUP BY tanggal
ORDER BY tanggal


-- Soal Tambahan

# Tampilkan customer yang melakukan pembayaran paling banyak dan
# employee yang melayani paling banyak pelanggan

(SELECT customerName AS 'Customer/Employee Name', CONCAT('Melakukan pembayaran = ', COUNT(*)) AS Jumlah
FROM customers
JOIN payments
USING (customerNumber)
GROUP BY customerName
ORDER BY COUNT(*) DESC 
LIMIT 1)
UNION 
(SELECT CONCAT(e.firstName, ' ', e.lastName), CONCAT('Melayani pelanggan = ', COUNT(*))
FROM employees e
JOIN customers c
ON c.salesRepEmployeeNumber = e.employeeNumber
GROUP BY CONCAT(e.firstName, ' ', e.lastName)
ORDER BY COUNT(*) DESC 
LIMIT 1)

