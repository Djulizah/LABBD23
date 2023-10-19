USE classicmodels

-- no1
SELECT CONCAT(firstname, " ", lastname) AS 'Nama_Employee', 
	GROUP_CONCAT(o.orderNumber) AS 'Nomor_Orderan', 
	COUNT(o.customerNumber) AS 'Jumlah_Pesanan'
FROM employees e
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders o USING (customerNumber) 
GROUP BY e.employeeNumber
HAVING COUNT(o.customerNumber) > 10

-- no2 
SELECT pro.productCode, pro.productName, pro.quantityInStock, o.orderDate 
FROM products pro
JOIN orderdetails USING (productCode)
JOIN orders o USING (orderNumber)
GROUP BY pro.productCode
HAVING pro.quantityInStock > 5000
ORDER BY o.orderDate 

-- no3 jmlh karyawan sm jmlh pelanggan nambah terus
SELECT * FROM employees
SELECT * FROM offices
SELECT * FROM customers
SELECT ofc.addressLine1 AS 'Alamat', 
	CONCAT(LEFT(ofc.phone, 6), '* **') AS 'Nomor_Telepon', 
	COUNT(DISTINCT e.employeeNumber) AS 'Jumlah_Karyawan', 
	COUNT(DISTINCT c.customerName) AS 'Jumlah_Pelanggan', 
	ROUND(AVG(pay.amount), 2) AS 'RataRata_Penghasilan'
FROM offices ofc
JOIN employees e USING(officeCode)
LEFT JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
LEFT JOIN payments pay USING(customerNumber)
GROUP by ofc.officeCode
ORDER BY ofc.phone

-- no4
SELECT c.customerName, 
	YEAR(o.orderDate) AS 'Tahun_Order',
	MONTHNAME(o.orderDate) AS 'Bulan_Order', 
	COUNT(od.orderNumber) AS 'Jumlah_Pesanan', 
	SUM(od.priceEach * od.quantityOrdered) AS 'Uang_Total_Penjualan'
FROM customers c
JOIN orders o USING(customerNumber)
JOIN orderdetails od USING(orderNumber)
WHERE YEAR(o.orderDate) LIKE '%2003%'
GROUP BY c.customerName, MONTH(o.orderDate)

-- no5 
SELECT CONCAT(c.customerName, " : ", c.contactFirstName, "", c.contactLastName, " @", addressLine1) AS 'Pelanggan', 
	SUM(od.quantityOrdered) AS 'Jumlah_Orderan'
FROM customers c
JOIN orders USING(customerNumber)
JOIN orderdetails od USING(orderNumber)
GROUP BY customerName
ORDER BY SUM(od.quantityOrdered) DESC 
LIMIT 1
SELECT * FROM orderdetails

-- tambahan no4
SELECT UPPER(pro.productName) AS 'Nama Produk', 
	COUNT(od.orderLineNumber) AS 'Jumlah di Order', 
	GROUP_CONCAT(o.orderDate SEPARATOR ", ") AS 'Waktu Order', 
	pro.buyPrice AS 'Harga Beli',
	od.priceEach AS 'Harga Jual',
	SUM(od.quantityOrdered) AS 'Total Jumlah Orderan',
	CONCAT(
	((SUM(od.quantityOrdered) * od.priceEach)), '-',
	(pro.buyPrice * (SUM(od.quantityOrdered))), '=',
	(((SUM(od.quantityOrdered) * od.priceEach)) - (pro.buyPrice * (SUM(od.quantityOrdered))))
	) AS 'pendapatan - modal = keuntungan'
FROM products pro
JOIN orderDetails od USING(productCode)
JOIN orders o USING(orderNumber)
WHERE pro.productName = '2001 ferrari enzo' 
GROUP BY od.priceEach
HAVING (((SUM(od.quantityOrdered) * od.priceEach)) - (pro.buyPrice * (SUM(od.quantityOrdered)))) > 5000
ORDER BY (((SUM(od.quantityOrdered) * od.priceEach)) - (pro.buyPrice * (SUM(od.quantityOrdered)))) DESC 
