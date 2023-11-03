-- no1
(SELECT c.customername, pro.productname, (pro.buyprice * SUM(od.quantityordered)) AS 'Modal'
FROM customers c
JOIN orders USING(customernumber)
JOIN orderdetails od USING(ordernumber)
JOIN products pro USING(productcode) 
GROUP BY c.customerName
ORDER BY `modal` DESC
LIMIT 3)
UNION 
(SELECT c.customername, pro.productname, (pro.buyprice * SUM(od.quantityordered)) 
FROM customers c
JOIN orders USING(customernumber)
JOIN orderdetails od USING(ordernumber)
JOIN products pro USING(productcode) 
GROUP BY c.customerName
ORDER BY (pro.buyprice * SUM(od.quantityordered)) 
LIMIT 3);


-- no2
SELECT `kota` FROM (
	#karyawan dan kotanya yg namanya dri L
	SELECT CONCAT(e.firstName, " ", e.lastName) AS 'Nama Karyawan/Pelanggan', ofc.city AS 'kota' FROM employees e
	JOIN offices ofc USING(officecode)
	WHERE CONCAT(e.firstName, " ", e.lastName) LIKE 'L%'
	UNION 
	#pelanggan dan kotanya yg namanya dri L
	SELECT c.customername, c.city FROM customers c
	WHERE c.customername LIKE 'L%'
	) AS a
#grupkan brdsrkn kota jdi gaada kota yg dobel
GROUP BY `kota`
#urutkan brdsrkn banyaknya karyawan/pelanggan di kota tsb
ORDER BY COUNT(`Nama Karyawan/Pelanggan`) DESC 
LIMIT 1


-- no3
#tampilkan nama karyawan di officecode tsb
SELECT CONCAT(e.firstname, " ", e.lastname) AS 'Nama Karyawan/Pelanggan', 'karyawan' AS 'Status'
FROM employees e
WHERE officecode IN (
	#cari officecode brp yg jumlah karyawannya paling sedikit
	SELECT officecode
	FROM employees 
	GROUP BY officecode
	HAVING COUNT(*) = (
		#hitung jumlah karyawan di masing2 officecode, cari yg jumlahnya paling sedikit
		SELECT COUNT(officecode) AS 'jumlah karyawan'
		FROM employees 
		GROUP BY officecode
		ORDER BY `jumlah karyawan`
		LIMIT 1
	)
)
UNION 
#cari pelanggan yg dilayani karyawan dri kantor dgn jumlah karyawan paling sedikit
SELECT customername, 'pelanggan', e.officecode
FROM customers c
JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE e.officecode IN (
	SELECT officecode
	FROM employees 
	GROUP BY officecode
	HAVING COUNT(*) = (
		SELECT COUNT(officecode) AS 'jumlah karyawan'
		FROM employees 
		GROUP BY officecode
		ORDER BY `jumlah karyawan`
		LIMIT 1
	)
)


-- no4
-- subquery
(SELECT paymentdate, 'membayar pesanan' AS riwayat
FROM payments
WHERE paymentdate LIKE '%2003-04%'
GROUP BY paymentdate
ORDER BY paymentdate)
UNION 
(SELECT orderdate, 'memesan barang' AS riwayat
FROM orders
WHERE orderdate LIKE '%2003-04%'
ORDER BY orderdate)

#full
SELECT `tanggal`, GROUP_CONCAT(`riwayat` SEPARATOR ' dan ') AS 'riwayat'
FROM (
	(SELECT paymentdate AS 'tanggal', 'membayar pesanan' AS riwayat
	FROM payments
	WHERE paymentdate LIKE '%2003-04%'
	GROUP BY paymentdate
	ORDER BY paymentdate)
	UNION 
	(SELECT orderdate AS 'tanggal', 'memesan barang' AS riwayat
	FROM orders
	WHERE orderdate LIKE '%2003-04%'
	ORDER BY orderdate)
	) AS a
GROUP BY `tanggal`


-- no5
(SELECT customername AS 'Nama Karyawan/Pelanggan', LENGTH(customername) AS 'panjang karakter', 'customer' AS 'status'
FROM customers 
ORDER BY `panjang karakter` DESC 
LIMIT 2)
UNION 
(SELECT CONCAT(firstname, " ", lastname), LENGTH(CONCAT(firstname, " ", lastname)), 'employee'
FROM employees
ORDER BY LENGTH(CONCAT(firstname, " ", lastname)) DESC
LIMIT 2)		