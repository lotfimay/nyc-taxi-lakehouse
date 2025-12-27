{{ config(materialized='table') }}

select
    cast(payment_type_id as integer) as payment_type_id,
    payment_type_desc
from {{ ref('payment_type') }}
