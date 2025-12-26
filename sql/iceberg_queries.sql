CREATE SCHEMA IF NOT EXISTS iceberg.bronze;
CREATE SCHEMA IF NOT EXISTS iceberg.silver;
CREATE SCHEMA IF NOT EXISTS iceberg.gold;


CREATE TABLE iceberg.bronze.yellow_tripdata_2023
WITH (
    partitioning = ARRAY['year', 'month']
) AS
SELECT
    TRY_CAST(vendorid AS integer)                                         AS vendor_id,

    CAST(
      date_parse(tpep_pickup_datetime, '%m/%d/%Y %I:%i:%s %p')
      AS timestamp
    )                                                                     AS pickup_ts,

    CAST(
      date_parse(tpep_dropoff_datetime, '%m/%d/%Y %I:%i:%s %p')
      AS timestamp
    )                                                                     AS dropoff_ts,

    TRY_CAST(passenger_count AS integer)                                  AS passenger_count,
    TRY_CAST(trip_distance AS double)                                     AS trip_distance,
    TRY_CAST(ratecodeid AS integer)                                       AS ratecode_id,
    store_and_fwd_flag                                                    AS store_and_fwd_flag,
    TRY_CAST(pulocationid AS integer)                                     AS pulocationid,
    TRY_CAST(dolocationid AS integer)                                     AS dolocationid,
    TRY_CAST(payment_type AS integer)                                     AS payment_type,

    TRY_CAST(fare_amount AS double)                                       AS fare_amount,
    TRY_CAST(extra AS double)                                             AS extra,
    TRY_CAST(mta_tax AS double)                                           AS mta_tax,
    TRY_CAST(tip_amount AS double)                                        AS tip_amount,
    TRY_CAST(tolls_amount AS double)                                      AS tolls_amount,
    TRY_CAST(improvement_surcharge AS double)                             AS improvement_surcharge,
    TRY_CAST(total_amount AS double)                                      AS total_amount,
    TRY_CAST(congestion_surcharge AS double)                              AS congestion_surcharge,
    TRY_CAST(airport_fee AS double)                                       AS airport_fee,

    year(
      CAST(date_parse(tpep_pickup_datetime, '%m/%d/%Y %I:%i:%s %p') AS timestamp)
    )                                                                     AS year,

    month(
      CAST(date_parse(tpep_pickup_datetime, '%m/%d/%Y %I:%i:%s %p') AS timestamp)
    )                                                                     AS month

FROM hive.raw.yellow_tripdata_2023;