USE classicmodels;

-- NO 1
SELECT customerName, city, country 
FROM customers 
WHERE country = 'USA';

-- NO 2
SELECT DISTINCT productVendor FROM products;

-- NO 3
SELECT * FROM payments 
WHERE customerNumber = 124
ORDER BY paymentDate DESC;

-- NO 4
SELECT productName AS 'Nama produk', 
	buyPrice AS 'Harga beli', 
	quantityinstock AS 'Jumlah dalam stok' 
FROM products 
WHERE quantityinstock > 1000 AND quantityinstock < 3000 
ORDER BY buyPrice  
LIMIT 5,10;


--- Soal Tambahan ---
-- 1 --
SELECT customerNumber, paymentdate, amount FROM payments ORDER BY amount DESC LIMIT 1;

-- 2 --
SELECT DISTINCT jobTitle FROM employees;

-- 3 --
SELECT * FROM employees
WHERE email = 'spatterson@classicmodelcars.com';

-- 4 --
SELECT * FROM products
SELECT productName, productLine,quantityinstock FROM products 
where productline = 'Classic Cars' 
ORDER BY quantityinstock 
LIMIT 1, 1;

SELECT * FROM products EXCEPT productLine;
