#### Week 3 Assessment 

###### Q1 

1. What is our overall conversion rate?

Overall Conversion rate is approximately 62.5%

```

with purchase_sessions as (
    SELECT SUM(Num_orders) sessions_with_orders
        , COUNT(SESSION_ID) total_sessions
        , ROUND(sessions_with_orders/total_sessions,3) as conversion_rate
FROM DEV_DB.DBT_ACHEN.INT_SESSION_AGG
)

```


2.  What is our conversion rate by product?

#### Part 2: Macro

Create a macro to grant permissions and test positive values


#### Part 5: Snapshot 

Which orders changed from week 2 to week 3 after running dbt snapshot
8385cfcd-2b3f-443a-a676-9756f7eb5404
e24985f3-2fb3-456e-a1aa-aaf88f490d70
5741e351-3124-4de7-9dff-01a448e7dfd4