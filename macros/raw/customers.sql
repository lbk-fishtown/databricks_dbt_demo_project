{% macro create_customers_dim() %}

{% set query =  
[
    'CREATE OR REPLACE TEMPORARY VIEW tmpCustomers AS
    select * from `sa_dev`.`dbt_au_lbkfishtown`.`stg_tpch_customers`;',
    'CREATE OR REPLACE TEMPORARY VIEW tmpNations AS
    select * from `sa_dev`.`dbt_au_lbkfishtown`.`stg_tpch_nations`;',
    'CREATE OR REPLACE TEMPORARY VIEW tmpRegions AS
    select * from `sa_dev`.`dbt_au_lbkfishtown`.`stg_tpch_regions`;',
    'CREATE OR REPLACE table `sa_dev`.`dbt_au_lbkfishtown`.`demo_dim_customers` 
    USING DELTA AS

    with customer as (
        select * from `tmpCustomers`
    ),
    nation as (
        select * from `tmpNations`
    ),
    region as (
        select * from `tmpRegions`
    )

    select 
        customer.customer_key,
        customer.name,
        customer.address,
        nation.name as nation,
        region.name as region,
        customer.phone_number,
        customer.account_balance,
        customer.market_segment
    from
        customer
        inner join nation
            on customer.nation_key = nation.nation_key
        inner join region
            on nation.region_key = region.region_key
    order by
        customer_key;'
]
%}

{% if execute %}
    {% for q in query %}
        {% do run_query(q) %}
    {% endfor %}    
{% endif %}

{% endmacro %}


  