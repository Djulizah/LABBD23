-- Nomor 1
SELECT CONCAT(e.firstName, " ", e.lastName) AS "Nama Employee", GROUP_CONCAT(o.orderNumber) AS "Nomor Orderan", COUNT(o.customerNumber) AS "Jumlah pesanan"
FROM employees AS e
JOIN customers AS c
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders AS o
USING (customerNumber)
GROUP BY employeeNumber 
HAVING COUNT(o.customerNumber) > 10


-- Nomor 2
FROM products AS p
JOIN orderdetails AS od
USING (productCode)
JOIN orders AS o
USING (orderNumber)
GROUP BY productCode
HAVING (quantityInStock) > 5000
ORDER BY orderDate


-- Nomor 3
SELECT DISTINCT o.addressLine1 "Alamat", CONCAT(SUBSTRING(o.phone, 1, LENGTH(o.phone) - 9), "* **") "Nomor Telp",  COUNT(DISTINCT e.employeeNumber) "Jumlah Karyawan", 
COUNT(DISTINCT c.customerNumber) "Jumlah Pelanggan", FORMAT(AVG(amount), 2) "Rata-rata Penghasilan" FROM offices o
JOIN employees e 
USING (officeCode)
LEFT JOIN customers c 
ON (c.salesRepEmployeeNumber = e.employeeNumber)
LEFT JOIN payments p 
USING (customerNumber)
GROUP BY o.addressLine1 
ORDER BY o.phone


-- Nomor 4
SELECT c.customerName , YEAR(o.orderDate) AS "tahun order" , MONTHNAME(o.orderDate) AS "bulan order" , 
COUNT(o.orderNumber) AS "jumlah pesanan" , SUM(od.quantityOrdered * od.priceEach) AS "uang total penjualan"
FROM customers AS c
JOIN orders AS o
USING (customerNumber)
JOIN orderdetails AS od 
USING (orderNumber)
WHERE YEAR(o.orderDate) = 2003
GROUP BY c.customerNumber, MONTHNAME(o.orderDate)
ORDER BY customerName 



#Tugas Tambahan 
-- tampilkan nama pelanggan yang total belanjanya melebihi kredit limit,
-- tampilkan selisih /total belanja/ dengan kreditlimit,
-- urutkan berdasarkan selisih tersebut secara menurun.
SELECT c.customerName, c.creditLimit, SUM(o.amount) AS 'total belanja', (SUM(o.amount) - c.creditLimit) AS 'selisih belanja'
FROM customers AS c
JOIN payments AS o
USING (customerNumber)
GROUP BY c.customerNumber
HAVING SUM(o.amount) > c.creditLimit
ORDER BY `selisih belanja` DESC;
