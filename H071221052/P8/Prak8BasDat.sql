-- 1

(SELECT c.customerName, p.productName, (p.buyPrice * SUM(od.quantityOrdered)) AS modal
FROM customers c
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products p
USING (productCode)
GROUP BY c.customerName
ORDER BY modal DESC
LIMIT 3)
UNION 
(SELECT c.customerName, p.productName, (p.buyPrice * SUM(od.quantityOrdered)) AS modal
FROM customers c
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products p
USING (productCode)
GROUP BY c.customerName
ORDER BY modal
LIMIT 3);

-- 2

SELECT city
FROM (
(SELECT city, COUNT(*) AS total
FROM customers
WHERE customerName LIKE ('L%')
GROUP BY city
ORDER BY total DESC
LIMIT 1)
UNION
(SELECT o.city, COUNT(*) AS total
FROM employees e
JOIN offices o
USING (officeCode)
WHERE e.firstName LIKE ('L%')
GROUP BY o.city
ORDER BY total
LIMIT 1)
) AS total
GROUP BY city;

-- 3
SELECT CONCAT(firstName,' ',lastName) AS 'nama karyawan/pelanggan', 'Karyawan' AS status
FROM employees
WHERE officeCode IN (
    SELECT officeCode
    FROM employees
    GROUP BY officeCode
    HAVING COUNT(*) = (
        SELECT MIN(employee_count)
        FROM (
            SELECT COUNT(*) AS employee_count
            FROM employees
            GROUP BY officeCode
        ) AS office_counts
    )
)
UNION
SELECT customerName AS 'nama karyawan/pelanggan', 'Pelanggan' AS status
FROM customers
WHERE salesRepEmployeeNumber IN (
    SELECT employeeNumber
    FROM employees
    WHERE officeCode IN (
        SELECT officeCode
        FROM employees
        GROUP BY officeCode
        HAVING COUNT(*) = (
            SELECT MIN(employee_count)
            FROM (
                SELECT COUNT(*) AS employee_count
                FROM employees
                GROUP BY officeCode
            ) AS office_counts
        )
    )
)
ORDER BY `nama karyawan/pelanggan`;


-- 4

SELECT tanggal, GROUP_CONCAT(riwayat SEPARATOR ' dan ') AS riwayat
FROM (
    SELECT o.orderDate AS tanggal, CONCAT('memesan barang') AS riwayat
    FROM orders o
    WHERE YEAR(o.orderDate) = 2003 AND MONTH(o.orderDate) = 4
    UNION
    SELECT p.paymentDate AS tanggal, CONCAT('membayar pesanan') AS riwayat
    FROM payments p
    WHERE YEAR(p.paymentDate) = 2003 AND MONTH(p.paymentDate) = 4
) AS data
GROUP BY tanggal
ORDER BY tanggal

-- soal tambahan
-- 7
SELECT COUNT(customerNumber) 'Jumlah customer', country
FROM customers
WHERE country = 'USA'
UNION
SELECT COUNT(customerNumber), country
FROM customers
WHERE country = 'UK'

-- 1
SELECT customerNumber AS 'customerNumber/employeeNumber',
customerName AS 'customerName/employeeName', 'customer' AS 'status'
FROM customers
WHERE LEFT (customerName, 2) IN ('an', 'en', 'on')
UNION
SELECT employeeNumber, CONCAT(firstName, " ", lastName), 'employee'
FROM employees
WHERE LEFT (firstName, 2) IN ('an', 'en', 'on')










