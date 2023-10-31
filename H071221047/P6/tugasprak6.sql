USE classicmodels;


-- 1

SELECT CONCAT(e.firstName, ' ', e.lastName) AS 'Nama employee',
GROUP_CONCAT(o.orderNumber, '; ') AS 'Nomor orderan',
COUNT(o.orderNumber) AS 'Jumlah Pesanan'
FROM employees e
JOIN customers c
ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN orders o
USING (customerNumber)
GROUP BY e.employeeNumber;

-- 2

SELECT p.productCode, p.productName, p.quantityInStock, MIN(o.orderDate)
FROM products p
JOIN orderdetails od
USING(productCode)
JOIN orders o
USING(orderNumber)
GROUP BY p.productName
HAVING p.quantityInStock > 5000
ORDER BY o.orderDate;

-- 3

SELECT o.addressline1 AS 'Alamat', 
CONCAT(LEFT(o.phone, LENGTH(o.phone) - 5), '* **') AS 'Nomor Telp',
COUNT(DISTINCT e.employeeNumber) AS 'jumlah karyawan',
COUNT(DISTINCT  c.customerNumber) AS 'jumlah pelanggan',
FORMAT(AVG(p.amount),2) AS 'rata-rata penghasilan'
FROM offices o
LEFT JOIN employees e 
USING(officeCode)
LEFT JOIN customers c 
ON e.employeeNumber = c.salesRepEmployeeNumber
LEFT JOIN payments p 
USING(customerNumber)
GROUP BY o.addressLine1 
ORDER BY o.phone;

-- 4

SELECT  c.customerName, YEAR(o.orderDate) AS 'Tahun order', MONTHNAME(o.orderDate) AS 'Bulan order',
COUNT(od.quantityOrdered) 'jumlah pesanan', SUM(od.priceEach *  od.quantityOrdered) AS 'Uang total penjualan'
FROM customers c
JOIN orders o
USING (customerNumber)
JOIN orderdetails od 
USING (orderNumber)
JOIN products p
USING (productCode)
WHERE YEAR(o.orderDate) = 2003
GROUP BY c.customerName, MONTH(o.orderDate);

#count = hitung jumlah baris nya
#sum = menjumlahkan semua nilai nya



#soal tambahan 
SELECT CONCAT(customers.customerName, ' : ', customers.contactFirstName,' ', customers.contactLastName, '@', customers.addressLine1) AS 'Pelanggan', 
SUM(orderdetails.quantityOrdered) AS totalQuantity
FROM customers
JOIN orders 
ON customers.customerNumber = orders.customerNumber
JOIN orderdetails 
ON orders.orderNumber = orderdetails.orderNumber
GROUP BY customerName
ORDER BY totalQuantity DESC
LIMIT 1;

