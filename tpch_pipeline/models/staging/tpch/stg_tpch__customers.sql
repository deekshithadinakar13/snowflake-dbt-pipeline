with source as (

    select * from {{ source('tpch', 'customer') }}

),

renamed as (

    select
        c_custkey       as customer_id,
        c_name          as customer_name,
        c_nationkey     as nation_id,
        c_mktsegment    as market_segment,
        c_acctbal      as account_balance
    from source

)

select * from renamed