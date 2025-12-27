{{ config(materialized='table') }}

with minutes as (
    select seq as minute_of_day
    from unnest(sequence(0, 1439)) as t(seq)
)

select
    minute_of_day as time_id,

    floor(minute_of_day / 60) as hour,
    minute_of_day % 60        as minute,

    format(
        '%02d:%02d',
        floor(minute_of_day / 60),
        minute_of_day % 60
    ) as time_hhmm,

    case
        when floor(minute_of_day / 60) between 0  and 5  then 'Night'
        when floor(minute_of_day / 60) between 6  and 11 then 'Morning'
        when floor(minute_of_day / 60) between 12 and 17 then 'Afternoon'
        else 'Evening'
    end as time_of_day

from minutes
order by minute_of_day
