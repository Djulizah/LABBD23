-- NO. 1

SELECT 
	CONCAT(e.firstname, ' ', e.lastname) AS 'Nama Employee', 
	GROUP_CONCAT(o.orderNumber) AS 'Nama Orderan', 
	COUNT(o.orderNumber) AS 'Jumlah Orderan'
FROM employees e
JOIN customers c
ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN orders o
ON o.customerNumber = c.customerNumber
GROUP BY CONCAT(e.employeeNumber)
HAVING COUNT(c.customerNumber) > 10

-- NO. 2

SELECT p.productCode, p.productName, p.quantityInStock, o.orderDate
FROM products p
JOIN orderdetails od
ON od.productCode = p.productCode
JOIN orders o
ON o.orderNumber = od.orderNumber
GROUP BY p.productName
HAVING p.quantityInStock > 5000
ORDER BY orderDate ASC 

-- NO. 3

SELECT
   LEFT(o.addressLine1, CHAR_LENGTH(o.addressLine1) - 5) AS Alamat_Pertama,
   CONCAT(LEFT(o.phone,6), '* **') AS No_Telp,
   COUNT(DISTINCT e.employeeNumber) AS Jumlah_Karyawan,
   COUNT(DISTINCT c.customerNumber) AS Jumlah_Pelanggan,
   FORMAT(AVG(p.amount), 2) AS Rata_Rata_Penghasilan
FROM offices o
LEFT JOIN employees e
ON o.officeCode = e.officeCode
LEFT JOIN customers c 
ON e.employeeNumber = c.salesRepEmployeeNumber
LEFT JOIN payments p USING (customerNumber)
GROUP BY o.officeCode
ORDER BY No_Telp

-- NO. 4

SELECT
    c.customerName AS CustomerName,
    YEAR(o.orderDate ) AS TahunOrder,
    MONTHNAME(o.orderDate) AS BulanOrder,
    COUNT(o.orderNumber) AS JumlahPesanan,
    SUM(od.priceEach * od.quantityOrdered) AS UangTotalPenjualan
FROM customers c
JOIN orders o 
ON o.customerNumber = c.customerNumber
JOIN orderdetails od 
ON od.orderNumber = o.orderNumber
WHERE YEAR(o.orderDate) = 2003
GROUP BY CustomerName, BulanOrder

-- Soal Tambahan

-- Tampilkan jumlah dan list pelanggan, serta jumlah pembayaran untuk pembayaran yang dilakukan pada bulan februari setiap tahunnya.

SELECT p.paymentDate, 
	CONCAT(MONTHNAME(p.paymentDate), ' ', YEAR(p.paymentDate)) AS hari_pembayaran,
	COUNT(DISTINCT c.customerNumber) AS jumlah_customer, 
	GROUP_CONCAT(c.customerName) AS list_customer,
	SUM(p.amount) AS Jumlah_pembayaran
FROM payments p 
JOIN customers c
ON c.customerNumber = p.customerNumber
GROUP BY `hari_pembayaran`
HAVING `hari_pembayaran` LIKE 'February%'
ORDER BY p.amount DESC 