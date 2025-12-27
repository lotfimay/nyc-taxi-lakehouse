{{ config(materialized='table') }}


with bounds as (
    select
        date(min(pickup_ts)) as start_date,
        date(max(pickup_ts)) as end_date
    from {{ ref('trips') }}
),

date_spine as (
    select d as date_day
    from bounds,
    unnest(
        sequence(start_date, end_date, interval '1' day)
    ) as t(d)
)

select
    cast(date_format(date_day, '%Y%m%d') as integer) as date_id,

    date_day as date,

    year(date_day)  as year,
    month(date_day) as month,
    day(date_day)   as day,

    quarter(date_day) as quarter,

    day_of_week(date_day) as day_of_week,   -- 1 = Monday

    format_datetime(date_day, 'EEEE')  as day_name,
    format_datetime(date_day, 'MMMM')  as month_name,

    case when day_of_week(date_day) in (6, 7)
         then true else false end as is_weekend

from date_spine
order by date_day
