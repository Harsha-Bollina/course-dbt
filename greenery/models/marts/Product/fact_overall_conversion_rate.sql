with conversion_rate as (

SELECT 
    COUNT(DISTINCT CASE WHEN event_type = 'checkout' THEN session_id END) / COUNT(DISTINCT session_id) AS overall_conversion_rate
FROM 
    {{source('postgres', 'events')}}

)

select * from conversion_rate