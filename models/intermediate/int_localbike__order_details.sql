with

orders as (
    select * from {{ ref('stg_localbike__orders') }}
    where _fivetran_deleted = false
),

order_items as (
    select * from {{ ref('stg_localbike__order_items') }}
    where _fivetran_deleted = false
),

products as (
    select * from {{ ref('stg_localbike__products') }}
),

categories as (
    select * from {{ ref('stg_localbike__categories') }}
),

brands as (
    select * from {{ ref('stg_localbike__brands') }}
),

stores as (
    select * from {{ ref('stg_localbike__stores') }}
),

staffs as (
    select * from {{ ref('stg_localbike__staffs') }}
),

joined as (

    select
        -- order
        o.order_id,
        o.customer_id,
        o.order_status,
        o.order_date,
        o.required_date,
        o.shipped_date,

        -- store
        o.store_id,
        s.store_name,

        -- staff
        o.staff_id,
        st.first_name || ' ' || st.last_name as staff_full_name,

        -- item
        oi.item_id,
        oi.product_id,
        oi.quantity,
        oi.list_price,
        oi.discount,
        round(oi.quantity * oi.list_price * (1 - oi.discount), 2) as line_total,

        -- product
        p.product_name,
        p.model_year,

        -- category & brand
        c.category_name,
        b.brand_name

    from orders o
    inner join order_items oi on o.order_id = oi.order_id
    inner join products p on oi.product_id = p.product_id
    inner join categories c on p.category_id = c.category_id
    inner join brands b on p.brand_id = b.brand_id
    inner join stores s on o.store_id = s.store_id
    inner join staffs st on o.staff_id = st.staff_id

)

select * from joined
