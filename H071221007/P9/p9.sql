-- START TRANSACTION
-- 
-- SELECT @orderNumber :=max(orderNumber)+1 from orders;
-- 
-- INSERT INTO orders(orderNumber, orderDate, requiredDate, shippedDate,
-- status, customerNumber)
-- VALUES(@orderNumber,
-- '2005-05-31',
-- '2005-06-10',
-- '2005-06-11',
-- 'In Process',
-- 145);
-- 
-- COMMIT;
-- SELECT * FROM orders
-- 
-- 
-- BEGIN;
-- DELETE FROM orderdetails;
-- SELECT * FROM orderdetails;
-- 
-- ROLLBACK;
-- 
-- -- lebih baik pake saja begin saja
-- 
-- 

SELECT e.lastName, e.firstName ,e.employeeNumber FROM employees e
WHERE e.employeeNumber NOT IN (SELECT c.salesRepEmployeeNumber FROM customers c
WHERE c.salesRepEmployeeNumber IS NOT NULL
)
AND jobtitle = 'sales rep'
;


SELECT ordernumber, `status`,
case 
when `status` = 'shipped' then 'Sampai'
when `status` = 'In process' then 'Diproses'
ELSE 'unknown'
END 
AS pesan 
FROM orders;


SELECT p.customerNumber, p.amount,
case 
when p.amount >  1000 then 'lebih dari 1k'
when p.amount <  1000 then 'kurang dari 1k'
when p.amount =  1000 then '1k'
END 
AS keterangan 
FROM payments p;

SELECT c.customerName, SUM(case 
when o.`status` = 'in procces' then 1
when o.`status` = 'on hold' then 1
ELSE 0
END) 
AS Total
FROM customers c
JOIN orders o
ON c.customerNumber = o.customerNumber
GROUP BY c.customerName;

SELECT c.customerName, o.ordernumber, SUM(od.quantityOrdered * od.priceEach) AS TotalPrice,
case 
when SUM(od.quantityOrdered * od.priceEach) > SUM(od.quantityOrdered * od.priceEach)/COUNT(*) then 'Order Istimewa'
ELSE 'Order Biasa'
END AS customerStatus
FROM customers c
JOIN orders o
ON c.customerNumber = o.customerNumber
JOIN orderdetails od
ON o.orderNumber = od.orderNumber
GROUP BY c.customerName;




SELECT p.productLine, p.productCode,GROUP_CONCAT(p.productName SEPARATOR '; '), COUNT(*) FROM products p
GROUP BY classicmodelsp.productLine
ORDER BY p.productLine;







-- Tugas 9 --


-- no 1
SELECT YEAR(o.orderDate) tahun, COUNT(o.orderNumber) 'jumlah pesanan',
case
when COUNT(o.orderNumber) > 150 then 'banyak'
when COUNT(o.orderNumber) < 75 then 'sedikit'
ELSE 'sedang'
END AS 'kategori pesanan'
FROM orders o
GROUP BY YEAR(o.orderDate);


-- no 2
SELECT CONCAT(e.firstName, ' ', e.lastName) 'nama pegawai', SUM(p.amount) gaji,
case 
when SUM(p.amount) > (SELECT AVG(salary)
FROM (SELECT SUM(p.amount) AS salary FROM employees e
JOIN customers c
ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN payments p
ON c.customerNumber = p.customerNumber
GROUP BY e.employeeNumber)AS a)
then 'di atas rata-rata total gaji karyawan'
when SUM(p.amount) < (SELECT AVG(salary)
FROM (SELECT SUM(p.amount) AS salary FROM employees e
JOIN customers c
ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN payments p
ON c.customerNumber = p.customerNumber
GROUP BY e.employeeNumber)AS a)
then 'di bawah rata-rata total gaji karyawan'
ELSE 'sama dengan rata-rata gaji karyawan'
END AS 'kategori gaji'
FROM employees e
JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments p
ON c.customerNumber = p.customerNumber
GROUP BY `nama pegawai`
ORDER BY gaji DESC;


-- no 3
SELECT c.customerName, GROUP_CONCAT(LEFT(p.productName, 4)) 'tahun pembuatan', 
COUNT(p.productCode) 'jumlah produk', SUM(DATEDIFF(o.shippedDate, o.orderDate)) 'durasi pengiriman',
case 
	when p.productName LIKE '18%' then 
		 'Target 1'
			-- 	when p.productName LIKE '19__%' AND COUNT(p.productCode) >
-- 			(SELECT AVG(p.productCode) FROM customers c
-- 			JOIN orders o 
-- 			ON c.customerNumber = o.customerNumber
-- 			JOIN orderdetails od
-- 			ON o.orderNumber = od.orderNumber
-- 			JOIN products p
-- 			ON od.productCode = p.productCode)
-- 		case 
-- 			when MONTH(o.orderDate) % 2 = 1 
-- 			then 'Target 1'
-- 			when MONTH(o.orderDate) % 2 = 0
-- 			then 'Target 2'
-- 			ELSE 'Tidak masuk target'
			
END AS keterangan
FROM customers c
JOIN orders o 
ON c.customerNumber = o.customerNumber
JOIN orderdetails od
ON o.orderNumber = od.orderNumber
JOIN products p
ON od.productCode = p.productCode
WHERE p.productName LIKE '18%' OR p.productName LIKE '19%' OR p.productName LIKE '20%'
GROUP BY c.customerNumber
ORDER BY c.customerName, p.productName;












SELECT
    c.customerName 'Nama Pelanggan',
    GROUP_CONCAT(LEFT(p.productName, 4)) 'Tahun Pembuatan Produk',
    COUNT(p.productCode) 'Jumlah Produk',
    SUM(DATEDIFF(o.shippedDate, o.orderDate)) 'Total Durasi Pengiriman',
    CASE
        WHEN 
            MONTH(o.orderDate) % 2 = 1 AND
            SUM(DATEDIFF(o.shippedDate, o.orderDate)) > (
                SELECT AVG(Total) 
                FROM (SELECT SUM(DATEDIFF(o2.shippedDate, o2.orderDate)) 'Total'
                		FROM orders o2
                		GROUP BY customernumber) AS a
            ) THEN 'TARGET 1'
        
        WHEN 
            MONTH(o.orderDate) % 2 = 0 AND
            SUM(DATEDIFF(o.shippedDate, o.orderDate)) > (
                SELECT AVG(Total) 
                FROM (SELECT SUM(DATEDIFF(o2.shippedDate, o2.orderDate)) 
                		'Total'
                		FROM orders o2
                		GROUP BY customernumber) AS a
            ) THEN 'TARGET 2'
     END 'Keterangan'
FROM customers c
JOIN orders o 
USING (customernumber)
JOIN orderdetails od
USING (ordernumber)
JOIN products p
USING (productcode)
WHERE p.productName LIKE '18%'
GROUP BY c.customernumber
HAVING Keterangan IS NOT NULL

UNION

SELECT
    c.customerName 'Nama Pelanggan',
    GROUP_CONCAT(LEFT(p.productName, 4)) 'Tahun Pembuatan Produk',
    COUNT(p.productCode) 'Jumlah Produk',
    SUM(DATEDIFF(o.shippedDate, o.orderDate)) 'Total Durasi Pengiriman',
    CASE
        WHEN 
            MONTH(o.orderDate) % 2 <> 0 AND
            COUNT(p.productCode) > 10 * (
                SELECT AVG(product_count)
                FROM (
					 SELECT COUNT(p2.productCode) AS product_count
                    FROM products p2
                    GROUP BY p2.productCode
					 ) AS counts
				)   
				THEN 'TARGET 3'
				
        WHEN 
            MONTH(o.orderDate) % 2 = 0 AND
            COUNT(p.productCode) > 10 * (
                SELECT AVG(product_count)
                FROM (
					 SELECT COUNT(p2.productCode) AS product_count
                    FROM products p2
                    GROUP BY p2.productCode
					 ) AS counts
				)   
            THEN 'TARGET 4'
    END 'Keterangan'
FROM customers c
JOIN orders o 
USING (customernumber)
JOIN orderdetails od
USING (ordernumber)
JOIN products p
USING (productcode)
WHERE p.productName LIKE '19%'
GROUP BY c.customernumber
HAVING Keterangan IS NOT NULL
 	
UNION 

SELECT
    c.customerName 'Nama Pelanggan',
    GROUP_CONCAT(LEFT(p.productName, 4)) 'Tahun Pembuatan Produk',
    COUNT(p.productCode) 'Jumlah Produk',
    SUM(DATEDIFF(o.shippedDate, o.orderDate)) 'Total Durasi Pengiriman',
    	CASE
        WHEN 
            MONTH(o.orderDate) % 2 <> 0 AND
            COUNT(p.productCode) > 3 * (
                SELECT MIN(product_count)
                FROM (
                    SELECT COUNT(p2.productCode) AS product_count
                    FROM products p2
                    GROUP BY p2.productCode
                ) AS counts
				)
            THEN 'TARGET 5'
        
        WHEN 
            MONTH(o.orderDate) % 2 = 0 AND
            COUNT(p.productCode) > 3 * (
                SELECT MIN(product_count)
                FROM (
                    SELECT COUNT(p2.productCode) AS product_count
                    FROM products p2
                    GROUP BY p2.productCode
                ) AS counts
				)
            THEN 'TARGET 6'
    END 'Keterangan'
FROM customers c
JOIN orders o 
USING (customernumber)
JOIN orderdetails od
USING (ordernumber)
JOIN products p
USING (productcode)
WHERE productName LIKE '20%'
GROUP BY c.customernumber
HAVING Keterangan IS NOT NULL;






SELECT
    c.customerName,
    GROUP_CONCAT(LEFT(p.productName, 4)) AS tahun_pembuatan,
    COUNT(p.productCode) AS jumlah_produk,
    SUM(DATEDIFF(o.shippedDate, o.orderDate)) AS durasi_pengiriman,
    CASE
        WHEN p.productName LIKE '18%' THEN
            CASE
                WHEN MONTH(o.orderDate) % 2 = 1 AND SUM(DATEDIFF(o.shippedDate, o.orderDate)) >
                    (SELECT AVG(Total) 
                     FROM (SELECT SUM(DATEDIFF(o2.shippedDate, o2.orderDate)) AS Total
                           FROM orders o2
                           GROUP BY o2.customerNumber) AS a
                    )
                THEN 'Target 1'
                WHEN MONTH(o.orderDate) % 2 = 0 AND SUM(DATEDIFF(o.shippedDate, o.orderDate)) >
                    (SELECT AVG(Total) 
                     FROM (SELECT SUM(DATEDIFF(o2.shippedDate, o2.orderDate)) AS Total
                           FROM orders o2
                           GROUP BY o2.customerNumber) AS a
                    )
                THEN 'Target 2'
            END
        WHEN p.productName LIKE '19%' THEN
            CASE
                WHEN MONTH(o.orderDate) % 2 = 1 AND COUNT(p.productCode) > 10 * (
                    SELECT MIN(produk_count)
                    FROM (SELECT COUNT(p2.productCode) AS produk_count
                          FROM customers c2
                          JOIN orders o2 ON c2.customerNumber = o2.customerNumber
                          JOIN orderdetails od2 ON o2.orderNumber = od2.orderNumber
                          JOIN products p2 ON od2.productCode = p2.productCode
                          WHERE p2.productName LIKE '19%'
                          GROUP BY c2.customerNumber) AS b
                )
                THEN 'Target 3'
                WHEN MONTH(o.orderDate) % 2 = 0 AND COUNT(p.productCode) > 10 * (
                    SELECT MIN(produk_count)
                    FROM (SELECT COUNT(p2.productCode) AS produk_count
                          FROM customers c2
                          JOIN orders o2 ON c2.customerNumber = o2.customerNumber
                          JOIN orderdetails od2 ON o2.orderNumber = od2.orderNumber
                          JOIN products p2 ON od2.productCode = p2.productCode
                          WHERE p2.productName LIKE '19%'
                          GROUP BY c2.customerNumber) AS b
                )
                THEN 'Target 4'
            END
        WHEN p.productName LIKE '20%' THEN
            CASE
                WHEN MONTH(o.orderDate) % 2 = 1 AND COUNT(p.productCode) > 3 * (
                    SELECT MIN(produk_count)
                    FROM (SELECT COUNT(p2.productCode) AS produk_count
                          FROM customers c2
                          JOIN orders o2 ON c2.customerNumber = o2.customerNumber
                          JOIN orderdetails od2 ON o2.orderNumber = od2.orderNumber
                          JOIN products p2 ON od2.productCode = p2.productCode
                          WHERE p2.productName LIKE '20%'
                          GROUP BY c2.customerNumber) AS b
                )
                THEN 'Target 5'
                WHEN MONTH(o.orderDate) % 2 = 0 AND COUNT(p.productCode) > 3 * (
                    SELECT MIN(produk_count)
                    FROM (SELECT COUNT(p2.productCode) AS produk_count
                          FROM customers c2
                          JOIN orders o2 ON c2.customerNumber = o2.customerNumber
                          JOIN orderdetails od2 ON o2.orderNumber = od2.orderNumber
                          JOIN products p2 ON od2.productCode = p2.productCode
                          WHERE p2.productName LIKE '20%'
                          GROUP BY c2.customerNumber) AS b
                )
                THEN 'Target 6'
            END
    END AS keterangan
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
JOIN products p ON od.productCode = p.productCode
WHERE p.productName LIKE '18%' OR p.productName LIKE '19%' OR p.productName LIKE '20%'
GROUP BY c.customerNumber
HAVING keterangan IS NOT NULL;



SELECT distinct city from customers LIMIT 5;



BEGIN;

SELECT @orderNumber :=max(orderNumber)+1 from orders;

INSERT INTO orders(orderNumber, orderDate, requiredDate, shippedDate,
status, customerNumber)
VALUES(@orderNumber,
'2023-05-31',
'2023-06-10',
'2023-06-11',
'In Process',
145);
ROLLBACK;

SELECT * FROM orders

 


BEGIN;
DELETE FROM orderdetails;
SELECT * FROM orderdetails;

ROLLBACK;

SELECT * FROM orderdetails;



SELECT c.customerName, MONTH(p.paymentDate), COUNT(*) FROM customers c
JOIN payments p
ON c.customerNumber = p.customerNumber
JOIN orders o
ON c.customerNumber = o.customerNumber
JOIN orderdetails od
ON o.orderNumber = od.orderNumber
JOIN products pr
ON od.productCode = pr.productCode
WHERE MONTH(p.paymentDate) = 3 
GROUP BY c.customerName
HAVING (COUNT(*) % 2 = 1);



SELECT c.customerName ,SUM(p.amount) FROM customers c
JOIN payments p
ON c.customerNumber = p.customerNumber
GROUP BY c.customerName;

SELECT c.customerName, p.paymentDate, COUNT(pr.productCode) FROM customers c
JOIN payments p
ON c.customerNumber = p.customerNumber
JOIN orders o
ON c.customerNumber = o.customerNumber
JOIN orderdetails od
ON o.orderNumber = od.orderNumber
JOIN products pr
ON od.productCode = pr.productCode
WHERE DAY(p.paymentDate) = 24
GROUP BY c.customerName
HAVING (COUNT(pr.productCode) > 20);


SELECT * FROM customers c
JOIN payments p
ON c.customerNumber = p.customerNumber
JOIN orders o
ON c.customerNumber = o.customerNumber
JOIN orderdetails od
ON o.orderNumber = od.orderNumber
JOIN products pr
ON od.productCode = pr.productCode
WHERE ;

SELECT c.customerName, pr.productName FROM customers c
JOIN payments p
ON c.customerNumber = p.customerNumber
JOIN orders o
ON c.customerNumber = o.customerNumber
JOIN orderdetails od
ON o.orderNumber = od.orderNumber
JOIN products pr
ON od.productCode = pr.productCode
WHERE pr.productName = MIN(pr.productName)
UNION
SELECT c.customerName, pr.productName FROM customers c
JOIN payments p
ON c.customerNumber = p.customerNumber
JOIN orders o
ON c.customerNumber = o.customerNumber
JOIN orderdetails od
ON o.orderNumber = od.orderNumber
JOIN products pr
ON od.productCode = pr.productCode
pr.productName = MAX(pr.productName);








SELECT distinct CONCAT(E.firstName, ' ', E.lastName), P.productName
FROM employees E
JOIN customers C
ON E.employeeNumber = C.salesRepEmployeeNumber
JOIN orders O
USING(customerNumber)
JOIN orderdetails O1
USING(orderNumber)
JOIN products P
USING(productCode)
WHERE LEFT(productName, 4) = '1995';





