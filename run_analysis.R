## Tidy Data Set Project
##
## This script performs the steps necessary to create the tidy data set for the "Getting and Cleaning Data" course

if (!file.exists("./TidyData")) {dir.create("./TidyData")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata##2Fprojectfiles##2FUCI##20HAR##20Dataset.zip";
destfilename <- "./TidyData/Dataset.zip";
download.file(fileUrl, destfile = destfilename, method = "curl");

## unzipped manually; command below doesn't work
unzip(zipfile = destfilename, list = FALSE, overwrite = TRUE);

## directory name to be used with unzipped data
rawdatadirectory <- "./TidyData/UCI Har Dataset/";

## Merges the training and the test sets to create one data set.
## ============================================================


## Read in the subject lists 

testsubjects <- read.table(paste0(rawdatadirectory,"test/subject_test.txt"));
names(testsubjects) <- c("Subject")

trainsubjects <- read.table(paste0(rawdatadirectory,"train/subject_train.txt"));
names(trainsubjects) <- c("Subject")

## Read in the measurement sets

testset <- read.table(paste0(rawdatadirectory,"test/X_test.txt"));

trainset <- read.table(paste0(rawdatadirectory,"train/X_train.txt"));

## name the measurement sets with feature names

featurenames <- read.table(paste0(rawdatadirectory,"features.txt"));
names(testset) <- featurenames$V2;
names(trainset) <- featurenames$V2;

## Read in the test activities and convert them to readable names

     ## Read activity labels
activitylabels <- read.table(paste0(rawdatadirectory,"activity_labels.txt"));

testsetactivities <- read.table(paste0(rawdatadirectory,"test/y_test.txt"));
testacts <- merge(testsetactivities, activitylabels);
testsetactivities <- testacts$V2;
names(testsetactivities) <- c("activity");

## Read in the train activities and convert them to readable names

trainsetactivities <- read.table(paste0(rawdatadirectory,"train/y_train.txt"));
trainacts <- merge(trainsetactivities, activitylabels);
trainsetactivities <- trainacts$V2;
names(trainsetactivities) <- c("activity");

## Combine sets

## combine subjects, acticities, and measurements for each set

Activity <- testsetactivities;
testsubjectactivity <- cbind(testsubjects, Activity);
totaltest <- cbind(testsubjectactivity, testset);

Activity <- trainsetactivities;
trainsubjectactivity <- cbind(trainsubjects, Activity);
totaltrain <- cbind(trainsubjectactivity, trainset);

## finally, combine both sets into one 

totaldata <- rbind(totaltest, totaltrain);

## Extracts only the measurements on the mean and standard deviation for each measurement. 
## ======================================================================================

tempcols <- totaldata[,(1:2)];                      ## saves the subject and activity columns for later
totalnames <- names(totaldata);                     ## gets all the names for the combined data set
colset <- grep("mean\\(\\)|std\\(\\)", totalnames); ## greps for mean() or std() in the column name               
tidytotal <- totaldata[,colset];                    ## makes a dataset with just the mean() and std() columns
tidydata <- cbind(tempcols, tidytotal);             ## adds the subject and activity columns to the mean and std columns

## Uses descriptive activity names to name the activities in the data set
## ======================================================================

    ## See above -- already done

## Appropriately labels the data set with descriptive variable names. 
## =================================================================

names(tidydata) <- gsub("subject", "Subject", names(tidydata));
names(tidydata) <- gsub("activity", "Activity", names(tidydata));
names(tidydata) <- gsub("\\(\\)","",names(tidydata));      ## removes all ()
names(tidydata) <- gsub("Acc", "Accel", names(tidydata));  ## readability -- changes "acc" to "accel"
names(tidydata) <- gsub("^t","Time-", names(tidydata));
names(tidydata) <- gsub("^f","Freq-", names(tidydata));
names(tidydata) <- gsub("mean", "Mean", names(tidydata));
names(tidydata) <- gsub("std", "Std", names(tidydata));

## Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
## ================================================================================================================

write(tidydata, file = "tidydataset.csv", ncolumns = ncol(tidydata), append = TRUE, sep = ",");


