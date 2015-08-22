# README.md for Getting and Cleaning Data Assignment
## Overview
The assignment was to convert a large data set with smart phone readings as subjects performed various physical activities.  The data is at this [link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
The description of the [data](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) is reproduced as the codebook shown (features_info.txt). As presented it explains the underlying concepts of the study and the actual data presented as features_info.txt and features.txt.
We were asked to perform five steps:
1. Merge the training and the test sets to create one data set.
2. Extract only the measurements on the mean and standard deviation for each measurement. 
3. Use descriptive activity names to name the activities in the data set
4. Appropriately label the data set with descriptive variable names. 
5. From the data set in step 4, create a second, independent tidy data set  with the average of each variable for each activity and each subject.
## Files included in repo
*activity_labels.txt|The original translation of the Activity Factors
*CodeBook.md|The code book for this analysis
*features.txt|The listing of column names for the UCI_HAR ds
*features_info.txt|The original code book for the UCI_HAR ds
*FinalMeans.txt|The final output for the analysis: means of the mean() and std() variables
*README.txt|This document
*RevisedNames.txt|The listing of the column names in FinalMeans.txt
*Run_analysis.R|The R program that performed the analysis
*UCI_HAR_README.txt|The original READ file
## Walk through of main program run_analysis.R
### Step 1
The program sets the working directory then for each of the activity factors (y.txt), subjects (subject), and raw data (X.txt) reads a test and train version of the data the uses rbind to combine them into the internal variables y, subject, and x.  The intial column names are read from features.txt.
This pieces are then assembled into the data frame Complete, by binding the subject and y data frames to X, then adding column names 'Subject' and 'ActivityFactor' to the names listed in features.
To confirm the reliability of the data, a cross tab of the combined data by subject and activity and a sum of na values are produced.
###Step 2
The requirement to use only the "measurements on the mean and standard deviation for each measurement" is met by inspecting the variable names read from features.txt and now used as the column names of COmbined.  I choose to look for the strings "mean()" and "std()" in those strings and deem the resulting values as the statistics that would be analyized.  The resulting columns (and the subject activity columns) were used to create the Selected data set.
###Step 3 (see below)
###Step 4
For descriptive data variable names, I simplified the variable names I had been using from features.txt. The function adjustName was used to create simplified column names.
###Step 5
Using the package reshape2, I melted the Selected table to retain the ActivityFactor and Subject as seperate columns and placed all the other numeric variables in a variable column.  dcast easily converted these variables to the mean of the variable by ActivityFactor and Subject.
###Step 3
I created a small table with the ActivityFactor number (1:6) used in the data sets and a description based on activity_labels.txt.  This small table was joined with the Selected Means from dcast.  Finally, the ActivityFactor column was dropped and the final dataset FinalMeans was created.  The last step was to write out text versions of the FinalMeans and RevisedNames tables.