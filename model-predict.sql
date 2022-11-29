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


# With this query we will predict the first 150 datapoints (150 days) using our trained forecast model.

# If we changed the function "ML.FORECAST" for "ML.EXPLAIN_FORECAST", BQ would return a superset of the result of this query. 
# With such superset we would receive more information on the forecast made by our model. 
# E.g.  we would see that the -nonsense- weekly seasonality detected is negligible (as opposed to the yearly one).


SELECT 
  *

FROM
  ML.FORECAST(
    MODEL `project.dataset.model`,  # Add your project.ds.table path here for the trained model (treated as a table in BQ)
    STRUCT(150 AS HORIZON)
  )
