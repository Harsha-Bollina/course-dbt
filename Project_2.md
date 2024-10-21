##### 1) What is our user repeat rate?
##### A) 0.798387
``` with user_order_counts as (
select user_id, count(order_id) as order_count from stg_postgres_orders
group by user_id)

select sum(case when order_count > 1 then 1 else 0 end) * 1.0 / count(*) as repeat_rate from user_order_counts ```

   
