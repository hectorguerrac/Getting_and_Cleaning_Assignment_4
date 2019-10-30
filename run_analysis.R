# 00. Download zip file

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url,
              destfile='HAR.zip',
              method="wininet", # for Windows 
              mode="wb") 
unzip(zipfile = "HAR.zip") # unpack the files into subdirectories 

# 0. Read files in UCI HAR Dataset

features <- read.table("UCI HAR Dataset/features.txt")
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")

# 1. Merges the training and the test sets to create one data set.

# TEST
## Add activity column
X_test <- cbind(y_test,X_test)
## Add subject column
X_test <- cbind(subject_test,X_test)

# TRAIN
## Add activity column
X_train <- cbind(y_train,X_train)
## Add activity column
X_train <- cbind(subject_train,X_train)

# Add train rows to test rows
dataset <- rbind(X_test, X_train)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

## Add columns names to dataset
names(dataset)[1] <- "subject"
names(dataset)[2] <- "activity"
names(dataset)[3:563] <- as.character(features[1:561,2])

## Create vector with mean and std matches
meancol <- grep("mean", names(dataset))
stdcol <- grep("std", names(dataset))
meanstd <- sort(c(meancol, stdcol))

## Subset dataset with vector
mean_std_dataset <- dataset[meanstd]

# 3. Uses descriptive activity names to name the activities in the data set

## For loop in all rows to change numeric values to descriptive activity names
for (i in 1:nrow(dataset)){dataset[i,2] <- as.character(activity_labels[dataset[i,2],2])}

# 4. Appropriately labels the data set with descriptive variable names.

## Search and rename words in the dataset names
names(dataset) <- sub("tBody","TimeBody", names(dataset))
names(dataset) <- sub("fBody","FreqBody", names(dataset))
names(dataset) <- sub("tGravity","TimeGravity", names(dataset))
## Search and delete "-" signs
names(dataset) <- sub("-"," ", names(dataset))

# 5. Create a second, independent tidy data set with the average of each variable for each 
#    activity and each subject.

## Load dplyr library
library(dplyr)

## Group dataset by subject and activity
dataset %>% group_by(subject, activity)

## Get average values for variables
meandata <- aggregate(. ~ subject + activity, dataset, mean)

# 6. Write tidy dataset file in working directory

write.table(dataset, file = "tidy_dataset_assignment_4.txt", row.name = FALSE)
