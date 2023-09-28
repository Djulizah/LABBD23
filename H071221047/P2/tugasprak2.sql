USE classicmodels ;

#1
SELECT customerName, city, country
FROM customers
WHERE country = 'USA' ;

#2
SELECT DISTINCT productVendor
FROM products;

#3
SELECT *
FROM payments
WHERE customerNumber = 124
ORDER BY paymentDate DESC; 

#4
SELECT 
		productName AS 'nama produk', 
		buyprice AS 'harga beli', 
		quantityinstock AS 'jumlah dalam stok' 
FROM products
WHERE quantityinstock >= 1000 AND quantityinstock <= 3000
ORDER BY buyprice ASC
LIMIT 5, 10 ;

#5
SELECT 
		firstName AS 'nama depan',
		email
FROM employees
WHERE email = 'spatterson@classicmodelcars.com' 

		



