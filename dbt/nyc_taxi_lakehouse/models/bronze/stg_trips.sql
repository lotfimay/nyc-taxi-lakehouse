{{ config(materialized='view') }}

select 
    vendor_id,
    pickup_ts,
    dropoff_ts,
    passenger_count,
    trip_distance,
    ratecode_id,
    store_and_fwd_flag,
    pulocationid,
    dolocationid,
    payment_type,
    fare_amount,
    extra,
    mta_tax,
    tip_amount,
    tolls_amount,
    improvement_surcharge,
    total_amount,
    congestion_surcharge,
    airport_fee,
    year,
    month
from {{source('nyc_taxi', 'yellow_tripdata_2023')}}