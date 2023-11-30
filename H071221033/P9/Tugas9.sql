USE classicmodels

-- no1
SELECT YEAR(orderdate) AS 'tahun', COUNT(ordernumber)  AS 'jumlah pesanan', 
	case
	when COUNT(ordernumber) > 150 then 'banyak'
	when COUNT(ordernumber) < 75 then 'sedikit'
	ELSE 'sedang'
	end
	AS 'kategori pesanan'
FROM orders
GROUP BY tahun


-- no2
SELECT CONCAT(e.firstname, " ", e.lastname) AS 'nama pegawai', SUM(pay.amount) AS 'gaji',
	case 
	when SUM(pay.amount) > (SELECT AVG(`total gaji`) FROM (
		SELECT SUM(pay.amount) AS 'total gaji'
		FROM payments pay
		JOIN customers c USING(customernumber)
		JOIN employees e ON c.salesRepEmployeeNumber = e.employeenumber
		GROUP BY e.employeenumber) AS a
	) then 'gaji di atas rata-rata'
	when SUM(pay.amount) < (SELECT AVG(`total gaji`) FROM (
		SELECT SUM(pay.amount) AS 'total gaji'
		FROM payments pay
		JOIN customers c USING(customernumber)
		JOIN employees e ON c.salesRepEmployeeNumber = e.employeenumber
		GROUP BY e.employeenumber) AS a
	) then 'gaji di bawah rata-rata'
	ELSE 'sama'
	end
	AS 'kategori gaji'
FROM employees e
JOIN customers c ON e.employeenumber = c.salesrepemployeenumber
JOIN payments pay USING(customernumber)
GROUP BY e.employeenumber
ORDER BY `gaji` DESC 


-- no3
SELECT c.customername AS 'Pelanggan', 
	GROUP_CONCAT(LEFT(pro.productname, 4)) AS 'Tahun_Pembuatan', 
	COUNT(pro.productcode) AS 'Jumlah_produk', 
	SUM(DATEDIFF(o.shippedDate, o.orderDate)) AS 'Total_Durasi_Pengiriman', 
	case 
	when MONTH(o.orderdate) % 2 = 1 AND SUM(DATEDIFF(o.shippedDate, o.orderDate)) > (
		SELECT AVG(total) FROM (
			SELECT SUM(DATEDIFF(o.shippedDate, o.orderDate)) AS 'total'
			FROM orders o
			GROUP BY customernumber) AS a
			) then 'TARGET 1'
	when MONTH(o.orderdate) % 2 = 0 AND SUM(DATEDIFF(o.shippedDate, o.orderDate)) > (
		SELECT AVG(total) FROM (
			SELECT SUM(DATEDIFF(o.shippedDate, o.orderDate)) AS 'total'
			FROM orders o
			GROUP BY customernumber) AS a
			) then 'TARGET 2'
	END AS 'Keterangan'
FROM customers c
JOIN orders o USING(customernumber)
JOIN orderdetails od USING(ordernumber)
JOIN products pro USING(productcode)
WHERE pro.productname LIKE '18%'
GROUP BY c.customernumber
HAVING Keterangan IS NOT NULL 

UNION 

SELECT c.customername AS 'Pelanggan', 
	GROUP_CONCAT(LEFT(pro.productname, 4)) AS 'Tahun_Pembuatan', 
	COUNT(pro.productcode) AS 'Jumlah_produk', 
	SUM(DATEDIFF(o.shippedDate, o.orderDate)) AS 'Total_Durasi_Pengiriman', 
	case 
	when MONTH(o.orderdate) % 2 = 1 AND COUNT(pro.productcode) > (
		SELECT AVG(total) * 10 FROM (
			SELECT COUNT(pro.productname) AS 'total'
			FROM products pro
			GROUP BY productcode) AS a
			) then 'TARGET 3'
	when MONTH(o.orderdate) % 2 = 0 AND COUNT(pro.productcode) > (
		SELECT AVG(total) * 10 FROM (
			SELECT COUNT(pro.productname) AS 'total'
			FROM products pro
			GROUP BY productcode) AS a
			) then 'TARGET 4'
	END AS 'Keterangan'
FROM customers c
JOIN orders o USING(customernumber)
JOIN orderdetails od USING(ordernumber)
JOIN products pro USING(productcode)
WHERE pro.productname LIKE '19%'
GROUP BY c.customernumber
HAVING Keterangan IS NOT NULL 

UNION 

SELECT c.customername AS 'Pelanggan',
	GROUP_CONCAT(LEFT(pro.productname, 4)) AS 'Tahun_Pembuatan', 
	COUNT(pro.productcode) AS 'Jumlah_produk', 
	SUM(DATEDIFF(o.shippedDate, o.orderDate)) AS 'Total_Durasi_Pengiriman', 
	case 
	when MONTH(o.orderdate) % 2 = 1 AND COUNT(pro.productcode) > (
		SELECT MIN(total) * 3 FROM (
			SELECT COUNT(pro.productname) AS 'total'
			FROM products pro
			GROUP BY productcode) AS a
			) then 'TARGET 5'
	when MONTH(o.orderdate) % 2 = 0 AND COUNT(pro.productcode) > (
		SELECT MIN(total) * 3 FROM (
			SELECT COUNT(pro.productname) AS 'total'
			FROM products pro
			GROUP BY productcode) AS a
			) then 'TARGET 6'
	END AS 'Keterangan'
FROM customers c
JOIN orders o USING(customernumber)
JOIN orderdetails od USING(ordernumber)
JOIN products pro USING(productcode)
WHERE pro.productname LIKE '20%'
GROUP BY c.customernumber
HAVING Keterangan IS NOT NULL 


-- no5
SHOW VARIABLES LIKE '%autocommit%'
set autocommit = 0

BEGIN 
SELECT @bignumber:=MAX(ordernumber)+1 FROM orders
INSERT INTO orders (ordernumber, orderdate, requireddate, shippeddate, `status`, comments, customernumber)
VALUES(@bignumber+1, '2010-01-01', '2010-02-02', '2010-01-02', 'shipped', 'yayaya', 103)


ALTER TABLE orders 
DROP FOREIGN KEY orders_ibfk_1

ALTER TABLE orders ADD FOREIGN KEY (customernumber)
REFERENCES customers (customernumber) on delete CASCADE 


-- no6 tambahan
BEGIN 

SELECT * FROM orderdetails
DELETE FROM orderdetails

ROLLBACK 