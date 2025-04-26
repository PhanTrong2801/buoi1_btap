USE OnlineRetailDB;

#cau21
SELECT c.customerId,c.customerName,SUM(od.quantity * od.unitPrice) AS TongThu
FROM Customer c
JOIN OrderInfo oi ON c.customerId = oi.customerId
JOIN OrderDetail od ON oi.orderId = od.orderId
WHERE oi.status = 'Completed'
GROUP BY c.customerId, c.customerName;


#cau22
SELECT od.orderId,SUM(od.quantity) AS TongSP
FROM OrderDetail od
GROUP BY od.orderId
ORDER BY TongSP DESC
LIMIT 1;

#cau23
SELECT c.customerId,c.customerName,MONTH(oi.orderDate) AS month
FROM Customer c
JOIN OrderInfo oi ON c.customerId = oi.customerId
WHERE YEAR(oi.orderDate) = 2023
GROUP BY c.customerId, MONTH(oi.orderDate)
ORDER BY c.customerId, month;


#cau24
SELECT p.productId,p.productName,COUNT(DISTINCT od.orderId) AS orderCount
FROM Product p
JOIN OrderDetail od ON p.productId = od.productId
GROUP BY p.productId, p.productName
HAVING COUNT(DISTINCT od.orderId) >= 2;

#cau25
WITH OrderTotal AS (
    SELECT 
        od.orderId,
        SUM(od.quantity * od.unitPrice) AS totalValue
    FROM OrderDetail od
    GROUP BY od.orderId
)

SELECT *
FROM OrderTotal
WHERE totalValue = (SELECT MIN(totalValue) FROM OrderTotal)
   OR totalValue = (SELECT MAX(totalValue) FROM OrderTotal);


#cau26
SELECT c.customerId,c.customerName,SUM(od.quantity * od.unitPrice) AS TongChi
FROM Customer c
JOIN OrderInfo oi ON c.customerId = oi.customerId
JOIN OrderDetail od ON oi.orderId = od.orderId
WHERE oi.status = 'Completed'
GROUP BY c.customerId, c.customerName
ORDER BY TongChi DESC
LIMIT 1;

#cau27
SELECT od.orderId,COUNT(DISTINCT od.productId) AS kieuSP
FROM OrderDetail od
GROUP BY od.orderId
HAVING COUNT(DISTINCT od.productId) >= 2;

#cau28

SELECT 
    MONTH(oi.orderDate) AS month,
    SUM(od.quantity * od.unitPrice) AS totalRevenue
FROM OrderInfo oi
JOIN OrderDetail od ON oi.orderId = od.orderId
WHERE YEAR(oi.orderDate) = 2023 AND oi.status = 'Completed'
GROUP BY MONTH(oi.orderDate)
ORDER BY month;


#cau29
SELECT c.customerId,c.customerName,
    COUNT(DISTINCT oi.orderId) AS totalOrders,
    SUM(od.quantity * od.unitPrice) AS totalSpent,
    SUM(od.quantity) AS totalProducts
FROM Customer c
JOIN OrderInfo oi ON c.customerId = oi.customerId
JOIN OrderDetail od ON oi.orderId = od.orderId
WHERE oi.status = 'Completed'
GROUP BY c.customerId, c.customerName
ORDER BY totalSpent DESC;


#cau30
SELECT c.customerId, c.customerName
FROM Customer c
WHERE NOT EXISTS (
    SELECT p.productId
    FROM Product p
    WHERE p.category = 'Electronics'
    AND NOT EXISTS (
        SELECT od.productId
        FROM OrderDetail od
        JOIN OrderInfo oi ON od.orderId = oi.orderId
        WHERE oi.customerId = c.customerId
        AND od.productId = p.productId
    )
);



