### Week 1 Assignemts

##### Q1  - How many users do we have?

Answer : 130 users

```

select count(user_id) 

from DEV_DB.DBT_OPEYEMI.STG_POSTGRES__USERS

```

##### Q2 - On average, how many orders do we receive per hour?

Answer: 15.04

```

with average_order as (
    
SELECT hour(created_at) as order_hour, count(*) as order_count
FROM DEV_DB.DBT_OPEYEMI.STG_POSTGRES__ORDERS
group by order_hour

)

select avg(order_count) as avg_order_count
from average_order

```

##### Q3 - On average, how long does an order take from being placed to being delivered?

Answer: 3.288089

```

with avg_distance as (    
SELECT coalesce(datediff(day, created_at, delivered_at),0) as diff
FROM DEV_DB.DBT_OPEYEMI.STG_POSTGRES__ORDERS)

select avg(diff) 
from avg_distance

```

##### Q4 - How many users have only made one purchase? Two purchases? Three+ purchases? 
Answer: 

+ One purchase - 25
+ Two purchases - 28 
+ Three+ purchases - 71



```

with prod_order as (

select order_id, count(product_id) as prod_ct 
from DEV_DB.DBT_OPEYEMI.STG_POSTGRES__ORDER_ITEMS
group by 1 
    
),

user_order as (
    
    select user_id, count(*) as purchases
    from DEV_DB.DBT_OPEYEMI.STG_POSTGRES__ORDERS orders
    join prod_order pod
    on orders.order_id = pod.order_id
    group by 1 
    order by 2 desc
)

select sum(case when purchases=1 then 1 else 0 end) as one_purchase,
sum(case when purchases=2 then 1 else 0 end) as two_purchase,
sum(case when purchases>=3 then 1 else 0 end) as three_plus_purchase,
one_purchase + two_purchase + three_plus_purchase
from user_order

```

##### Q5  - On average, how many unique sessions do we have per hour?
Answer: 148.041667

```

select avg(session_count) as avg_sessions
from (SELECT hour(created_at) as session_hour, count(*) as session_count
from DEV_DB.DBT_OPEYEMI.STG_POSTGRES__EVENTS
group by 1
     ) sessions

```