
-- Set target year and month (change as needed)
SET @target_year  = 2021;
SET @target_month = 1;   -- Used for Q4 & Q5

-- Q1. Find the revenue from each sales channel in a given year ---
SELECT
    sales_channel,
    SUM(amount) AS total_revenue
FROM clinic_sales
WHERE YEAR(datetime) = @target_year
GROUP BY sales_channel
ORDER BY total_revenue DESC;



-- Q2. Find the top 10 most valuable customers for a given year ---

SELECT
    cs.uid,
    c.name        AS customer_name,
    c.mobile,
    SUM(cs.amount) AS total_spend
FROM clinic_sales cs
JOIN customer c ON cs.uid = c.uid
WHERE YEAR(cs.datetime) = @target_year
GROUP BY cs.uid, c.name, c.mobile
ORDER BY total_spend DESC
LIMIT 10;


-- Q3. Find month-wise revenue, expense, profit, and status (Profitable / Not-Profitable) for a given year --

WITH monthly_revenue AS (
    SELECT
        MONTH(datetime)     AS month_num,
        MONTHNAME(datetime) AS month_name,
        SUM(amount)         AS total_revenue
    FROM clinic_sales
    WHERE YEAR(datetime) = @target_year
    GROUP BY MONTH(datetime), MONTHNAME(datetime)
),
monthly_expense AS (
    SELECT
        MONTH(datetime)  AS month_num,
        SUM(amount)      AS total_expense
    FROM expenses
    WHERE YEAR(datetime) = @target_year
    GROUP BY MONTH(datetime)
)
SELECT
    mr.month_num,
    mr.month_name,
    mr.total_revenue,
    COALESCE(me.total_expense, 0)                          AS total_expense,
    (mr.total_revenue - COALESCE(me.total_expense, 0))     AS profit,
    CASE
        WHEN (mr.total_revenue - COALESCE(me.total_expense, 0)) > 0
             THEN 'Profitable'
        ELSE 'Not-Profitable'
    END AS status
FROM monthly_revenue mr
LEFT JOIN monthly_expense me ON mr.month_num = me.month_num
ORDER BY mr.month_num;

-- Q4. For each city find the most profitable clinic for a given month ---

WITH clinic_revenue AS (
    SELECT
        cid,
        SUM(amount) AS revenue
    FROM clinic_sales
    WHERE YEAR(datetime)  = @target_year
      AND MONTH(datetime) = @target_month
    GROUP BY cid
),
clinic_expense AS (
    SELECT
        cid,
        SUM(amount) AS expense
    FROM expenses
    WHERE YEAR(datetime)  = @target_year
      AND MONTH(datetime) = @target_month
    GROUP BY cid
),
clinic_profit AS (
    SELECT
        cl.cid,
        cl.clinic_name,
        cl.city,
        cl.state,
        COALESCE(cr.revenue, 0)                             AS revenue,
        COALESCE(ce.expense, 0)                             AS expense,
        (COALESCE(cr.revenue, 0) - COALESCE(ce.expense, 0)) AS profit
    FROM clinics cl
    LEFT JOIN clinic_revenue cr ON cl.cid = cr.cid
    LEFT JOIN clinic_expense ce ON cl.cid = ce.cid
),
ranked AS (
    SELECT
        *,
        RANK() OVER (PARTITION BY city ORDER BY profit DESC) AS city_rank
    FROM clinic_profit
)
SELECT
    city,
    cid,
    clinic_name,
    revenue,
    expense,
    profit AS most_profitable_clinic_profit
FROM ranked
WHERE city_rank = 1
ORDER BY city;


-- Q5. For each state find the second least profitable clinic for a given month --

WITH clinic_revenue AS (
    SELECT
        cid,
        SUM(amount) AS revenue
    FROM clinic_sales
    WHERE YEAR(datetime)  = @target_year
      AND MONTH(datetime) = @target_month
    GROUP BY cid
),
clinic_expense AS (
    SELECT
        cid,
        SUM(amount) AS expense
    FROM expenses
    WHERE YEAR(datetime)  = @target_year
      AND MONTH(datetime) = @target_month
    GROUP BY cid
),
clinic_profit AS (
    SELECT
        cl.cid,
        cl.clinic_name,
        cl.city,
        cl.state,
        COALESCE(cr.revenue, 0)                              AS revenue,
        COALESCE(ce.expense, 0)                              AS expense,
        (COALESCE(cr.revenue, 0) - COALESCE(ce.expense, 0)) AS profit
    FROM clinics cl
    LEFT JOIN clinic_revenue cr ON cl.cid = cr.cid
    LEFT JOIN clinic_expense ce ON cl.cid = ce.cid
),
ranked AS (
    SELECT
        *,
        DENSE_RANK() OVER (PARTITION BY state ORDER BY profit ASC) AS state_rank
    FROM clinic_profit
)
SELECT
    state,
    cid,
    clinic_name,
    city,
    revenue,
    expense,
    profit AS second_least_profitable_clinic_profit
FROM ranked
WHERE state_rank = 2
ORDER BY state;