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