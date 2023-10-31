#no 1
SELECT * FROM  customers;
SELECT customerName,city,country FROM customers
WHERE country = "USA";

#no 2
SELECT * FROM products;
SELECT DISTINCT productVendor FROM products;

#no 3
SELECT * FROM payments
WHERE customernumber = 124
ORDER BY paymentdate DESC;

#no 4
SELECT * FROM products;
SELECT productname AS 'Nama produk', buyprice AS 'Harga beli' , quantityInStock AS 'jumlah dalam stok' FROM products
WHERE quantityInStock > 1000 AND quantityInStock < 3000
ORDER BY buyprice
LIMIT 5, 10;
