CREATE SCHEMA IF NOT EXISTS hive.raw;

CREATE TABLE hive.raw.yellow_tripdata_2023 (
    vendorid                varchar,
    tpep_pickup_datetime    varchar,
    tpep_dropoff_datetime   varchar,
    passenger_count         varchar,
    trip_distance           varchar,
    ratecodeid              varchar,
    store_and_fwd_flag      varchar,
    pulocationid            varchar,
    dolocationid            varchar,
    payment_type            varchar,
    fare_amount             varchar,
    extra                   varchar,
    mta_tax                 varchar,
    tip_amount              varchar,
    tolls_amount            varchar,
    improvement_surcharge   varchar,
    total_amount            varchar,
    congestion_surcharge    varchar,
    airport_fee             varchar
)
WITH (
    external_location = 's3://nyc-taxi/raw/yellow_tripdata/2023/',
    format = 'CSV',
    skip_header_line_count = 1
);
