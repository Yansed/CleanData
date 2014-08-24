
# Explanation on run_analysis.R script

## Goal of the script

1. This R script reads the test data and the train data set from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones (under the same directory).
2. A complete data set is created by adding Subject and Activity for each observation and descriptive variable names are added.
3. A new tidy data set is created by taking the mean of all variables containing either "mean" or "std" from the data set created in 2. 
4. The new data set created in 3 is written to results.txt. 

## Description of the script

1. Step 1 - from the same directory, the script reads all data sets, specifically, xtrain,ytrain,xtest,ytest, subjecttest, subjecttrain, and features table. Test data and train data are combined with Activity column added.
2. Step 2 - combine data set obtained in 1 with Subject; add descriptive names from features table for the revised data set; also, created a new data set with only columns that column names contain either "mean" or "std".
3. Step 3 - for the Activity column, replaced symbols (1,2,...,6) with descriptive words;
4. Step 4 - descriptive names are already added in former steps;
5. Step 5 - use plyr and reshape2 package to aggregate the mean per activity per subject, total 180 values. In the end, write the data set obtained into result.txt. 


# Code Book of Result Dataset - "result.txt"

1. V1 - integer, 1,2,...,180, row number;
2. V2 - Factor with 6 levels as ""LAYING","SITTING","WALKING","WALKING_DOWNSTAIRS", and "WALKING_UPSTAIRS" - in alphabetic order
3. V3 - integer, 1,2, ..., 30, reprsenting 30 participants;
4. V4 - numeric, representing the mean of meansurements that contains either "mean" or "std" in column names