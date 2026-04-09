-- Q1. For every user in the system, get the user_id ans last booked room_no --

SELECT 
  u.user_id,
  u.name,
  b.room_no as last_booked_room_no 
  b.booking_date as last_booking_date 
FROM users u 
JOIN (
    SELECT 
      user_id,
      room_no,
      booking_date,
      ROW_NUMBER() OVER ( PARTITION BY user_id ORDER BY booking_date DESC) as rn 
    FROM bookings  
)  b ON u.user_id = b.user_id 
WHERE b.rn= 1;


--- Q2. Get booking_id and total billing amount of every booking created in NOVEMBER 2021 ---

SELECT 
   bk.booking_id,
   SUM(bc.item_quantity * i.item_rate) as total_billing_amount
FROM bookings bk 
JOIN booking_commercials bc ON bk.booking_id = bc.booking_id
JOIN items i  ON bc.item_id = i.item_id
WHERE YEAR(bk.booking_date) = 2021 
 AND MONTH(bk.booking_date) = 11 
GROUP BY bk.booking_id; 


--- Q3. Get bill_id and bill amount of all bills raised in October 2021 having bill amount > 1000 ---

SELECT 
  bc.bill_id,
  SUM(bc.item_quantity*i.item_rate) as bill_amount
FROM booking_commercials bc
JOIN items i ON bc.item_id = i.item_id
WHERE YEAR(bc.bill_date) =2021 
 AND  MONTH(bc.bill_date) = 10 
GROUP BY bc.bill_id 
HAVING SUM(bc.item_quantity*i.item_rate) > 1000;


--- Q4. Determine the most ordered and least ordered item of each month of year 2021 --- 

WITH monthly_item_totals AS (
    SELECT 
      MONTH(bc.bill_date) as month_num,
      MONTHNAME(bc.bill_date) as month_name,
      i.item_id,
      i.item_name,
      SUM(bc.item_quantity) as total_quantity
    FROM booking_commercials bc 
    JOIN items i ON bc.item_id = i.item_id 
    WHERE YEAR(bc.bill_date) = 2021 
    GROUP BY MONTH(bc.bill_date),MONTHNAME(bc.bill_date), i.item_id,i.item_name
),

ranked as (
    SELECT 
      month_num,
      month_name,
      item_name,
      total_quantity,
      RANK() OVER(PARTITION BY month_num ORDER BY total_quantity DESC) as rank_most,
      RANK() OVER(PARTITION BY month_num ORDER BY total_quantity ASC) as rank_least
    FROM monthly_item_totals
)
SELECT
  month_name,
  MAX(CASE WHEN rank_most = 1 THEN CONCAT(item_name,' ( ',total_quantity,')') END) AS most_ordered_item,
  MAX(CASE WHEN rank_least = 1 THEN CONCAT(item_name, ' (', total_quantity,')') END) AS least_ordered_item 
FROM ranked
GROUP BY month_num,month_name
ORDER BY month_num;


--- Q5. Find customers with the second highest bill value of each month of year 2021 ---

WITH user_monthly_bills AS ( 
    SELECT 
      MONTH(bc.bill_date) as month_num,
      MONTHNAME(bc.bill_date) AS month_name,
      bk.user_id,
      u.name,
      SUM(bc.item_quantity*i.item_rate) as total_bill
    FROM booking_commercials bc
    JOIN bookings bk ON bc.booking_id = bk.booking_id
    JOIN users u ON bk.user_id = u.user_id
    JOIN items i ON bc.item_id = i.item_id
    WHERE YEAR(bc.bill_date) = 2021 
    GROUP BY MONTH(bc.bill_date),MONTHNAME(bc.bill_date), bk.user_id,u.name 
),
ranked_bills AS (
    SELECT 
       month_num,
       month_name,
       user_id,
       name,
       total_bill,
       DENSE_RANK() OVER(PARTITION BY month_num ORDER BY total_bill DESC) AS bill_rank
    FROM user_monthly_bills
)       
SELECT
  month_name,
  user_id,
  name as customer_name,
  total_bill as second_highest_bill_value 
FROM ranked_bills
WHERE bill_rank = 2 
ORDER BY month_num;  

