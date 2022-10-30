with users as (
    select * from {{ ref('stg_postgres__users')}}
),

addresses as (
    select * from {{ ref('stg_postgres__addresses')}}
),

final as (
    SELECT
        user_id,
        first_name,
        last_name,
        email,
        phone_number,
        created_at,
        updated_at,
        address,
        country,
        zipcode
   
    from users a
    left join addresses b
    on a.address_id = b.address_id
)

select * from final