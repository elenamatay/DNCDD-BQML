# Add your project.ds.table path below (for the new table that will contain forecast results and real values from the NOAA dataset)
CREATE OR REPLACE TABLE `project.dataset.table` AS  

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
