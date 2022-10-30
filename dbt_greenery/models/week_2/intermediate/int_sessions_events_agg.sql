with events as (
    select * from {{ ref('stg_postgres__events')}}
)

, final as (
    select
        user_id,
        session_id,
        sum(case when event_type = 'add_to_cart' then 1 else 0 end) as add_to_cart,
        sum(case when event_type = 'checkout' then 1 else 0 end) as checkout,
        sum(case when event_type = 'package_shipped' then 1 else 0 end) as package_shipped,
        sum(case when event_type = 'page_view' then 1 else 0 end) as page_view,
        min(created_at) as session_start,
        max(created_at) as session_end,
        datediff('minutes', session_start, session_end) as session_length_in_minutes,
        datediff('days', session_end, current_timestamp()) as last_seen_in_days
    
    from events
   {{ dbt_utils.group_by(2) }}
)

select * from final