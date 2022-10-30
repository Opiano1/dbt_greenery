with order_item_events as (
    select  
         coalesce(oi.product_id, e.product_id) product_guid_coalesce
        , e.event_id 
        , e.session_id
        , e.user_id
        , e.page_url
        , e.created_at
        , e.event_type
    from {{ref('stg_postgres__order_items')}} oi
    full outer join {{ ref('stg_postgres__events') }} e
        on oi.order_id = e.order_id
)

select 
    {{ dbt_utils.surrogate_key(['product_guid_coalesce', 'event_id']) }} as surrogate_key
    , product_guid_coalesce
    , event_id 
    , session_id
    , user_id
    , page_url
    , created_at
    , event_type
from order_item_events
