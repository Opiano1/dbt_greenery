WITH order_items as (
    SELECT * FROM {{ref('stg_postgres__order_items')}}
)

, products as (
    SELECT * FROM {{ref('stg_postgres__products')}}
)

, orders as (
    SELECT * FROM {{ref('stg_postgres__orders')}}
)

SELECT 
    i.product_id
    , p.product_name
    , p.price
    , COUNT(distinct i.order_id) as num_orders
    , SUM(i.quantity) as num_quantity_purchased
    , p.price * SUM(i.quantity) as revenue
    , min(date(created_at)) as product_first_purchase_date
    , max(date(created_at)) as product_most_recent_purchase_date
FROM order_items i
LEFT JOIN products p on i.product_id = p.product_id 
LEFT JOIN orders o on o.order_id = i.order_id
GROUP BY 1,2,3