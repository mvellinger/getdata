#Variables

## raw data

* **activityLabels** - dataframe, raw data, from activity.labels.txt
* **featureLabels** - dataframe, raw data from feature.labels.xt
* **testData** - dataframe, raw data, from X_test.txt
* **trainData** - dataframe, raw data, from X_train.txt
* **testActivities** - dataframe, raw data, from y_test.txt
* **trainActivities** - dataframe, raw data, from y_train.txt
* **testSubjects** - dataframe, raw data, from subject_test.txt
* **trainSubjects** - dataframe, raw data, from subject_train.txt

## intermediate products

* **subsetTestData** - dataframe, subset of *testData* (mean and std columns only)
* **subsetTrainData** - dataframe, subset of *trainData* (mean and std columns only)

* **data1** - dataframe, *subsetTestData* merged with processed *testActivities*
* **data2** - dataframe, *subsetTrainData* merged with processed *trainActivities*

* **data** - dataframe, *data1* and *data2* combined by row.

* **dataMelt** - *melt()* of data, using *ids* and *vars* vectors


## vectors

* **ids** - character vector, contains the column names for *subjectID* and *activityName*
* **vars** - character vector, contains the remaining column names
* **oldColumnNames** - character vector, contains original column names
* **fix** - character vector, contains column names, with measures appended by "AVG"

## end product

* **recast** - dataframe, our end product, arranged by *subjectID* and *activityName*
