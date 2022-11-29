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


# Create (includes training) forecasting model to predict the avg temperature in Berlin, Madrid and Milano
# Model trained with daily data from 2016-07-10 to 2022-05-01; coming from NOAA's subset curated table created in the previous step

CREATE MODEL `project.dataset.table` # Add your project.ds.table path here

 OPTIONS(MODEL_TYPE='ARIMA_PLUS',
         time_series_timestamp_col='day',
         time_series_data_col='temp_avg',
         time_series_id_col='city'
  ) AS

  SELECT
    day,
    temp_avg,
    city

  FROM
    `testing-elena.DNCDD.NOAA_curated_cities`

  WHERE day < '2022-05-01'
