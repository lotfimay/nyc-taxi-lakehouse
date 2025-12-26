select *
from {{ source('nyc_taxi', 'yellow_tripdata_2023')}}