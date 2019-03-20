# Code Book
As requested, this code book describes the variables, the data, and any transformations or work that I have performed to clean up the data.

I  wrote the run_analysis.R script to collect, prepare, transform the data, and to create the final tidied file called IndependantTidyData.txt.
The script is composed of 2 parts:
1. Introduction: for data collection and preparation
2. Data transformation and creation: split into **5 steps**, as requested for the assignment

## Introduction

###Install and load R packages needed for the work
* dplyr

## Download the dataset
* Set a specific working directory for that assignment, called DataCourse3Week4
* Dataset (zip file) downloaded and unzipped under the folder called UCI HAR Dataset

## Assign the Data Frames

### Starting with common files to Train and Test sets
* activities from activity_labels.txt , naming the 2 columns “id” and “activity”
* features from features.txt , naming the 2 columns “n” and “functions”

### From the Test set
* subject_test from test/subject_test.txt , naming the column “subject”
* x_test from  test/X_test.txt , naming the columns with the names listed in the column ‘functions’ of the Data Frame ‘features’
* y_test from test/y_test.txt, naming the column “id”

### From the Train set
* subject_train from test/subject_train.txt
* x_train from test/X_train.txt, naming the columns with the names listed in the column ‘functions’ of the Data Frame ‘features’
* y_train from test/y_train.txt, naming the column “id”

## Data transformation and creation

### STEP 1: Merges the training and the test sets to create one data set 
* Subject is created by merging subject_train and subject_test, using rbind() function
* X is created by merging x_train and x_test, using rbind() function
* Y is created by merging y_train and y_test , using rbind() function
* MergedFinal is then created by merging Subject, Y and X, using cbind() function

### STEP 2: Extracts only the measurements on the mean and standard deviation for each measurement 
* TidyData is created by selecting a subset of MergedFinal, choosing only the columns: subject, id and the measurements on the mean and std (standard deviation) for each measurement

### STEP 3: Uses descriptive activity names to name the activities in the data set 
The second column of ‘activity’ Data Frame contains the names of the activities.
I replaced the numbers which represented the ‘id’ of the activities by their respective names for the Data Frame ‘TidyData’ 

### STEP 4: Appropriately labels the data set with descriptive variable names
Here are the substitutions I have made using the gsub() function (i.e. for all occurrences):
* id in column’s name replaced by activity
* Acc in column’s name replaced by Accelerometer
* Gyro in column’s name replaced by Gyroscope
* gravity in column’s name replaced by Gravity
* angle in column’s name replaced by Angle
* Lines starting with character t in column’s name replaced by Time
* Lines starting with character f in column’s name replaced by Frequency
* BodyBody in column’s name replaced by Body, to remove useless duplicate information
* Mag in column’s name replaced by Magnitude
* tBody in column’s name replaced by TimeBody

# STEP 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject 
* IndependantTidyData is created by sumarising TidyData taking the means of each variable for each activity and each subject, after grouping by subject and activity.
IndependantTidyData has 180 rows and 88 columns.
* Export IndependantTidyData into the file IndependantTidyData.txt, using write.table() function.

Thank you for reading!
