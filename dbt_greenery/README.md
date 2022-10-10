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

Answer: 

```

with avg_distance as (    
SELECT coalesce(datediff(day, created_at, delivered_at),0) as diff
FROM DEV_DB.DBT_OPEYEMI.STG_POSTGRES__ORDERS)

select avg(diff) 
from avg_distance

```

##### Q4 - How many users have only made one purchase? Two purchases? Three+ purchases? 
Answer: 

##### Q5  - On average, how many unique sessions do we have per hour?
Answer: