##  This script will use data from UCI's Machine Learning Repository relating to
##  the recognition of human activity using smartphones.  The raw data can be
##  found at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.
##
##  The test and training data are combined along with subject and activity
##  data. Telemetry data not relating to a mean or standard deviation is
##  discarded. The tidy data set contains the activity name rather than the
##  activity code.
##
##  Finally, each activity for each subjected will be averaged and stored in an
##  average data set. I named this summary data set average rather than mean
##  because the term "mean" has been used many times throughout this experiment.



##  Load necessary code libraries.

library(sqldf)


##  Create a data folder if it doesn't already exist

if(!file.exists("./data"))
{
    dir.create("./data")
}


##  Download the data if it doesn't already exist.

if (!file.exists("./data/data.zip"))
{
    download.file(
        "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
        "./data/data.zip")
}


##  Unzip the data if it doesn't already exist.

if (!file.exists("./data/UCI HAR Dataset"))
{
    unzip("./data/data.zip", exdir = "./data")
}


##  Read the individual data files into data frames.

activity_df <- read.table("./data/UCI HAR Dataset/activity_labels.txt",
                   col.names = c("activity.code", "activity.name"))

feature_df <- read.table("./data/UCI HAR Dataset/features.txt",
                  col.names = c("feature.code", "feature.name"))

subject_test_df <- read.table("./data/UCI HAR Dataset/test/subject_test.txt",
                       col.names = "subject.id")

subject_train_df <- read.table("./data/UCI HAR Dataset/train/subject_train.txt",
                        col.names = "subject.id")

x_test_df <- read.table("./data/UCI HAR Dataset/test/X_test.txt",
                 col.names = feature_df$feature.name)

x_train_df <- read.table("./data/UCI HAR Dataset/train/X_train.txt",
                  col.names = feature_df$feature.name)

y_test_df <- read.table("./data/UCI HAR Dataset/test/y_test.txt",
                 col.names = "activity.code")

y_train_df <- read.table("./data/UCI HAR Dataset/train/y_train.txt",
                  col.names = "activity.code")


##  Merge the test and training subject, x, and y data sets.

subject_merged_df <- rbind(subject_test_df, subject_train_df)

x_merged_df <- rbind(x_test_df, x_train_df)

y_merged_df <- rbind(y_test_df, y_train_df)


##  Merge the subject, x, and y sets into one data set.

merged_df <- cbind(x_merged_df, y_merged_df, subject_merged_df)


##  Create the tidy set from the merged set containing the subject ID, activity
##  name, mean and standard deviation data points.

tidy_query <- "SELECT
                   merged_df.`subject.id`,
                   activity_df.`activity.name`,
                   merged_df.`tBodyAcc.mean...X`                    AS `tBodyAcc.mean.X`,
                   merged_df.`tBodyAcc.mean...Y`                    AS `tBodyAcc.mean.Y`,
                   merged_df.`tBodyAcc.mean...Z`                    AS `tBodyAcc.mean.Z`,
                   merged_df.`tBodyAcc.std...X`                     AS `tBodyAcc.std.X`,
                   merged_df.`tBodyAcc.std...Y`                     AS `tBodyAcc.std.Y`,
                   merged_df.`tBodyAcc.std...Z`                     AS `tBodyAcc.std.Z`,
                   merged_df.`tGravityAcc.mean...X`                 AS `tGravityAcc.mean.X`,
                   merged_df.`tGravityAcc.mean...Y`                 AS `tGravityAcc.mean.Y`,
                   merged_df.`tGravityAcc.mean...Z`                 AS `tGravityAcc.mean.Z`,
                   merged_df.`tGravityAcc.std...X`                  AS `tGravityAcc.std.X`,
                   merged_df.`tGravityAcc.std...Y`                  AS `tGravityAcc.std.Y`,
                   merged_df.`tGravityAcc.std...Z`                  AS `tGravityAcc.std.Z`,
                   merged_df.`tBodyAccJerk.mean...X`                AS `tBodyAccJerk.mean.X`,
                   merged_df.`tBodyAccJerk.mean...Y`                AS `tBodyAccJerk.mean.Y`,
                   merged_df.`tBodyAccJerk.mean...Z`                AS `tBodyAccJerk.mean.Z`,
                   merged_df.`tBodyAccJerk.std...X`                 AS `tBodyAccJerk.std.X`,
                   merged_df.`tBodyAccJerk.std...Y`                 AS `tBodyAccJerk.std.Y`,
                   merged_df.`tBodyAccJerk.std...Z`                 AS `tBodyAccJerk.std.Z`,
                   merged_df.`tBodyGyro.mean...X`                   AS `tBodyGyro.mean.X`,
                   merged_df.`tBodyGyro.mean...Y`                   AS `tBodyGyro.mean.Y`,
                   merged_df.`tBodyGyro.mean...Z`                   AS `tBodyGyro.mean.Z`,
                   merged_df.`tBodyGyro.std...X`                    AS `tBodyGyro.std.X`,
                   merged_df.`tBodyGyro.std...Y`                    AS `tBodyGyro.std.Y`,
                   merged_df.`tBodyGyro.std...Z`                    AS `tBodyGyro.std.Z`,
                   merged_df.`tBodyGyroJerk.mean...X`               AS `tBodyGyroJerk.mean.X`,
                   merged_df.`tBodyGyroJerk.mean...Y`               AS `tBodyGyroJerk.mean.Y`,
                   merged_df.`tBodyGyroJerk.mean...Z`               AS `tBodyGyroJerk.mean.Z`,
                   merged_df.`tBodyGyroJerk.std...X`                AS `tBodyGyroJerk.std.X`,
                   merged_df.`tBodyGyroJerk.std...Y`                AS `tBodyGyroJerk.std.Y`,
                   merged_df.`tBodyGyroJerk.std...Z`                AS `tBodyGyroJerk.std.Z`,
                   merged_df.`tBodyAccMag.mean..`                   AS `tBodyAccMag.mean`,
                   merged_df.`tBodyAccMag.std..`                    AS `tBodyAccMag.std`,
                   merged_df.`tGravityAccMag.mean..`                AS `tGravityAccMag.mean`,
                   merged_df.`tGravityAccMag.std..`                 AS `tGravityAccMag.std`,
                   merged_df.`tBodyAccJerkMag.mean..`               AS `tBodyAccJerkMag.mean`,
                   merged_df.`tBodyAccJerkMag.std..`                AS `tBodyAccJerkMag.std`,
                   merged_df.`tBodyGyroMag.mean..`                  AS `tBodyGyroMag.mean`,
                   merged_df.`tBodyGyroMag.std..`                   AS `tBodyGyroMag.std`,
                   merged_df.`tBodyGyroJerkMag.mean..`              AS `tBodyGyroJerkMag.mean`,
                   merged_df.`tBodyGyroJerkMag.std..`               AS `tBodyGyroJerkMag.std`,
                   merged_df.`fBodyAcc.mean...X`                    AS `fBodyAcc.mean.X`,
                   merged_df.`fBodyAcc.mean...Y`                    AS `fBodyAcc.mean.Y`,
                   merged_df.`fBodyAcc.mean...Z`                    AS `fBodyAcc.mean.Z`,
                   merged_df.`fBodyAcc.std...X`                     AS `fBodyAcc.std.X`,
                   merged_df.`fBodyAcc.std...Y`                     AS `fBodyAcc.std.Y`,
                   merged_df.`fBodyAcc.std...Z`                     AS `fBodyAcc.std.Z`,
                   merged_df.`fBodyAcc.meanFreq...X`                AS `fBodyAcc.meanFreq.X`,
                   merged_df.`fBodyAcc.meanFreq...Y`                AS `fBodyAcc.meanFreq.Y`,
                   merged_df.`fBodyAcc.meanFreq...Z`                AS `fBodyAcc.meanFreq.Z`,
                   merged_df.`fBodyAccJerk.mean...X`                AS `fBodyAccJerk.mean.X`,
                   merged_df.`fBodyAccJerk.mean...Y`                AS `fBodyAccJerk.mean.Y`,
                   merged_df.`fBodyAccJerk.mean...Z`                AS `fBodyAccJerk.mean.Z`,
                   merged_df.`fBodyAccJerk.std...X`                 AS `fBodyAccJerk.std.X`,
                   merged_df.`fBodyAccJerk.std...Y`                 AS `fBodyAccJerk.std.Y`,
                   merged_df.`fBodyAccJerk.std...Z`                 AS `fBodyAccJerk.std.Z`,
                   merged_df.`fBodyAccJerk.meanFreq...X`            AS `fBodyAccJerk.meanFreq.X`,
                   merged_df.`fBodyAccJerk.meanFreq...Y`            AS `fBodyAccJerk.meanFreq.Y`,
                   merged_df.`fBodyAccJerk.meanFreq...Z`            AS `fBodyAccJerk.meanFreq.Z`,
                   merged_df.`fBodyGyro.mean...X`                   AS `fBodyGyro.mean.X`,
                   merged_df.`fBodyGyro.mean...Y`                   AS `fBodyGyro.mean.Y`,
                   merged_df.`fBodyGyro.mean...Z`                   AS `fBodyGyro.mean.Z`,
                   merged_df.`fBodyGyro.std...X`                    AS `fBodyGyro.std.X`,
                   merged_df.`fBodyGyro.std...Y`                    AS `fBodyGyro.std.Y`,
                   merged_df.`fBodyGyro.std...Z`                    AS `fBodyGyro.std.Z`,
                   merged_df.`fBodyGyro.meanFreq...X`               AS `fBodyGyro.meanFreq.X`,
                   merged_df.`fBodyGyro.meanFreq...Y`               AS `fBodyGyro.meanFreq.Y`,
                   merged_df.`fBodyGyro.meanFreq...Z`               AS `fBodyGyro.meanFreq.Z`,
                   merged_df.`fBodyAccMag.mean..`                   AS `fBodyAccMag.mean`,
                   merged_df.`fBodyAccMag.std..`                    AS `fBodyAccMag.std`,
                   merged_df.`fBodyAccMag.meanFreq..`               AS `fBodyAccMag.meanFreq`,
                   merged_df.`fBodyBodyAccJerkMag.mean..`           AS `fBodyBodyAccJerkMag.mean`,
                   merged_df.`fBodyBodyAccJerkMag.std..`            AS `fBodyBodyAccJerkMag.std`,
                   merged_df.`fBodyBodyAccJerkMag.meanFreq..`       AS `fBodyBodyAccJerkMag.meanFreq`,
                   merged_df.`fBodyBodyGyroMag.mean..`              AS `fBodyBodyGyroMag.mean`,
                   merged_df.`fBodyBodyGyroMag.std..`               AS `fBodyBodyGyroMag.std`,
                   merged_df.`fBodyBodyGyroMag.meanFreq..`          AS `fBodyBodyGyroMag.meanFreq`,
                   merged_df.`fBodyBodyGyroJerkMag.mean..`          AS `fBodyBodyGyroJerkMag.mean`,
                   merged_df.`fBodyBodyGyroJerkMag.std..`           AS `fBodyBodyGyroJerkMag.std`,
                   merged_df.`fBodyBodyGyroJerkMag.meanFreq..`      AS `fBodyBodyGyroJerkMag.meanFreq`,
                   merged_df.`angle.tBodyAccMean.gravity.`          AS `angle.tBodyAccMean.gravity`,
                   merged_df.`angle.tBodyAccJerkMean..gravityMean.` AS `angle.tBodyAccJerkMean.gravityMean`,
                   merged_df.`angle.tBodyGyroMean.gravityMean.`     AS `angle.tBodyGyroMean.gravityMean`,
                   merged_df.`angle.tBodyGyroJerkMean.gravityMean.` AS `angle.tBodyGyroJerkMean.gravityMean`,
                   merged_df.`angle.X.gravityMean.`                 AS `angle.X.gravityMean`,
                   merged_df.`angle.Y.gravityMean.`                 AS `angle.Y.gravityMean`,
                   merged_df.`angle.Z.gravityMean.`                 AS `angle.Z.gravityMean`
               FROM merged_df
               INNER JOIN activity_df
               ON merged_df.`activity.code` = activity_df.`activity.code`
               ORDER BY
                   merged_df.`subject.id`,
                   activity_df.`activity.name`;"

tidy_df <- sqldf(tidy_query)


##  Write the tidy set

write.table(tidy_df, "./data/tidy.txt", row.name = FALSE)


##  Create the summary data set containing the subject ID, activity name, and
##  the mean (average) of all of the data points in the tidy set.

avg_query <- "SELECT
                  `subject.id`,
                  `activity.name`,
                  AVG(`tBodyAcc.mean.X`)                     AS `average.tBodyAcc.mean.X`,
                  AVG(`tBodyAcc.mean.Y`)                     AS `average.tBodyAcc.mean.Y`,
                  AVG(`tBodyAcc.mean.Z`)                     AS `average.tBodyAcc.mean.Z`,
                  AVG(`tBodyAcc.std.X`)                      AS `average.tBodyAcc.std.X`,
                  AVG(`tBodyAcc.std.Y`)                      AS `average.tBodyAcc.std.Y`,
                  AVG(`tBodyAcc.std.Z`)                      AS `average.tBodyAcc.std.Z`,
                  AVG(`tGravityAcc.mean.X`)                  AS `average.tGravityAcc.mean.X`,
                  AVG(`tGravityAcc.mean.Y`)                  AS `average.tGravityAcc.mean.Y`,
                  AVG(`tGravityAcc.mean.Z`)                  AS `average.tGravityAcc.mean.Z`,
                  AVG(`tGravityAcc.std.X`)                   AS `average.tGravityAcc.std.X`,
                  AVG(`tGravityAcc.std.Y`)                   AS `average.tGravityAcc.std.Y`,
                  AVG(`tGravityAcc.std.Z`)                   AS `average.tGravityAcc.std.Z`,
                  AVG(`tBodyAccJerk.mean.X`)                 AS `average.tBodyAccJerk.mean.X`,
                  AVG(`tBodyAccJerk.mean.Y`)                 AS `average.tBodyAccJerk.mean.Y`,
                  AVG(`tBodyAccJerk.mean.Z`)                 AS `average.tBodyAccJerk.mean.Z`,
                  AVG(`tBodyAccJerk.std.X`)                  AS `average.tBodyAccJerk.std.X`,
                  AVG(`tBodyAccJerk.std.Y`)                  AS `average.tBodyAccJerk.std.Y`,
                  AVG(`tBodyAccJerk.std.Z`)                  AS `average.tBodyAccJerk.std.Z`,
                  AVG(`tBodyGyro.mean.X`)                    AS `average.tBodyGyro.mean.X`,
                  AVG(`tBodyGyro.mean.Y`)                    AS `average.tBodyGyro.mean.Y`,
                  AVG(`tBodyGyro.mean.Z`)                    AS `average.tBodyGyro.mean.Z`,
                  AVG(`tBodyGyro.std.X`)                     AS `average.tBodyGyro.std.X`,
                  AVG(`tBodyGyro.std.Y`)                     AS `average.tBodyGyro.std.Y`,
                  AVG(`tBodyGyro.std.Z`)                     AS `average.tBodyGyro.std.Z`,
                  AVG(`tBodyGyroJerk.mean.X`)                AS `average.tBodyGyroJerk.mean.X`,
                  AVG(`tBodyGyroJerk.mean.Y`)                AS `average.tBodyGyroJerk.mean.Y`,
                  AVG(`tBodyGyroJerk.mean.Z`)                AS `average.tBodyGyroJerk.mean.Z`,
                  AVG(`tBodyGyroJerk.std.X`)                 AS `average.tBodyGyroJerk.std.X`,
                  AVG(`tBodyGyroJerk.std.Y`)                 AS `average.tBodyGyroJerk.std.Y`,
                  AVG(`tBodyGyroJerk.std.Z`)                 AS `average.tBodyGyroJerk.std.Z`,
                  AVG(`tBodyAccMag.mean`)                    AS `average.tBodyAccMag.mean`,
                  AVG(`tBodyAccMag.std`)                     AS `average.tBodyAccMag.std`,
                  AVG(`tGravityAccMag.mean`)                 AS `average.tGravityAccMag.mean`,
                  AVG(`tGravityAccMag.std`)                  AS `average.tGravityAccMag.std`,
                  AVG(`tBodyAccJerkMag.mean`)                AS `average.tBodyAccJerkMag.mean`,
                  AVG(`tBodyAccJerkMag.std`)                 AS `average.tBodyAccJerkMag.std`,
                  AVG(`tBodyGyroMag.mean`)                   AS `average.tBodyGyroMag.mean`,
                  AVG(`tBodyGyroMag.std`)                    AS `average.tBodyGyroMag.std`,
                  AVG(`tBodyGyroJerkMag.mean`)               AS `average.tBodyGyroJerkMag.mean`,
                  AVG(`tBodyGyroJerkMag.std`)                AS `average.tBodyGyroJerkMag.std`,
                  AVG(`fBodyAcc.mean.X`)                     AS `average.fBodyAcc.mean.X`,
                  AVG(`fBodyAcc.mean.Y`)                     AS `average.fBodyAcc.mean.Y`,
                  AVG(`fBodyAcc.mean.Z`)                     AS `average.fBodyAcc.mean.Z`,
                  AVG(`fBodyAcc.std.X`)                      AS `average.fBodyAcc.std.X`,
                  AVG(`fBodyAcc.std.Y`)                      AS `average.fBodyAcc.std.Y`,
                  AVG(`fBodyAcc.std.Z`)                      AS `average.fBodyAcc.std.Z`,
                  AVG(`fBodyAcc.meanFreq.X`)                 AS `average.fBodyAcc.meanFreq.X`,
                  AVG(`fBodyAcc.meanFreq.Y`)                 AS `average.fBodyAcc.meanFreq.Y`,
                  AVG(`fBodyAcc.meanFreq.Z`)                 AS `average.fBodyAcc.meanFreq.Z`,
                  AVG(`fBodyAccJerk.mean.X`)                 AS `average.fBodyAccJerk.mean.X`,
                  AVG(`fBodyAccJerk.mean.Y`)                 AS `average.fBodyAccJerk.mean.Y`,
                  AVG(`fBodyAccJerk.mean.Z`)                 AS `average.fBodyAccJerk.mean.Z`,
                  AVG(`fBodyAccJerk.std.X`)                  AS `average.fBodyAccJerk.std.X`,
                  AVG(`fBodyAccJerk.std.Y`)                  AS `average.fBodyAccJerk.std.Y`,
                  AVG(`fBodyAccJerk.std.Z`)                  AS `average.fBodyAccJerk.std.Z`,
                  AVG(`fBodyAccJerk.meanFreq.X`)             AS `average.fBodyAccJerk.meanFreq.X`,
                  AVG(`fBodyAccJerk.meanFreq.Y`)             AS `average.fBodyAccJerk.meanFreq.Y`,
                  AVG(`fBodyAccJerk.meanFreq.Z`)             AS `average.fBodyAccJerk.meanFreq.Z`,
                  AVG(`fBodyGyro.mean.X`)                    AS `average.fBodyGyro.mean.X`,
                  AVG(`fBodyGyro.mean.Y`)                    AS `average.fBodyGyro.mean.Y`,
                  AVG(`fBodyGyro.mean.Z`)                    AS `average.fBodyGyro.mean.Z`,
                  AVG(`fBodyGyro.std.X`)                     AS `average.fBodyGyro.std.X`,
                  AVG(`fBodyGyro.std.Y`)                     AS `average.fBodyGyro.std.Y`,
                  AVG(`fBodyGyro.std.Z`)                     AS `average.fBodyGyro.std.Z`,
                  AVG(`fBodyGyro.meanFreq.X`)                AS `average.fBodyGyro.meanFreq.X`,
                  AVG(`fBodyGyro.meanFreq.Y`)                AS `average.fBodyGyro.meanFreq.Y`,
                  AVG(`fBodyGyro.meanFreq.Z`)                AS `average.fBodyGyro.meanFreq.Z`,
                  AVG(`fBodyAccMag.mean`)                    AS `average.fBodyAccMag.mean`,
                  AVG(`fBodyAccMag.std`)                     AS `average.fBodyAccMag.std`,
                  AVG(`fBodyAccMag.meanFreq`)                AS `average.fBodyAccMag.meanFreq`,
                  AVG(`fBodyBodyAccJerkMag.mean`)            AS `average.fBodyBodyAccJerkMag.mean`,
                  AVG(`fBodyBodyAccJerkMag.std`)             AS `average.fBodyBodyAccJerkMag.std`,
                  AVG(`fBodyBodyAccJerkMag.meanFreq`)        AS `average.fBodyBodyAccJerkMag.meanFreq`,
                  AVG(`fBodyBodyGyroMag.mean`)               AS `average.fBodyBodyGyroMag.mean`,
                  AVG(`fBodyBodyGyroMag.std`)                AS `average.fBodyBodyGyroMag.std`,
                  AVG(`fBodyBodyGyroMag.meanFreq`)           AS `average.fBodyBodyGyroMag.meanFreq`,
                  AVG(`fBodyBodyGyroJerkMag.mean`)           AS `average.fBodyBodyGyroJerkMag.mean`,
                  AVG(`fBodyBodyGyroJerkMag.std`)            AS `average.fBodyBodyGyroJerkMag.std`,
                  AVG(`fBodyBodyGyroJerkMag.meanFreq`)       AS `average.fBodyBodyGyroJerkMag.meanFreq`,
                  AVG(`angle.tBodyAccMean.gravity`)          AS `average.angle.tBodyAccMean.gravity`,
                  AVG(`angle.tBodyAccJerkMean.gravityMean`)  AS `average.angle.tBodyAccJerkMean.gravityMean`,
                  AVG(`angle.tBodyGyroMean.gravityMean`)     AS `average.angle.tBodyGyroMean.gravityMean`,
                  AVG(`angle.tBodyGyroJerkMean.gravityMean`) AS `average.angle.tBodyGyroJerkMean.gravityMean`,
                  AVG(`angle.X.gravityMean`)                 AS `average.angle.X.gravityMean`,
                  AVG(`angle.Y.gravityMean`)                 AS `average.angle.Y.gravityMean`,
                  AVG(`angle.Z.gravityMean`)                 AS `average.angle.Z.gravityMean`
              FROM tidy_df
              GROUP BY
                  `subject.id`,
                  `activity.name`
              ORDER BY
                  `subject.id`,
                  `activity.name`;"

avg_df <- sqldf(avg_query)


##  Write the mean (average) data set.

write.table(avg_df, "./data/average.txt", row.name = FALSE)

