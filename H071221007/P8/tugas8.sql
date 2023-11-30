------------- Tugas 8 --------------

 
 -- NO 1
(SELECT c.customerName, GROUP_CONCAT(p.productName SEPARATOR ", "), p.buyPrice * SUM(od.quantityOrdered) modal FROM customers c
	JOIN orders o 
	USING(customerNumber)
	JOIN orderdetails od
	USING(orderNumber)
	JOIN products p
	USING(productCode) 
	GROUP BY c.customerName
	ORDER BY modal DESC
	LIMIT 3) 
UNION
(SELECT c.customerName, GROUP_CONCAT(p.productName SEPARATOR ", "), p.buyPrice * SUM(od.quantityOrdered) modal FROM customers c
	JOIN orders o 
	USING(customerNumber)
	JOIN orderdetails od
	USING(orderNumber)
	JOIN products p
	USING(productCode) 
	GROUP BY c.customerName
	ORDER BY modal
	LIMIT 3);


-- NO 2
SELECT city
FROM (
   SELECT o.city
	FROM employees e
	JOIN offices o USING(officeCode)
	WHERE firstName LIKE 'L%'
	UNION ALL
	SELECT c.city
	FROM customers c
	WHERE c.customerName LIKE 'L%'
	) AS a
GROUP BY city
ORDER BY COUNT(*) DESC
LIMIT 1;


-- No 3
(SELECT c.customerName AS 'Nama Karyawan/Pelanggan', 'Pelanggan' AS 'status'
FROM customers c
JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE e.officeCode IN 
		(SELECT officeCode FROM employees
		GROUP BY officeCode 
		HAVING COUNT(employeeNumber) = (
				SELECT COUNT(employeeNumber) FROM employees
				GROUP BY (officeCode) 
				ORDER BY COUNT(employeeNumber) 
				LIMIT 1)))
UNION
(SELECT CONCAT(firstName, ' ', lastName), 'Karyawan'
FROM employees e
WHERE e.officeCode IN 
		(SELECT officeCode FROM employees
		GROUP BY officeCode 
		HAVING COUNT(employeeNumber) = ( SELECT COUNT(employeeNumber) FROM employees
				GROUP BY (officeCode) 
				ORDER BY COUNT(employeeNumber) 
				LIMIT 1)))
ORDER BY `Nama Karyawan/Pelanggan`;


-- NO 4
(SELECT orderDate AS 'tanggal', 'membayar pesanan dan memesan barang' AS 'riwayat' 
	FROM payments
	JOIN orders ON orderDate = paymentDate
	WHERE orderDate LIKE '2003-04-__')	
UNION
(SELECT orderDate , 'memesan barang' FROM orders
	WHERE orderDate LIKE '2003-04-__' AND orderDate NOT IN 
		(SELECT orderDate FROM payments
		JOIN orders ON orderDate = paymentDate
		WHERE orderDate LIKE '2003-04-__'))
UNION
(SELECT paymentDate , 'membayar pesanan' FROM payments
WHERE paymentDate LIKE '2003-04-__'  AND paymentDate NOT IN 
		(SELECT orderDate FROM payments
	   JOIN orders ON orderDate = paymentDate
	   WHERE orderDate LIKE '2003-04-__'))
ORDER BY `tanggal`;



-- Soal Tambahan NO 8
-- Tampilkan quantity order tertinggi dan terendah per pesanan 
-- (bukan per customer) dan tampilkan pula produk apa yang dipesan

SELECT 'tertinggi' AS 'status',MAX(od.quantityOrdered) jumlah, p.productName FROM orderdetails od 
JOIN products p USING (productCode)
UNION
SELECT 'terendah', MIN(od.quantityOrdered) jumlah, p.productName FROM orderdetails od 
JOIN products p USING (productCode)
