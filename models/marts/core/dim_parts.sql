{{
    config(
        materialized = 'table'
    )
}}

select
    part_key,
    manufacturer,
    name,
    brand,
    type,
    size,
    container,
    retail_price
from
    {{ ref('stg_tpch_parts') }}
order by 
    part_key
