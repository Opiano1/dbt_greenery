

with 
orders as (
    select * from {{ref('stg_orders')}}
),

promo as (
    select * from {{ref('stg_promos')}}
),

items as (
    select * from {{ref('stg_order_items')}}
)

SELECT
    orders.order_id, user_id, created_at,
    order_cost, shipping_cost,
    order_total, shipping_service, estimated_delivery_at,
    delivered_at,order_status, quantity,
    discount,promo_status

    FROM orders
    left JOIN= promo
    on orders.promo_id = promo.promo_id
    left JOIN items
    on orders.order_id = items.order_id
    