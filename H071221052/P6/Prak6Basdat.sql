-- No 1
SELECT CONCAT(e.firstName, " ", e.lastName) "nama employee",
GROUP_CONCAT(o.orderNumber) "Nomor Orderan",
COUNT(o.ordernumber) "jumlah pesanan"
FROM employees e
JOIN customers c 
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders o
ON c.customerNumber = o.customerNumber
GROUP BY e.employeeNumber
HAVING COUNT(o.ordernumber) > 10;


-- No 2
SELECT p.productCode, p.productName, p.quantityInStock, o.orderDate
FROM products AS p
JOIN orderdetails AS od
ON p.productCode = od.productCode
JOIN orders AS o
ON od.orderNumber = o.orderNumber
GROUP BY p.productName
HAVING(p.quantityInStock) > 5000 
ORDER BY o.orderDate 

-- No 3
SELECT o.addressLine1 "Alamat",
CONCAT(SUBSTRING(o.phone, 2,6), "* **") "Nomor Telp",
COUNT(DISTINCT e.employeeNumber) "Jumlah karyawan",
COUNT(DISTINCT c.customerNumber) "Jumlah pelanggan", 
AVG(p.amount) "Rata-rata Penghasilan"
FROM offices o
LEFT JOIN employees e
ON o.officeCode = e.officeCode
LEFT JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
LEFT JOIN payments p
ON c.customerNumber = p.customerNumber
GROUP BY o.addressLine1
ORDER BY o.phone;

SELECT * FROM i

-- No 4
SELECT c.customerName,
YEAR(o.orderDate) "tahun order",
MONTHNAME(o.orderDate) "bulan order",
COUNT(o.orderNumber) "jumlah pesanan",
SUM(od.priceEach * od.quantityOrdered) "uang total penjualan"
FROM customers c
JOIN orders o
ON c.customerNumber = o.customerNumber
JOIN orderdetails od
ON o.orderNumber = od.orderNumber
WHERE YEAR(o.orderDate) = 2003
GROUP BY c.customerName, MONTH(o.orderDate);

-- soal tambahan
-- 1
 SELECT c.customerName, SUM(p.amount) "Total Belanja", c.creditlimit "Batas Kredit", ABS(SUM(p.amount) - c.creditLimit) AS 'selisih'
 FROM customers c
 JOIN payments p
 USING (customerNumber)
 GROUP BY c.customerName
 HAVING SUM(p.amount) > c.creditLimit
 ORDER BY ABS(SUM(p.amount) - c.creditLimit) DESC
 
 -- 2
SELECT CONCAT(c.customerName,' : ', c.contactFirstName, c.contactLastName,'@', c.addressLine1) 'Pelanggan', SUM(od.quantityOrdered) 'Jumlah Orderan'
FROM customers c
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
GROUP BY c.customerName
ORDER BY SUM(od.quantityOrdered) DESC
LIMIT 1;
 
 -- 3
SELECT p.paymentDate, CONCAT((MONTHNAME(p.paymentdate))," ",(YEAR(p.paymentdate))) AS 'Hari Pembayaran',COUNT(DISTINCT c.customerNumber) AS JumlahPelanggan, GROUP_CONCAT(c.customerName ORDER BY c.customerName ) AS DaftarPelanggan, 
SUM(p.amount) AS JumlahPembayaran
FROM customers c
JOIN payments p ON c.customerNumber = p.customerNumber
WHERE MONTH(p.paymentDate) = 2
GROUP BY `Hari Pembayaran`
HAVING `Hari Pembayaran` LIKE 'Feb%'
ORDER BY `JumlahPembayaran` DESC;


SELECT payments.paymentDate, 
	CONCAT(MONTHNAME(payments.paymentDate), ' ', YEAR(payments.paymentDate)) AS 'Hari Pembayaran', 
	COUNT(DISTINCT customers.customerName),
	GROUP_CONCAT(DISTINCT customers.customerName SEPARATOR ';'), 
	SUM(payments.amount) AS 'Jumlah Pembayaran'
FROM customers
JOIN payments
ON payments.customerNumber = customers.customerNumber
GROUP BY `Hari Pembayaran`
HAVING `Hari Pembayaran` LIKE 'Feb%'
ORDER BY `Jumlah Pembayaran` DESC;

-- 4
SELECT UPPER (p.productName) "Nama Produk", COUNT(od.orderLineNumber) "jumlah di order",
SUM(od.quantityOrdered) "Total jumlah Orderan",
GROUP_CONCAT(o.orderDate SEPARATOR ', ') "Waktu Order", p.buyprice "Harga beli", od.priceEach "Harga Jual",
CONCAT(od.priceEach * (SUM(od.quantityOrdered)), " - ", p.buyPrice * (SUM(od.quantityOrdered)), " = ",
od.priceEach * (SUM(od.quantityOrdered)) - p.buyPrice * (SUM(od.quantityOrdered))) AS keuntungan
FROM orders o
JOIN orderdetails od
USING (orderNumber)
JOIN products p
USING (productCode)
WHERE p.productName = "2001 Ferrari Enzo"
GROUP BY od.priceEach
HAVING (od.priceEach * (SUM(od.quantityOrdered)) - p.buyPrice * (SUM(od.quantityOrdered))) > 5000
ORDER BY (od.priceEach * (SUM(od.quantityOrdered)) - p.buyPrice * (SUM(od.quantityOrdered))) DESC;
