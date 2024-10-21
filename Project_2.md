##### 1) What is our user repeat rate?
 0.798387
``` with user_order_counts as (
select user_id, count(order_id) as order_count from stg_postgres_orders
group by user_id)

select sum(case when order_count > 1 then 1 else 0 end) * 1.0 / count(*) as repeat_rate from user_order_counts
 ```
#####  2) What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?
1. Likely to purchase indicators: How frequesnt a customer is ordering and total spend amount by each customer.
2. Not likely to purchase indicators: Extended delivery periods, Order returns/cancellations
3. Features I would add: Customer Demographics, Impressions data (Interaction data like Products viewed, time spent etc)

##### 3) Within each marts folder, create intermediate models and dimension/fact models.
Created fact_page_views model in the Product mart.

##### 4) Explain the product mart models you added. Why did you organize the models in the way you did?
it aggregates daily product page views and orders. It processes the events table to filter out page view events, count daily orders per product, and calculate the number of daily page views for each product. The model then joins this data with the products table to enrich it with product details such as name and price. The final output provides daily page views and orders for each product, allowing for an assessment of traffic patterns, conversion rates, and overall product performance insights.

##### 5) Use the dbt docs to visualize your model DAGs to ensure the model layers make sense

<img width="1705" alt="Screenshot 2024-10-20 at 10 48 34 PM" src="https://github.com/user-attachments/assets/2435ccc7-7c0f-4295-921c-cfef29eb130d">

##### 6) TESTS
##### Added a test for the model i created: test_non_negative_values.sql

<img width="320" alt="Screenshot 2024-10-20 at 11 13 39 PM" src="https://github.com/user-attachments/assets/13ef166d-5b65-436a-8762-2355dfb7c5c1">


then added it to the model, this way


<img width="507" alt="Screenshot 2024-10-20 at 11 14 03 PM" src="https://github.com/user-attachments/assets/5371a345-1cb8-42e2-ac15-46a879d35a92">

##### Your stakeholders at Greenery want to understand the state of the data each day. Explain how you would ensure these tests are passing regularly and how you would alert stakeholders about bad data getting through?
By creating multiple tests that checks data quality and then scheduling them.



