##### 1) What is our user repeat rate?
##### A) 0.798387
``` with user_order_counts as (
select user_id, count(order_id) as order_count from stg_postgres_orders
group by user_id)

select sum(case when order_count > 1 then 1 else 0 end) * 1.0 / count(*) as repeat_rate from user_order_counts
 ```
#####  ) What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?
##### A)1. Likely to purchase indicators: How frequesnt a customer is ordering and total spend amount by each customer.
2. Not likely to purchase indicators: Extended delivery periods, Order returns/cancellations
3. Features I would add: Customer Demographics, Impressions data (Interaction data like Products viewed, time spent etc)




