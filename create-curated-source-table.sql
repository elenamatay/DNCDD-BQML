# Copyright 2022 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Create a curated -subset- table from the original NOAA GFS public dataset, in order to better visualise data for training
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
