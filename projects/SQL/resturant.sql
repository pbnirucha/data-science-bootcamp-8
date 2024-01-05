.open restaurant.db
  -- create table
  CREATE TABLE IF NOT EXISTS customers(
    customer_id int, 
    customer_name text,
    city text
  );

  INSERT INTO customers VALUES 
    (1, "Ploy", "Bangkok"),
    (2, "Kookik", "London"),
    (3, "Elle", "Bangkok"),
    (4, "Jaii", "London"),
    (5, "Faeng", "London"),
    (6, "Butter", "Bangkok");

  CREATE TABLE IF NOT EXISTS menus(
    menu_id int, 
    menu_name text,
    price int
  );

  INSERT INTO menus VALUES 
    (1, "Hawaiian", 349),
    (2, "Seafood", 399),
    (3, "Cheese", 279),
    (4, "Pepperoni", 279),
    (5, "Veggie", 349);

  CREATE TABLE IF NOT EXISTS orders(
    order_id int, 
    customer_id int,
    menu_id int,
    order_date timestamp
  );

  INSERT INTO orders VALUES 
    (1, 1, 1, "2023-01-01"),
    (2, 1, 2, "2023-01-01"),
    (3, 4, 3, "2023-01-01"),
    (4, 4, 5, "2023-01-01"),
    (5, 5, 2, "2023-01-03"),
    (6, 5, 4, "2023-01-03"),
    (7, 3, 2, "2023-01-03"),
    (8, 6, 3, "2023-01-03");

  CREATE TABLE IF NOT EXISTS transactions(
    transaction_id int, 
    order_id int,
    total_price int,
    payment_method text
  );

  INSERT INTO transactions VALUES 
    (1, 1, 349, "cash"),
    (2, 2, 399, "cash"),
    (3, 3, 279, "credit card"),
    (4, 4, 349, "credit card"),
    (5, 5, 399, "credit card"),
    (6, 6, 279, "credit card"),
    (7, 7, 399, "credit card"),
    (8, 8, 279, "cash");

.table
  
.mode box
  SELECT * FROM customers;
  SELECT * FROM menus; 
  SELECT * FROM orders; 
  SELECT * FROM transactions;

-- query 1 : join
-- ลูกค้าแต่ละคน สั่งพิซซ่าหน้าอะไร วันไหนบ้าง และชำระเงินแบบใด

SELECT 
  cus.customer_name,
  cus.city,
  ord.order_date,
  m.menu_name,
  t.total_price,
  t.payment_method
  
FROM orders as ord
JOIN customers as cus
  ON cus.customer_id = ord.customer_id
JOIN menus as m 
  ON m.menu_id = ord.menu_id
JOIN transactions as t 
  ON t.order_id = ord.order_id;

-- query 2 : aggregate functions
-- มีคำสั่งซื้อกี่คำสั่งซื้อ / ยอดรวม / คำสั่งซื้อที่ยอดน้อยที่สุด / คำสั่งซื้อที่ยอดมากที่สุด / ยอดเฉลี่ย ในแต่ละวัน

SELECT 
    ord.order_date,
    COUNT(ord.order_date) AS count_order,
    SUM(t.total_price) AS sum_total, 
    MIN(t.total_price) AS min_total,
    MAX(t.total_price) AS max_total,
    ROUND(AVG(t.total_price), 2) AS AVG_total
FROM transactions as t
JOIN orders as ord 
  ON t.order_id = ord.order_id
GROUP BY ord.order_date
ORDER BY ord.order_date asc;

-- query 3 : subquery
-- หา id และชื่อลูกค้า ที่มียอดสั่งซื้อรวมสูงสุดของสาขา Bangkok ในปี 2023

SELECT sub1.customer_id,sub1.customer_name, sum(sub2.total_price) as sum_total
FROM (SELECT * FROM customers
			WHERE city = 'Bangkok') AS sub1
JOIN (SELECT t.*, ord.* 
      FROM transactions as t 
      JOIN orders as ord 
        ON t.order_id = ord.order_id
      WHERE STRFTIME("%Y", ord.order_date) = '2023') AS sub2
ON sub1.customer_id = sub2.customer_id
GROUP BY 1
ORDER BY 3 DESC
LIMIT 1;

-- query 4 : WITH แปลงจากsubquery ด้านบนเป็นแบบ with
-- หา id และชื่อลูกค้า ที่มียอดสั่งซื้อรวมสูงสุดของสาขา Bangkok ในปี 2023

WITH sub1 AS (SELECT * FROM customers WHERE city = 'Bangkok'),
		 sub2 AS (SELECT t.*, ord.* 
              FROM transactions as t 
              JOIN orders as ord 
                ON t.order_id = ord.order_id
              WHERE STRFTIME("%Y", ord.order_date) = '2023')

SELECT
	sub1.customer_id,
  sub1.customer_name,
  sum(sub2.total_price) as sum_total
FROM sub1
JOIN sub2 
  ON sub1.customer_id = sub2.customer_id
GROUP BY 1
ORDER BY 3 DESC
LIMIT 1;

DROP TABLE customers;
DROP TABLE menus;
DROP TABLE orders;
DROP TABLE transactions;
