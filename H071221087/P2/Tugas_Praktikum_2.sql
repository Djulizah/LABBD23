-- nomor 1
SELECT customerName, city, country FROM customers 
WHERE country = 'USA'

-- nomor 2
SELECT DISTINCT productVendor FROM products

-- nomor 3
SELECT * FROM payments
WHERE customerNumber = 124 
ORDER BY paymentDate DESC 

-- nomor 4
SELECT productname AS `Nama produk`, buyprice AS `Harga beli` , quantityinstock AS `Jumlah dalam stok` FROM  products 
WHERE quantityinstock > 1000 AND quantityinstock < 3000
ORDER BY buyprice 
LIMIT 5,10 


-- Tugas Tambahan
SELECT * FROM payments
ORDER BY amount DESC 
LIMIT 1

DESCRIBE payments