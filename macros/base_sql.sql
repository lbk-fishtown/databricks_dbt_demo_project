{% macro base_sql( table_name ) %}

select col_a, col_c
from {{ table_name }}

{% endmacro %}