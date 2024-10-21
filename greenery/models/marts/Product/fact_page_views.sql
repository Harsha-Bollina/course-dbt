
WITH page_view_events as (

SELECT
        event_id,
        session_id,
        user_id,
        event_type,
        page_url,
        created_at::date AS event_date,
        order_id,
        product_id
FROM {{ ref('stg_postgres_events')}} WHERE event_type = 'page_view' ), 

orders_by_product AS (
    
    SELECT
        product_id,
        created_at::date AS order_date,
        COUNT(order_id) AS order_count
    FROM {{ ref('stg_postgres_events') }}
    WHERE event_type = 'order' GROUP BY product_id, order_date ),

daily_page_views AS (

    SELECT
        product_id,
        event_date,
        COUNT(event_id) AS daily_page_views
    FROM page_view_events
    GROUP BY product_id, event_date ),

combined_data AS (
    SELECT
        p.name AS product_name,
        p.price,
        pv.product_id,
        pv.event_date AS date,
        pv.daily_page_views,
        COALESCE(o.order_count, 0) AS daily_orders
    FROM daily_page_views pv
    LEFT JOIN orders_by_product o
    ON pv.product_id = o.product_id AND pv.event_date = o.order_date
    LEFT JOIN {{ ref('stg_postgres_products') }} p
    ON pv.product_id = p.product_id
)

SELECT
    product_id,
    product_name,
    price,
    date,
    daily_page_views,
    daily_orders
FROM combined_data
ORDER BY date, product_id