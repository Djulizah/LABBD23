-- USE classicmodels;
-- 1
SELECT customerName, city, country
FROM customers
WHERE country = 'usa';

-- 2
SELECT DISTINCT productVendor
FROM products;

-- 3
SELECT * FROM payments
WHERE customerNumber = 124
ORDER BY paymentDate DESC;
-- DESCRIBE payments

-- 4
SELECT productName AS 'nama produk', buyprice AS 'harga beli', quantityinstock AS 'jumlah dalam stok'
FROM products
WHERE quantityinstock >1000 AND quantityinstock <3000
ORDER BY buyprice 
LIMIT 5, 10;

-- 5
SELECT * FROM products
WHERE productLine = 'Classic Cars'
ORDER BY quantityInStock
LIMIT 1,1;

-- 5
SELECT productName, productLine, quantityInStock FROM products
WHERE productLine = 'Classic Cars'
ORDER BY quantityInStock
LIMIT 1,1;

-- 6
SELECT jobTitle FROM employees

-- 7
SELECT * FROM payments
ORDER BY amount DESC 
LIMIT 1;

-- 8
SELECT * FROM employees
WHERE lastName = 'patterson' AND email = 'spatterson@classicmodelcars.com'
 

