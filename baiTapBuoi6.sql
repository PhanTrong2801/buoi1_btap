#16.	Liệt kê tên khách hàng và tổng số đơn hàng họ đã đặt.
select c.customer_id,c.first_name,c.last_name, count(o.order_id) as TongDonDat
from customers c join orders o on c.customer_id=o.customer_id
group by c.customer_id,c.first_name,c.last_name;



#17.	Tìm các sản phẩm chưa từng xuất hiện trong bất kỳ đơn hàng nào.
select p.product_id,p.name
from products p left join order_items oi on p.product_id = oi.product_id
where oi.product_id is null;



#18.	Đếm số lượng sản phẩm theo từng danh mục.
select c.category_id,c.name, count(pc.product_id) as SLuong
from product_categories pc join categories c on pc.category_id=c.category_id
group by c.category_id,c.name;


#19.	Liệt kê các sản phẩm của nhà cung cấp có id = 3.
select product_id,name,supplier_id
from products 
where supplier_id = 3;



#20.	Tìm các đơn hàng có tổng tiền lớn hơn 1000 và đã được giao hàng.
SELECT o.order_id, o.customer_id, o.total_amount, s.shipped_date, s.delivery_date
FROM orders o
JOIN shipments s ON o.order_id = s.order_id
WHERE o.total_amount > 1000
  AND s.shipped_date IS NOT NULL;


#21.	Liệt kê tên người dùng và vai trò của họ.
SELECT u.username, r.role_name
FROM users u
JOIN user_roles ur ON u.user_id = ur.user_id
JOIN roles r ON ur.role_id = r.role_id;

#22.	Đếm số lượng người dùng theo từng vai trò.
SELECT r.role_name, COUNT(u.user_id) AS user_count
FROM roles r
JOIN user_roles ur ON r.role_id = ur.role_id
JOIN users u ON ur.user_id = u.user_id
GROUP BY r.role_name;


#23.	Tìm khách hàng không có bất kỳ đơn hàng nào.
SELECT c.customer_id, c.first_name, c.last_name
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;


#24.	Tính tổng số tiền mà mỗi khách hàng đã thanh toán.
SELECT c.customer_id,c.first_name,c.last_name,SUM(p.amount) AS total_paid
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN payments p ON o.order_id = p.order_id
GROUP BY c.customer_id, c.first_name, c.last_name;


#25.	Liệt kê danh sách khách hàng và tên sản phẩm họ đã mua.
SELECT c.customer_id,c.first_name,c.last_name,p.product_id,p.name AS product_name
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
ORDER BY c.customer_id, p.product_id;


#26.	Tìm các sản phẩm thuộc nhiều hơn một danh mục.
SELECT pc.product_id,p.name AS product_name,COUNT(pc.category_id) AS category_count
FROM product_categories pc
JOIN products p ON pc.product_id = p.product_id
GROUP BY pc.product_id, p.name
HAVING COUNT(pc.category_id) > 1;

#27.	Hiển thị các sản phẩm được lưu trữ ở nhiều kho khác nhau.
SELECT i.product_id,p.name AS product_name,
COUNT(DISTINCT i.warehouse_id) AS warehouse_count
FROM inventory i
JOIN products p ON i.product_id = p.product_id
GROUP BY i.product_id, p.name
HAVING COUNT(DISTINCT i.warehouse_id) > 1;

#28.	Tìm tên sản phẩm và số lượng còn tồn trong mỗi kho.
SELECT p.name AS product_name,w.name AS warehouse_name,i.stock_quantity
FROM inventory i
JOIN products p ON i.product_id = p.product_id
JOIN warehouses w ON i.warehouse_id = w.warehouse_id
ORDER BY p.name, w.name;

#29.	Tính tổng giá trị hàng tồn kho tại mỗi kho.
SELECT w.name AS warehouse_name,
    SUM(i.stock_quantity * p.price) AS total_inventory_value
FROM inventory i
JOIN products p ON i.product_id = p.product_id
JOIN warehouses w ON i.warehouse_id = w.warehouse_id
GROUP BY w.warehouse_id, w.name
ORDER BY total_inventory_value DESC;


#30.	Liệt kê các đơn hàng được giao bằng phương thức "Express".
SELECT o.order_id,o.order_date,o.status,o.total_amount,sm.name AS shipping_method,
    s.shipped_date,s.delivery_date
FROM orders o
JOIN shipments s ON o.order_id = s.order_id
JOIN shipping_methods sm ON s.shipping_method_id = sm.shipping_method_id
WHERE sm.name = 'Express';



#31.	Tìm đơn hàng có nhiều mặt hàng nhất.
SELECT oi.order_id,COUNT(oi.product_id) AS num_items
FROM order_items oi
GROUP BY oi.order_id
ORDER BY num_items DESC
LIMIT 1;

#32.	Tính số lượng sản phẩm bán được theo từng thương hiệu (brand).
SELECT b.name AS brand_name,SUM(oi.quantity) AS total_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN brands b ON p.brand_id = b.brand_id
GROUP BY b.name
ORDER BY total_sold DESC;



#33.	Tìm các sản phẩm bán chạy nhất (tổng số lượng cao nhất).
SELECT p.name AS product_name,SUM(oi.quantity) AS total_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.name
ORDER BY total_sold DESC
LIMIT 1;

#34.	Liệt kê tất cả các đơn hàng chưa thanh toán đầy đủ (giả sử có thể xảy ra).
SELECT o.order_id,o.customer_id,o.total_amount,
    IFNULL(SUM(p.amount), 0) AS total_paid,
    (o.total_amount - IFNULL(SUM(p.amount), 0)) AS remaining_amount
FROM orders o
LEFT JOIN payments p ON o.order_id = p.order_id
GROUP BY o.order_id
HAVING remaining_amount > 0;


#35.	Đếm số đơn hàng và tổng tiền theo trạng thái đơn hàng.
SELECT o.status,COUNT(o.order_id) AS order_count,SUM(o.total_amount) AS total_amount
FROM orders o
GROUP BY o.status;



#36.	Liệt kê top 5 khách hàng có tổng chi tiêu cao nhất.
SELECT c.first_name, c.last_name, 
    SUM(p.amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN payments p ON o.order_id = p.order_id
GROUP BY c.customer_id
ORDER BY total_spent DESC
LIMIT 5;

#37.	Tính trung bình số tiền trên mỗi đơn hàng của mỗi khách hàng.
SELECT c.first_name, c.last_name, 
    AVG(p.amount) AS average_order_amount
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN payments p ON o.order_id = p.order_id
GROUP BY c.customer_id;


#38.	Liệt kê các sản phẩm bán được trong cả ba phương thức vận chuyển.
SELECT DISTINCT p.name
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
JOIN orders o ON oi.order_id = o.order_id
JOIN shipments s ON o.order_id = s.order_id
JOIN shipping_methods sm ON s.shipping_method_id = sm.shipping_method_id
WHERE sm.name IN ('Express', 'Standard') 
GROUP BY p.product_id
HAVING COUNT(DISTINCT sm.shipping_method_id) = 3; 


#39.	Tìm các sản phẩm chưa được nhập kho nào (không có dòng inventory).
SELECT p.product_id, p.name
FROM products p
LEFT JOIN inventory i ON p.product_id = i.product_id
WHERE i.product_id IS NULL;

#40.	Xác định những nhà cung cấp có sản phẩm được bán nhiều nhất.
SELECT s.supplier_id, s.name AS supplier_name, SUM(oi.quantity) AS total_sold
FROM suppliers s
JOIN products p ON s.supplier_id = p.supplier_id
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY s.supplier_id, s.name
HAVING SUM(oi.quantity) = (
    SELECT MAX(total_quantity)
    FROM (
        SELECT SUM(oi2.quantity) AS total_quantity
        FROM products p2
        JOIN order_items oi2 ON p2.product_id = oi2.product_id
        GROUP BY p2.supplier_id
    ) AS subquery
);

#41.	Tìm các khách hàng đã đặt hàng nhiều lần trong cùng một ngày.
SELECT c.customer_id, u.username, DATE(o.order_date) AS order_day, COUNT(*) AS order_count
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN users u ON c.user_id = u.user_id
GROUP BY c.customer_id, DATE(o.order_date), u.username
HAVING COUNT(*) > 1;


#42.	Liệt kê các đơn hàng có tổng số tiền bằng tổng tiền các sản phẩm trong đó (kiểm tra tính đúng).
SELECT o.order_id, o.total_amount, 
       SUM(oi.quantity * oi.unit_price) AS calculated_total
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY o.order_id, o.total_amount
HAVING o.total_amount = SUM(oi.quantity * oi.unit_price);


#43.	Tìm tên khách hàng và số lượng phương thức thanh toán họ đã sử dụng.
SELECT u.username AS customer_name, COUNT(DISTINCT p.payment_method) AS payment_method_count
FROM customers c
JOIN users u ON c.user_id = u.user_id
JOIN orders o ON c.customer_id = o.customer_id
JOIN payments p ON o.order_id = p.order_id
GROUP BY c.customer_id, u.username;

#44.	Đếm số lượng sản phẩm theo từng thương hiệu và danh mục.
SELECT b.name AS brand_name, c.name AS category_name, COUNT(p.product_id) AS product_count
FROM products p
JOIN brands b ON p.brand_id = b.brand_id
JOIN product_categories pc ON p.product_id = pc.product_id
JOIN categories c ON pc.category_id = c.category_id
GROUP BY b.name, c.name
ORDER BY b.name, c.name;


#45.	Tìm các kho chứa sản phẩm có tổng giá trị lớn nhất.
SELECT w.warehouse_id, w.name AS warehouse_name, 
       SUM(i.stock_quantity * p.price) AS total_value
FROM inventory i
JOIN products p ON i.product_id = p.product_id
JOIN warehouses w ON i.warehouse_id = w.warehouse_id
GROUP BY w.warehouse_id, w.name
HAVING SUM(i.stock_quantity * p.price) = (
    SELECT MAX(total_val)
    FROM (
        SELECT SUM(i2.stock_quantity * p2.price) AS total_val
        FROM inventory i2
        JOIN products p2 ON i2.product_id = p2.product_id
        GROUP BY i2.warehouse_id
    ) AS subquery
);


#46.	Tính tổng số lượng hàng đã giao cho từng khách hàng trong tháng gần nhất.

SELECT c.customer_id, u.username AS customer_name, SUM(oi.quantity) AS total_shipped_quantity
FROM shipments s
JOIN orders o ON s.order_id = o.order_id
JOIN customers c ON o.customer_id = c.customer_id
JOIN users u ON c.user_id = u.user_id
JOIN order_items oi ON o.order_id = oi.order_id
WHERE DATE_FORMAT(s.shipped_date, '%Y-%m') = (
    SELECT DATE_FORMAT(MAX(shipped_date), '%Y-%m') FROM shipments
)
GROUP BY c.customer_id, u.username;



#47.	Tìm sản phẩm có doanh thu cao nhất (quantity × price).
SELECT p.product_id, p.name AS product_name, 
       SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_id, p.name
HAVING SUM(oi.quantity * oi.unit_price) = (
    SELECT MAX(total_rev)
    FROM (
        SELECT SUM(oi2.quantity * oi2.unit_price) AS total_rev
        FROM order_items oi2
        GROUP BY oi2.product_id
    ) AS subquery
);


#48.	Tìm các đơn hàng có ít nhất 2 sản phẩm thuộc thương hiệu khác nhau.
SELECT o.order_id, COUNT(DISTINCT b.brand_id) AS distinct_brands
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
JOIN brands b ON p.brand_id = b.brand_id
GROUP BY o.order_id
HAVING COUNT(DISTINCT b.brand_id) >= 2;


#49.	Tìm những khách hàng có ít nhất một đơn hàng thuộc trạng thái "Delivered" và thanh toán bằng PayPal.
SELECT DISTINCT c.customer_id, u.username AS customer_name
FROM customers c
JOIN users u ON c.user_id = u.user_id
JOIN orders o ON c.customer_id = o.customer_id
JOIN payments p ON o.order_id = p.order_id
JOIN shipments s ON o.order_id = s.order_id
WHERE o.status = 'Delivered'
  AND p.payment_method = 'PayPal';
  
#50.	Tạo bảng thống kê tổng tiền theo từng tháng trong năm và theo từng trạng thái đơn hàng.
SELECT 
    DATE_FORMAT(o.order_date, '%Y-%m') AS month,
    o.status AS order_status,
    SUM(oi.quantity * oi.unit_price) AS total_amount
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY month, o.status
ORDER BY month, o.status;


#1.	Tìm top 3 sản phẩm có doanh thu cao nhất mỗi tháng, bao gồm tên sản phẩm, tháng, tổng doanh thu.
WITH ProductRevenue AS (
    SELECT 
        p.product_id,
        p.name AS product_name,
        DATE_FORMAT(o.order_date, '%Y-%m') AS month,
        SUM(oi.quantity * oi.unit_price) AS total_revenue
    FROM order_items oi
    JOIN products p ON oi.product_id = p.product_id
    JOIN orders o ON oi.order_id = o.order_id
    GROUP BY p.product_id, p.name, month
),
RankedProducts AS (
    SELECT 
        product_id,
        product_name,
        month,
        total_revenue,
        ROW_NUMBER() OVER (PARTITION BY month ORDER BY total_revenue DESC) AS rank
    FROM ProductRevenue
)
SELECT product_name, month, total_revenue
FROM RankedProducts
WHERE rank <= 3
ORDER BY month, rank;


#2.	Tìm các khách hàng có tổng số tiền mua hàng nhiều hơn trung bình tổng chi tiêu của tất cả khách hàng.
WITH CustomerTotalSpend AS (
    SELECT o.customer_id, SUM(oi.quantity * oi.unit_price) AS total_spend
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY o.customer_id
),
AverageSpend AS (
    SELECT AVG(total_spend) AS avg_spend
    FROM CustomerTotalSpend
)
SELECT c.customer_id, u.username AS customer_name, c.total_spend
FROM CustomerTotalSpend c
JOIN users u ON c.customer_id = u.user_id
JOIN AverageSpend a ON c.total_spend > a.avg_spend;

#3.	Liệt kê các sản phẩm được bán bởi nhiều hơn 2 nhà cung cấp khác nhau.
SELECT p.product_id, p.name AS product_name, COUNT(DISTINCT ps.supplier_id) AS supplier_count
FROM products p
JOIN suppliers ps ON p.supplier_id = ps.supplier_id
GROUP BY p.product_id
HAVING COUNT(DISTINCT ps.supplier_id) > 2;


#4.	Tìm tất cả khách hàng đã mua cùng một sản phẩm từ hai đơn hàng khác nhau trong vòng 30 ngày.
SELECT DISTINCT c.customer_id, u.username AS customer_name, oi.product_id, p.name AS product_name
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN customers c ON o.customer_id = c.customer_id
JOIN users u ON c.user_id = u.user_id
JOIN products p ON oi.product_id = p.product_id
WHERE EXISTS (
    SELECT 1
    FROM orders o2
    JOIN order_items oi2 ON o2.order_id = oi2.order_id
    WHERE o2.customer_id = c.customer_id
      AND oi.product_id = oi2.product_id
      AND o2.order_id <> o.order_id
      AND DATEDIFF(o2.order_date, o.order_date) <= 30
);

#5.	Tìm tất cả các đơn hàng có tổng tiền chênh lệch với tổng đơn giá * số lượng trong order_items.
SELECT o.order_id, o.total_amount AS order_total, 
       SUM(oi.unit_price * oi.quantity) AS calculated_total
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY o.order_id
HAVING ABS(o.total_amount - SUM(oi.unit_price * oi.quantity)) > 0.01;

#6.	Xác định các sản phẩm có doanh thu giảm dần trong 3 tháng gần nhất.
WITH MonthlySales AS (
    SELECT oi.product_id,
           YEAR(o.order_date) AS year,
           MONTH(o.order_date) AS month,
           SUM(oi.quantity * oi.unit_price) AS total_revenue
    FROM order_items oi
    JOIN orders o ON oi.order_id = o.order_id
    WHERE o.order_date >= CURDATE() - INTERVAL 3 MONTH
    GROUP BY oi.product_id, YEAR(o.order_date), MONTH(o.order_date)
),
RankedSales AS (
    SELECT product_id, year, month, total_revenue,
           ROW_NUMBER() OVER (PARTITION BY product_id ORDER BY year DESC, month DESC) AS row_num
    FROM MonthlySales
)
SELECT r1.product_id, p.name AS product_name
FROM RankedSales r1
JOIN RankedSales r2 ON r1.product_id = r2.product_id AND r1.row_num = 1 AND r2.row_num = 2
JOIN RankedSales r3 ON r1.product_id = r3.product_id AND r3.row_num = 3
JOIN products p ON r1.product_id = p.product_id
WHERE r1.total_revenue < r2.total_revenue AND r2.total_revenue < r3.total_revenue
ORDER BY r1.product_id;

#7.	Liệt kê các đơn hàng có ít nhất một sản phẩm được vận chuyển chậm hơn 5 ngày kể từ ngày đặt hàng.
SELECT DISTINCT o.order_id, o.order_date, s.shipped_date, p.name AS product_name
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN shipments s ON o.order_id = s.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE DATEDIFF(s.shipped_date, o.order_date) > 5;


#8.	Tính tổng tiền đơn hàng và so sánh với tổng tiền thanh toán để xác định đơn hàng bị thiếu/ dư tiền.









