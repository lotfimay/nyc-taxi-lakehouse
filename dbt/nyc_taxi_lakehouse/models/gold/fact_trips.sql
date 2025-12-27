{{ config(materialized='table') }}

with src as (
    select *
    from {{ ref('trips') }}
)

select
    
    {{ sk([
        'vendor_id',
        'pickup_ts',
        'dropoff_ts',
        'pulocationid',
        'dolocationid',
        'total_amount'
    ]) }} as trip_id,

    pickup_ts,
    dropoff_ts,

    
    cast(date_format(date(pickup_ts),  '%Y%m%d') as int)  as pickup_date_id,
    cast(date_format(date(dropoff_ts), '%Y%m%d') as int)  as dropoff_date_id,

    
    (hour(pickup_ts)  * 60 + minute(pickup_ts))  as pickup_time_id,
    (hour(dropoff_ts) * 60 + minute(dropoff_ts)) as dropoff_time_id,

   
    pulocationid as pickup_location_id,
    dolocationid as dropoff_location_id,

    
    payment_type as payment_type_id,
    ratecode_id  as rate_code_id,
    vendor_id,

    
    trip_distance_km,
    trip_duration_minutes,
    avg_speed_kmh,
    passenger_count,

    fare_amount,
    tip_amount,
    tolls_amount,
    improvement_surcharge,
    congestion_surcharge,
    extra,
    mta_tax,
    airport_fee,
    total_amount,

    is_airport_trip

from src
