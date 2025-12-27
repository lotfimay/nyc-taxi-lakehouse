{{
    config(materialized='table')
}}

with base as (
    select *
    from {{ ref('stg_trips') }}
),

filtered as (
    select *,
           date_diff('minute', pickup_ts, dropoff_ts) as trip_duration_minutes
    from base
    where
        pickup_ts is not null
    and dropoff_ts is not null
    and dropoff_ts >= pickup_ts

       
    and trip_distance > 0
    and passenger_count > 0
    and total_amount is not null
    and year = 2023

    and fare_amount >= 0
    and tip_amount >= 0
    and tolls_amount >= 0
    and improvement_surcharge >= 0
    and congestion_surcharge >= 0
    and extra >= 0
    and mta_tax >= 0
    and airport_fee >= 0
    and total_amount > 0       
),

final as (
    select
        vendor_id,
        pickup_ts,
        dropoff_ts,

        (trip_distance * 1.60934) as trip_distance_km,

        passenger_count,
        payment_type,
        ratecode_id,
        store_and_fwd_flag,
        pulocationid,
        dolocationid,

        fare_amount,
        tip_amount,
        tolls_amount,
        improvement_surcharge,
        congestion_surcharge,
        extra,
        mta_tax,
        airport_fee,
        total_amount,

        year,
        month,
        trip_duration_minutes,

        case
            when trip_duration_minutes > 0
                then (trip_distance * 1.60934) / (trip_duration_minutes / 60.0)
            else null
        end as avg_speed_kmh,

        case
            when airport_fee > 0 then true
            else false
        end as is_airport_trip

    from filtered
    where trip_duration_minutes between 1 and 24 * 60
)

select *
from final
