##  Getting And Cleaning Data -- Course Project

### Introduction

This script will use data from UCI's Machine Learning Repository relating to the
recognition of human activity using smartphones.  The raw data can be found at
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

The test and training data are combined along with subject and activity data.
Telemetry data not relating to a mean or standard deviation is discarded. The
tidy data set contains the activity name rather than the activity code.

Finally, each activity for each subjected will be averaged and stored in an
average data set. I named this summary data set average rather than mean because
the term "mean" has been used many times throughout this experiment.

### Files

codebook.md - The code book for this project

run_analysis.R - The script to build the tidy and summarized data sets.

tidy.txt - The tidy data set.

average.txt - The summarized data set.

### Please note

The data directory has been included but is not needed to
evaluate the project.  The tidy.txt and average.txt were copied from the data
directory after the last run.
