# Create a curated -subset- table from the original NOAA GFS public dataset
# This curated table will just include 3 geopoints or cities, and their avgerage temperature each day
# WARNING: This query should process ~27.13 TB when run

CREATE OR REPLACE TABLE `project.dataset.table` PARTITION BY day CLUSTER BY city  # Add your project.ds.table path here
AS
  SELECT
    CASE 
      WHEN ST_WITHIN(geography, ST_GEOGFROMTEXT('POINT(-3.75 40.5)')) THEN "Madrid"
      WHEN ST_WITHIN(geography, ST_GEOGFROMTEXT('POINT(13.5 52.5)')) THEN "Berlin"
      WHEN ST_WITHIN(geography, ST_GEOGFROMTEXT('POINT(9.25 45.5)')) THEN "Milano"
    END AS city,
    DATE(forecast.time) AS day,
    AVG(forecast.temperature_2m_above_ground) AS temp_avg, 
   
  FROM `bigquery-public-data.noaa_global_forecast_system.NOAA_GFS0P25`
  CROSS JOIN
    `bigquery-public-data.noaa_global_forecast_system.NOAA_GFS0P25`.forecast
  
  WHERE 
    ST_WITHIN(geography, ST_GEOGFROMTEXT('POINT(-3.75 40.5)')) OR 
    ST_WITHIN(geography, ST_GEOGFROMTEXT('POINT(13.5 52.5)')) OR
    ST_WITHIN(geography, ST_GEOGFROMTEXT('POINT(9.25 45.5)'))
  
  GROUP BY day, city
