# Coursera Course - Getting and Cleaning Data
# Week 4 Assignment
# By PhilAIUK
# March 20, 2019

# INTRODUCTION: Collect and Prepare the Data
# ------------------------------------------

# Install dplyr package for the 'select' function
install.packages("dplyr")
library(dplyr)

# Set up a specific working directory for this assignment
setwd("./DataCourse3Week4")

# Download the assignment Dataset
contentUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(contentUrl, "CourseraContentWeek4.zip", method="curl")
unzip("CourseraContentWeek4.zip")

# Assign the Data Frames, based on the information provided in the README.txt file
# Common files to Train and Test sets are Activities and Features
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("id", "activity"))
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
# From the Test set
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "id")
# From the Train set
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "id")

# EXERCISE: Here are the steps required for the assignment
# --------------------------------------------------------

# STEP 1: Merges the training and the test sets to create one data set
Subject <- rbind(subject_train, subject_test)
X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
MergedFinal <- cbind(Subject, Y, X)

# STEP 2: Extracts only the measurements on the mean and standard deviation for each measurement
TidyData <- select(MergedFinal, subject, id, contains("mean"), contains("std"))

# STEP 3: Uses descriptive activity names to name the activities in the data set
TidyData$id <- activities[TidyData$id, 2]

# STEP 4: Appropriately labels the data set with descriptive variable names
names(TidyData) <- gsub("id", "activity", names(TidyData))
names(TidyData) <- gsub("Acc", "Accelerometer", names(TidyData))
names(TidyData) <- gsub("Gyro", "Gyroscope", names(TidyData))
names(TidyData) <- gsub("gravity", "Gravity", names(TidyData))
names(TidyData) <- gsub("angle", "Angle", names(TidyData))
names(TidyData) <- gsub("^t", "Time", names(TidyData))
names(TidyData) <- gsub("^f", "Frequency", names(TidyData))
names(TidyData) <- gsub("BodyBody", "Body", names(TidyData))
names(TidyData) <- gsub("Mag", "Magnitude", names(TidyData))
names(TidyData) <- gsub("tBody", "TimeBody", names(TidyData))

# STEP 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
IndependantTidyData <- TidyData %>% 
    group_by(subject, activity) %>% 
    summarise_all(funs(mean))
write.table(IndependantTidyData, "IndependantTidyData.txt", row.name=FALSE)

# That's all Folks!



