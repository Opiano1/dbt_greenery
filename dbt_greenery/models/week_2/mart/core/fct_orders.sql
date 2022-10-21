with orders as (
    select * from {{ ref('int_order_details') }}
),

results as (
    select
    order_id,
    user_id,
    created_at,
    order_cost,
    shipping_cost,
    order_total,
    shipping_service,
    estimated_delivery_at,
    delivered_at,
    order_status,
    quantity,
    discount,
    promo_status,
    datediff('day', created_at, estimated_delivery_at)      as est_days_to_delivery,
    datediff('day', created_at, delivered_at)               as actual_days_to_delivery,
    datediff('day', estimated_delivery_at, delivered_at)    as delivery_estimate_error

    from orders
)

select * from results