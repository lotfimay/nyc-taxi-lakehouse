{{ config(materialized='table') }}

select
    cast(LocationID as integer) as location_id,
    borough,
    zone,
    service_zone
from {{ ref('location_zone') }}