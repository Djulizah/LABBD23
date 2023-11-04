#NOMOR 1
USE classicmodels;

SELECT DISTINCT customers.customerName,products.productName,payments.paymentDate,orders.status
FROM customers
INNER JOIN orders
USING (customernumber)
INNER JOIN orderdetails
USING (ordernumber)
INNER JOIN products
USING (productcode)
INNER JOIN payments  
USING (customernumber)
productname LIKE '%Ferrari%' AND STATUS  ='shipped';

#N0MOR 2

#a
SELECT customers.customerName,payments.paymentDate, payments.amount ,
CONCAT (employees.firstName,' ',employees.lastName) AS 'nama karyawan'
FROM customers
JOIN payments
USING (customernumber)
JOIN employees
ON employees.employeeNumber = customers.salesrepemployeenumber
WHERE MONTH (paymentdate)= 11;

#where paymentdate like '-%11-%';

#b
#concat menggabungkan
#SELECT customerName FROM customers
SELECT customers.customerName,
payments.paymentDate,
payments.amount,
CONCAT (employees.firstName,' ',employees.lastName) AS 'nama karyawan'
FROM customers
JOIN payments
USING (customernumber)
JOIN employees
ON employees.employeeNumber = customers.salesrepemployeenumber
WHERE MONTH(paymentdate)=11
ORDER BY amount DESC LIMIT 1;

#c
SELECT customers.customerName AS 'nama Customers',products.productName AS 'nama produk'
FROM customers
JOIN orders 
USING (customernumber)
JOIN orderdetails
USING (ordernumber)
JOIN products
USING (productcode)
WHERE customerName ='Corporate Gift Ideas Co.';

#d
SELECT customers.customerName AS 'nama Customers', GROUP_CONCAT(products.productName) AS 'nama produk'
FROM customers
JOIN orders 
USING (customernumber)
JOIN orderdetails
USING (ordernumber)
JOIN products
USING (productcode)
WHERE customerName ='Corporate Gift Ideas Co.';

#NOMOR 3
SELECT customers.customerName AS 'Nama Customers',
orders.orderDate AS 'tanggal order',
orders.shippedDate AS 'tanggal pengiriman',
(orders.shippedDate-orders.orderDate) AS lama_menunggu
FROM customers
JOIN orders
USING (customernumber)
WHERE customername ='GiftsForHim.com'
ORDER BY orders.orderDate DESC 

#NOMOR 4
USE world;
#a
SELECT * FROM country;
SELECT * FROM country 
WHERE code LIKE 'C%K' AND lifeExpectancy != 'null'; 

#SOAL TAMBAHAN 
SELECT customers.customerName, DAYNAME (payments.paymentDate)
FROM customers
INNER JOIN payments
USING (customernumber)
WHERE DAYNAME (paymentDate) = 'sunday' AND LEFT (customers.customerName,1) IN ('a','i','u','e','o')

#cara dua 
SELECT * FROM customers WHERE customerName REGEXP '^[aeiou]';

--  LIKE 'a%' OR 
-- customers.customerName LIKE 'i%' OR customers.customerName LIKE 'u%' OR customers.customerName LIKE 'e%' 
-- OR customers.customerName LIKE 'o%')


