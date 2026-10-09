with source as (

    select * from {{ source('tpch', 'lineitem') }}

),

renamed as (

    select
        l_orderkey || '-' || l_linenumber as line_item_id,
        l_orderkey      as order_id,
        l_linenumber    as line_number,
        l_partkey       as part_id,
        l_quantity      as quantity,
        l_extendedprice as extended_price,
        l_discount      as discount_rate,
        l_tax           as tax_rate,
        l_returnflag    as return_flag,
        l_shipdate      as ship_date
    from source

)

select * from renamed