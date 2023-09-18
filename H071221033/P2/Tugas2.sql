USE classicmodels

-- no 1
SELECT * FROM customers
SELECT customername, city, country FROM customers
WHERE country = 'USA'

-- no 2
SELECT * FROM products
SELECT DISTINCT productvendor FROM products

-- no 3
SELECT * FROM payments
WHERE customernumber = 124
ORDER BY paymentdate DESC 

-- no 4
SELECT * FROM products
SELECT productname AS 'Nama produk', buyprice AS 'Harga beli', quantityinstock AS 'Jumlah dalam stok'
FROM products
WHERE quantityinstock > 1000 AND quantityinstock < 3000
ORDER BY buyprice 
LIMIT 5, 10

-- no 5 soal tambahan
SELECT * FROM payments
SELECT paymentdate, amount FROM payments
ORDER BY amount DESC 
LIMIT 1









