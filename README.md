# GettingData-HumanActivity
Project 2 of the Getting Data course - Measuring and Identifying Human Activity

*** This process creates output files based on the experimental data described in README2.txt
*** README2.txt --> Human Activity Recognition Using Smartphones Dataset
*** Source data for files referenced below are available at:
*** https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
*** Further background is available at:
*** http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
*** See README2.txt for additional background on the experiments

===========================================================

This process produces two files derived from the orginal data set.

The first data set combines the following files:
- X_test.txt
- y_test.txt
- subject_test.txt
- X_train.txt
- y_train.txt
- subject_train.txt
into a data frame a tidy format (one row = one observation, one variable per column). This data frame contains a subset of the orginal columns - only those columns associated with the mean() or std() (standard deviation). The only thing missing is a descriptive column header. The header column is modified from the orginal to better conform to tidy data principle of "human readable" column names and made part of this data set. The files used to produce the header are:
- features.txt
- activity_labels.txt

Both the subject identifier and activity label are kept though the activity label is modified per the codebook.txt to the more descriptive activity name in place of the numeric label.

This data set has 66 of the original 561 measured and derived variables.


The second data set contains the average of each variable for each activity and each subject.


===========================================================
The complete dataset provided includes the following files:
===========================================================

- 'README.txt':		Describes this process
- 'README2.txt':	Describes the original experiement and source of data for this process
- 'tidyhumanactivity.txt'	Final "tidy" data set produced
- 'tidyhumanactivitymean.txt'	A summary of the data with means by subject and activity


==============================================
Notes from the original experiment README2.txt
==============================================

- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.
- The units used for the accelerations (total and body) are 'g's (gravity of earth -> 9.80665 m/seg2).
- The gyroscope units are rad/seg.
