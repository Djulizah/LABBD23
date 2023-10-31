USE classicmodels
SELECT * FROM customers
SELECT * FROM payments
SELECT * FROM orders
SELECT * FROM orderdetails 
SELECT * FROM products
SELECT * FROM productlines


-- no 1 tampilkan nama, negara, tgl bayar dri 2005 asc
SELECT c.customername AS 'Nama Customer', c.country AS 'Negara', pay.paymentdate AS 'tanggal'
FROM customers c		-- dituker sm join gpp, tpi yg joinnya cuma 1
JOIN payments pay
ON c.customerNumber = pay.customerNumber
WHERE paymentdate > '2004-12-31' 
ORDER BY paymentdate 


-- no 2 nama customer, nama produk (‘The Titanic’), dan deskripsi produk. jangan tampilkan nama customer yang berulang
SELECT DISTINCT c.customername AS 'Nama customer', pr.productname, pl.textdescription
FROM customers c
JOIN orders o ON c.customernumber = o.customernumber
JOIN orderdetails od ON o.ordernumber = od.orderNumber
JOIN products pr ON od.productCode = pr.productcode
JOIN productlines pl ON pr.productLine = pl.productline
WHERE pr.productname = 'The Titanic'


-- no 3
DESCRIBE products

ALTER TABLE products
ADD `status` VARCHAR(20)

# utk cari jmlh barang yg dipesan terbanyak: tampilkan data dgn urutan brdsrkn quantityorder dri tinggi ke rendah, tampilkan data paling atas/pertama
SELECT * FROM orderdetails
ORDER BY quantityOrdered DESC 
LIMIT 1

# set statusnya di barang terbanyak
UPDATE products
SET `status` = 'best selling'
WHERE productcode = 'S12_4675'

# tampilkan data yg diinginkan
SELECT pr.productcode, pr.productname, od.quantityordered, pr.`status`
FROM products pr
JOIN orderdetails od ON pr.productcode = od.productcode
ORDER BY quantityOrdered DESC 
LIMIT 1


-- no 4 hapus data pelanggan yg melakukan pesanan dgn status cancelled
SELECT * FROM orders
WHERE `status` = 'cancelled'

ALTER TABLE orderdetails DROP FOREIGN KEY orderdetails_ibfk_1;
ALTER TABLE orders DROP FOREIGN KEY orders_ibfk_1;
ALTER TABLE payments DROP FOREIGN KEY payments_ibfk_1;

SELECT * FROM customers c
JOIN orders o ON c.customernumber = o.customernumber
JOIN orderdetails od ON o.ordernumber = od.orderNumber
DELETE FROM orders
WHERE `status` = 'cancelled'

DELETE customers FROM customers 
JOIN orders ON customers.customernumber = orders.customernumber
WHERE `status` = 'cancelled'


-- soal tambahan
ALTER TABLE customers
ADD `status` VARCHAR(20)

UPDATE customers 
SET customers.`status` = 'Regular'

SELECT c.customernumber, c.`status`, p.amount, od.quantityOrdered FROM customers c
-- UPDATE customers c
JOIN payments p ON c.customerNumber = p.customerNumber
JOIN orders o ON c.customernumber = o.customerNumber
JOIN orderdetails od ON o.ordernumber = od.ordernumber
SET c.`status` = 'VIP'
WHERE p.amount > 100000 OR od.quantityOrdered > 50

