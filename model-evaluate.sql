# Model evaluation. 
# This same results can be achieved from the UI clicking on the model (table) > Evaluation

SELECT
 *
FROM
 ML.EVALUATE(MODEL `project.dataset.model`) # Add here your model (treated as a table by BQ) path in the format project.ds.model
