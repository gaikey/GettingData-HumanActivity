## This code combines a subset of test and training data into:
	## two .csv files with descriptive feature names
		## For the feature "activity" use the name of the activity in place of the number ID 
	## One .csv file contains all features that have a name containing either "mean()" or "stdev()"
	## The other .csv file that aggregates on the features, "activity" and "subject" returning the mean
## The following code will work if you have the following files in <working directory>/
## The files are obtained from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
	## features.txt
	## X_test.txt
	## y_test.txt
	## subject_test.txt
	## X_train.txt
	## y_train.txt
	## subject_train.txt
	## activity_labels.txt

library(plyr)
library(dplyr)
library(stringr)

## Extract feature names and add "subject" and "activity"
featureheader <- read.table("./features.txt", sep = "", header = F, col.names = c("findex","features"))
fhtbl <- tbl_df(featureheader)
fh <- select (fhtbl, features)
features <- c("subject", "activity")
features <- data.frame(features)
fhall <- rbind(features, fh)

## Combine the subject, activity and feature values for test data
xtest <- read.table("./X_test.txt", sep = "", header = F)
ytest <- read.table("./y_test.txt", sep = "", header = F)
subjecttest <- read.table("./subject_test.txt", sep = "", header = F)
alltest <- cbind(subjecttest, ytest, xtest)

## Combine the subject, activity and feature values for training data
xtrain <- read.table("./X_train.txt", sep = "", header = F)
ytrain <- read.table("./y_train.txt", sep = "", header = F)
subjecttrain <- read.table("./subject_train.txt", sep = "", header = F)
alltrain <- cbind(subjecttrain, ytrain, xtrain)

## Extract the activity "number" and associated activity name
activitylabels <- read.table("./activity_labels.txt", sep = "", header = F)
colnames(activitylabels) <- c("activity","activityname")

## Combine training and test data
alldata <- rbind(alltrain, alltest)

## Add on original provided column names and modify "subject" to a factor
colnames(alldata) <- t(fhall)
alldata$subject <- as.factor(alldata$subject)

## Find all features with "mean(" and "std("
meanstd <- union(grep("mean\\(", colnames(alldata)), grep("std\\(", colnames(alldata)))
## Add the "activity" and "subject" to the returned column names
meanstd <- c(1, 2, meanstd)

## Create the subsetted data frame with only the desired features
meanstddata <- alldata[,meanstd]

## Update the Activity to the name instead of the associated number
updateactivity <- select(merge(activitylabels, meanstddata), activityname)
meanstddata$activity <- updateactivity$activityname

## Update Column Names - Make them more "human readable"
col_ms <- colnames(meanstddata)
col_ms <- gsub("^t", "Time", col_ms)
col_ms <- gsub("^f", "Freq", col_ms)
col_ms <- gsub("mean", "Mean", col_ms)
col_ms <- gsub("std", "Stddev", col_ms)
col_ms <- gsub("-", "", col_ms)
col_ms <- gsub("\\(", "", col_ms)
col_ms <- gsub("\\)", "", col_ms)
colnames(meanstddata) <- col_ms

## Write first data set to .csv file
## write.csv(meanstddata, file = "./tidyHumanActivityData.csv", row.names = F)

## Create a second data set that returns the average by activity and subject
msdfactors <- list(activity = meanstddata$activity, subject = meanstddata$subject)
msdmeansbyactivityandsubject <- aggregate(meanstddata[, 3:68], msdfactors, mean)
## write.csv(msdmeansbyactivityandsubject, file = "./tidyHumanActivityDataAverageByActivityAndSubject.csv", row.names = F)
write.table(msdmeansbyactivityandsubject, file = "./tidyHumanActivityDataAverageByActivityAndSubject.txt", row.names = F)