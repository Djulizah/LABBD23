-- No. 1 --

USE classicmodels

SELECT 
		customerName,
		city,
		country
FROM customers
WHERE country = 'usa'

-- No. 2 --

SELECT DISTINCT productVendor
FROM products

-- No. 3 --

SELECT * 
FROM payments
WHERE customerNumber = 124
ORDER BY paymentDate DESC 

DESCRIBE payments

-- No. 4 --

SELECT 
		productName AS 'Nama produk',
		buyprice AS 'Harga beli',
		quantityinstock AS 'Jumlah dalam stok'
FROM products
WHERE quantityinstock BETWEEN 1000 AND 3000
ORDER BY buyprice ASC 
LIMIT 10 OFFSET 5;

-- Soal Tambahan

SELECT * FROM orders
WHERE 

SELECT * FROM employees
WHERE jobtitle

SELECT * FROM employees
WHERE lastname = 'spatterson@classicmodelcars.com'

