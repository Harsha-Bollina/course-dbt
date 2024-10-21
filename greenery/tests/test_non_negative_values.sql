WITH invalid_records AS (
    SELECT
        product_id,
        event_date,
        daily_page_views,
        daily_orders,
        price
    FROM {{ model }}
    WHERE 
        daily_page_views < 0
        OR daily_orders < 0
        OR price < 0
)

SELECT * FROM invalid_records