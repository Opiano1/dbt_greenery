with session_events_agg as (
    select * from {{ ref('int_sessions_events_agg')}}
),

users as (
    select * from {{ ref('stg_postgres__users')}}
)

SELECT
    session_id,
    users.user_id,
    first_name,
    last_name,
    email,
    page_view,
    add_to_cart,
    checkout,
    package_shipped,
    session_length_in_minutes,
    last_seen_in_days
    
    from users
    right join session_events_agg 
    on session_events_agg.user_id = users.user_id