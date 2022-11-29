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
