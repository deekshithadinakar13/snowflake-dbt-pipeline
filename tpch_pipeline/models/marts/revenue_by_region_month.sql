with line_items as (
    select * from {{ ref('stg_tpch__line_items') }}
),

orders as (
    select * from {{ ref('stg_tpch__orders') }}
),

customers as (
    select * from {{ ref('stg_tpch__customers') }}
),

nations as (
    select * from {{ ref('stg_tpch__nations') }}
),

regions as (
    select * from {{ ref('stg_tpch__regions') }}
),

joined as (
    select
        regions.region_name,
        date_trunc('month', orders.order_date) as order_month,
        line_items.extended_price * (1 - line_items.discount_rate) as net_revenue
    from line_items
    join orders    on line_items.order_id  = orders.order_id
    join customers on orders.customer_id   = customers.customer_id
    join nations   on customers.nation_id  = nations.nation_id
    join regions   on nations.region_id    = regions.region_id
)

select
    region_name,
    order_month,
    sum(net_revenue) as total_revenue
from joined
group by region_name, order_month