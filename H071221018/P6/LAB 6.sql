#no1
SELECT CONCAT(e.firstname," ", e.lastName) AS 'nama employee',group_concat(o.orderNumber) AS 'Nomor Orderan',COUNT(od.quantityOrdered) AS 'Jumlah pesanan'
FROM employees AS e
JOIN customers AS c
ON c.salesRepEmployeeNumber = e.employeenumber
JOIN orders AS o
ON o.customerNumber = c.customerNumber
JOIN orderdetails AS od
ON od.orderNumber = o.orderNumber
GROUP BY e.employeeNumber 
HAVING COUNT(od.quantityOrdered) > 10

#no.2
SELECT p.productCode, p.productName, p.quantityInStock, o.orderDate
FROM products AS p
JOIN orderdetails AS od
ON od.productCode=p.productCode
JOIN orders AS o
ON o.orderNumber = od.orderNumber
GROUP BY p.productCode
HAVING p.quantityInStock > 5000
ORDER BY o.orderDate 

#no3
SELECT os.addressLine1,concat(left(os.phone,6), '* **'),count(distinct e.employeeNumber),count(distinct c.customerNumber),format(avg(pa.amount),2)
FROM offices AS os
left JOIN employees AS e
ON os.officeCode = e.officeCode
left JOIN customers AS c
ON c.salesRepEmployeeNumber = e.employeeNumber
left JOIN payments AS pa
ON pa.customerNumber = c.customerNumber
GROUP BY os.addressLine1

#no4
SELECT c.customerName, YEAR(o.orderdate) AS 'tahun order' , MONTH(o.orderdate) AS 'bulan order', COUNT(o.ordernumber) AS 'jumlah pesanan',
SUM(od.priceEach * od.quantityordered) AS 'uang total penjualan'
FROM customers c 
JOIN orders o 
ON o.customerNumber = c.customerNumber
JOIN orderdetails od 
ON od.orderNumber= o.orderNumber
WHERE YEAR(o.orderdate) = 2003
GROUP BY c.customerName, MONTH(o.orderdate)



#soal tambahan
SELECT * FROM customers
SELECT * FROM payments
#no1
SELECT c.customerName, sum(pa.amount),c.creditLimit, (SUM(pa.amount) - c.creditLimit) AS selisih
FROM customers AS c
JOIN payments AS pa
ON c.customerNumber = pa.customerNumber
GROUP BY c.customerName
HAVING SUM(pa.amount) > c.creditLimit
ORDER BY selisih DESC

#no2
SELECT CONCAT(c.customerName,' ',':',' ',c.contactFirstName,' ',c.contactLastName,' ','@',c.addressLine1) AS Pelanggan,sum(od.quantityOrdered) AS 'Jumlah Orderan'
FROM customers c 
JOIN orders o 
ON o.customerNumber = c.customerNumber
JOIN orderdetails od 
ON od.orderNumber= o.orderNumber
GROUP BY c.customerName
ORDER BY sum(od.quantityOrdered) DESC
LIMIT 1

#no3
SELECT pa.paymentDate,concat(monthname(pa.paymentDate),' ',YEAR(pa.paymentDate))AS 'Hari Pembayaran',count(c.customerNumber) AS 'Jumlah Customer',GROUP_CONCAT(c.customerName) AS 'List Customer',SUM(pa.amount) AS 'Jumlah Pembayaran'
FROM payments pa
left JOIN customers c
ON c.customerNumber = pa.customerNumber
WHERE MONTH(paymentDate) = 2
GROUP BY YEAR(paymentDate)
ORDER BY SUM(pa.amount) DESC

#no4
SELECT
    UPPER(p.productName) AS Nama_Produk,
    COUNT(od.orderNumber) AS Jumlah_Orderan,
    GROUP_CONCAT(DISTINCT DATE_FORMAT(o.orderDate, '%Y-%m-%d') SEPARATOR ', ') AS Waktu_Orderan,
    p.buyPrice AS Harga_Beli,
    p.MSRP AS Harga_Jual,
    SUM(od.quantityOrdered) AS Total_Kuantitas_Orderan,
    SUM((p.MSRP - p.buyPrice) * od.quantityOrdered) AS Keuntungan_Bersih
FROM products p
JOIN orderDetails od 
ON p.productCode = od.productCode
JOIN orders o 
ON od.orderNumber = o.orderNumber
WHERE p.productName = '2001 Ferrari Enzo'
GROUP BY p.productName, p.buyPrice, p.MSRP
HAVING Keuntungan_Bersih > 5000;


