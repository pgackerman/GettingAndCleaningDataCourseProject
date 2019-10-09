##       1         2         3         4         5         6         7         8
##345678901234567890123456789012345678901234567890123456789012345678901234567890

rm(list = ls())
library(dplyr)

if(!file.exists("./data"))
{
    dir.create("./data")
}

if (!file.exists("./data/data.zip"))
{
    download.file(
        "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
        "./data/data.zip")
}

if (!file.exists("./data/UCI HAR Dataset"))
{
    unzip("./data/data.zip", exdir = "./data")
}

activity_df <- read.table("./data/UCI HAR Dataset/activity_labels.txt",
                   col.names = c("activity.code", "activity.name"))

feature_df <- read.table("./data/UCI HAR Dataset/features.txt",
                  col.names = c("feature.code", "feature.name"))

x_test_df <- read.table("./data/UCI HAR Dataset/test/X_test.txt",
                 col.names = feature_df$feature.name)

x_train_df <- read.table("./data/UCI HAR Dataset/train/X_train.txt",
                  col.names = feature_df$feature.name)

x_merged_df <- rbind(x_test_df, x_train_df)
x_merged_df <- select(x_merged_df, contains("mean"), contains("std"))

## clean up fature names. this isn't required but i do not like column names
## that end with periods or have a period next to a period

##  remove ".." from the end of column names

names(x_merged_df) <- gsub("\\.\\.$", "", names(x_merged_df))


##  remove "." from the end of column names

names(x_merged_df) <- gsub("\\.$", "", names(x_merged_df))


##  replace "..." with "."

names(x_merged_df) <- gsub("\\.\\.\\.", "\\.", names(x_merged_df))


##  replace ".." with "."

names(x_merged_df) <- gsub("\\.\\.", "\\.", names(x_merged_df))


subject_test_df <- read.table("./data/UCI HAR Dataset/test/subject_test.txt",
                       col.names = "subject.id")

subject_train_df <- read.table("./data/UCI HAR Dataset/train/subject_train.txt",
                        col.names = "subject.id")

subject_merged_df <- rbind(subject_test_df, subject_train_df)

y_test_df <- read.table("./data/UCI HAR Dataset/test/y_test.txt",
                 col.names = "activity.code")

y_train_df <- read.table("./data/UCI HAR Dataset/train/y_train.txt",
                  col.names = "activity.code")

y_merged_df <- rbind(y_test_df, y_train_df)

merged_df <- cbind(subject_merged_df, y_merged_df, x_merged_df)



write.table(merged_df, "./data/merged.txt", row.name = FALSE)

