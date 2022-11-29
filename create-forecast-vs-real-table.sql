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


# Create a table to explore the comparison between:
# 1. the forecasted values using our created model
# 2. the values coming from the NOAA curated table, subset of NOAA's public dataset
# This query will create a table with 4 columns: city, day, forecasted_avg_temp, and real_avg_temp
# The idea is, once the table is created, click "Export > Explore with Looker Studio" to create a dashboard comparing the real values with the forecasted ones (for May-Sep 2022 approx)


# Add your project.ds.table path below (for the new table that will contain forecast results and real values from the NOAA dataset)
CREATE TABLE `project.dataset.table` AS  

  SELECT 
  model_predictions.city AS city,
  DATE_TRUNC (forecast_timestamp,DAY) AS day,
  ROUND(AVG(forecast_value),2) AS forcasted_avg_temp,
  ROUND(AVG(temp_avg),2) AS real_avg_temp

  FROM
  (  ML.FORECAST(
      MODEL `project.dataset.model`, # Add your project.ds.table path here (for the trained model (treated as a table in BQ))
      STRUCT(1000 AS HORIZON)
    ) AS model_predictions
 # Add your project.ds.table path below (curated table created previously)
 JOIN `project.dataset.table` AS NOAA_curated ON (EXTRACT(DATE FROM model_predictions.forecast_timestamp)=day) AND model_predictions.city=NOAA_curated.city)

  WHERE forecast_timestamp > '2022-04-30'

  GROUP BY city, day
  ORDER BY city, day
