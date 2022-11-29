# DNCDD-BQML
BigQuery ML demo presented at the Digital Natives Cloud Developer Day in Berlin, November 2022.

![image](https://user-images.githubusercontent.com/47299995/204466995-65a2fff9-bd5a-4e5c-8053-d254d7b3db52.png)

This demo included:
- Preparing the training data in BigQuery
- Training and evaluating a time-series model with BigQuery ML
- Visualising the forecasts in a Looker Studio dashboard
- Scheduling and automate model retraining


The code included in this repo covers the first two points + comparing the model results (average temperature forecast) with the real values (coming from the [NOAA GFS public dataset](http://console.cloud.google.com/marketplace/product/noaa-public/gfs))  in order to visualise them in LookerStudio later

Logical order of the files:
1. curated-table-create.sql
2. model-create.sql
3. model-evaluate.sql
4. model-predict.sql
5. create-forecast-vs-real-table.sql
