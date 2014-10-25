## Name: run_analysis.R
## By: Tuang Dheandhanoo
## Description: This will be an R script for Getting and Cleaning Data Course Project
##      
## 
##loading dplyr and stringr
library(dplyr)
library(stringr)

##start loading files that we need

xtest <- read.table("./data/test/X_test.txt", stringsAsFactors = FALSE)
ytest <- read.table("./data/test/y_test.txt", stringsAsFactors = FALSE)
subtest <- read.table("./data/test/subject_test.txt", stringsAsFactors = FALSE)

xtrain <- read.table("./data/train/X_train.txt", stringsAsFactors = FALSE)
ytrain <- read.table("./data/train/y_train.txt", stringsAsFactors = FALSE)
subtrain <- read.table("./data/train/subject_train.txt", stringsAsFactors = FALSE)

features <- read.table("./data/features.txt", stringsAsFactors = FALSE)
activitiesLabel <- read.table("./data/activity_labels.txt", stringsAsFactors = FALSE)

## then cliping those data together

## rbind Train and Test Data
xTrainTest <- rbind(xtrain, xtest)
## rbind subject from train and test data
subTrainTest <- rbind(subtrain, subtest)
## rbind activity labels
yTrainTest <- rbind(ytrain, ytest)

## cbind subject to Data1
Data1 <- cbind(xTrainTest, subTrainTest)
## cbind activity label to Data1
Data1 <- cbind(Data1, yTrainTest)

## prepare names for our Data1 add subjects and activities to the last two rows of features
features[562,] <- c(562, "subjects")
features[563,] <- c(563, "activities")
## then use column 2 of features to rename all the column names in Data1
names(Data1) <- c(features[,2])

## then we will prepare a vector that contains only names that we  want
## extract colNames from features column2

colNames <- features[,2]

## then select only names that we want
colNames <- (colNames[(grepl("mean",colNames) | 
                        grepl("std",colNames) | 
                        grepl("subjects",colNames) | 
                        grepl("activities",colNames)) ==TRUE])


## use colNames to subset Data1 to select only columns that we want
Data1 <- Data1[ , colNames]

## time to rename those activities,
## I use mutate and str_replace_all to rename them by pull the right label from activitiesLabel
Data1 <- mutate(Data1, activities = str_replace_all(activities, "1", activitiesLabel[1,2]))
Data1 <- mutate(Data1, activities = str_replace_all(activities, "2", activitiesLabel[2,2]))
Data1 <- mutate(Data1, activities = str_replace_all(activities, "3", activitiesLabel[3,2]))
Data1 <- mutate(Data1, activities = str_replace_all(activities, "4", activitiesLabel[4,2]))
Data1 <- mutate(Data1, activities = str_replace_all(activities, "5", activitiesLabel[5,2]))
Data1 <- mutate(Data1, activities = str_replace_all(activities, "6", activitiesLabel[6,2]))


## step 5 time to summarise the data base on subjects and activities
## and mean of the variables
## use group_by() then summarise_each() with mean()
## save them to tidyData
Data2 <- group_by(Data1, subjects, activities)
tidyData <- summarise_each(Data2, funs(mean))

## then write that tidyData to file.
write.table(tidyData, file="./tidyData.txt", row.name=FALSE)

