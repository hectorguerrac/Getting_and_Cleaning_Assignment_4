# Getting_and_Cleaning_Assignment_4

The goal is to prepare tidy data that can be used for later analysis from the url "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

Steps to follow:

00. Download zip file
0. Read files from UCI HAR Dataset Directory
1. Merges the training and the test sets to create one data set.
    - A. TEST
        - Add activity column
        - Add subject column
    - B. TRAIN
        - Add activity column
        - Add activity column
    - C. Add train rows to test rows
2. Extracts only the measurements on the mean and standard deviation for each measurement.
    - Add columns names to dataset
    - Create vector with mean and std matches
    - Subset dataset with vector
3. Uses descriptive activity names to name the activities in the data set
    - "For" loop in all rows to change numeric values to descriptive activity names
4. Appropriately labels the data set with descriptive variable names.
    - Search and rename words in the dataset names
    - Search and delete "-" signs
5. Create a second, independent tidy data set with the average of each variable for each 
   activity and each subject.
    - Load dplyr library
    - Group dataset by subject and activity
    - Get average values for variables
6. Write tidy dataset file in working directory
   - "tidy_dataset_assignment_4.txt"
