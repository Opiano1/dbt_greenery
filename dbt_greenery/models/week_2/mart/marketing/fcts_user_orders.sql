with users as (
    select *
 from {{ ref('stg_postgres__users') }}

),

orders as (
    select
        user_id,
        count(*) as order_count,
        sum(order_total) as spend_lifetime,
        sum(quantity) as units_lifetime,
        min(created_at) as first_order,
        max(created_at) as latest_order

    from {{ ref('fct_orders') }}
    group by user_id

)

select    
    u.user_id,
    first_name,
    last_name,
    order_count,
    email,
    phone_number,
    u.created_at as user_registration,
    zeroifnull(spend_lifetime) as lifetime_spend,
    zeroifnull(units_lifetime) as lifetime_units,
    o.first_order,
    o.latest_order

    from users u
    left join orders o
    on u.user_id = o.user_id