### All queries ran in snowflake env
### Database: DEV_DB
### schema: DBT_HBOLLINAPUBLICSTORAGECOM

### 1) How many users do we have?
```select count(*) as number_of_users from stg_postgres_users; ```
##### Ans: 130

### 2) On average, how many orders do we receive per hour?
``` WITH orders_per_hour AS (
    SELECT 
        EXTRACT(DAY FROM CREATED_AT) AS day,
        EXTRACT(MONTH FROM CREATED_AT) AS month,
        EXTRACT(YEAR FROM CREATED_AT) AS year,
        EXTRACT(HOUR FROM CREATED_AT) AS hour,
        COUNT(order_id) AS orders_count
    FROM 
        stg_postgres_orders GROUP BY 1,2,3,4       
)

SELECT 
    AVG(orders_count) AS avg_orders_per_hour
FROM 
    orders_per_hour;
```
##### Ans: 7.520833

### 3)On average, how long does an order take from being placed to being delivered?
```SELECT 
    AVG(DATEDIFF('second', created_at, delivered_at)) / 3600 AS avg_time_to_delivery_hours
FROM 
    stg_postgres_orders
WHERE 
    delivered_at IS NOT NULL;
```
##### Ans: 93.4032 hrs

### 4) How many users have only made one purchase? Two purchases? Three+ purchases?
```WITH user_purchases AS (
    SELECT user_id, COUNT(order_id) AS purchase_count
    FROM stg_postgres_orders
    GROUP BY user_id
)

SELECT purchase_count,COUNT(user_id) AS num_users
FROM user_purchases WHERE purchase_count IN (1, 2)
GROUP BY purchase_count

UNION ALL

SELECT 3 AS purchase_count,  COUNT(user_id) AS num_users
FROM user_purchases
WHERE purchase_count >= 3;
```
##### Ans: 1 purchase 25 users, 2 purchase 28 users, 3 purchase 71 users

### 5) On average, how many unique sessions do we have per hour?
``` WITH sessions_per_hour AS (
    SELECT 
        EXTRACT(YEAR FROM created_at) AS year,
        EXTRACT(MONTH FROM created_at) AS month,
        EXTRACT(DAY FROM created_at) AS day,
        EXTRACT(HOUR FROM created_at) AS hour,
        COUNT(DISTINCT session_id) AS unique_sessions
    FROM 
        stg_postgres_events
    GROUP BY 1,2,3,4
)

SELECT 
    AVG(unique_sessions) AS avg_unique_sessions_per_hour
FROM 
    sessions_per_hour
```
##### Ans:16.32




