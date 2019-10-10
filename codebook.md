##  Description

The data was extracted from the UCI Machine Learning Repository. The data set is
human activity recognition using smartphones. Information about the raw data set
can be found at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

##  Format

The data are separted into several different files.  Those files are:

activity_labels.txt - The names of each activity that is performed for each
observation.

features.txt - The names of the data points collected for each observation.

x_test.txt - The test data set.

x_train.txt - The training data set.

y_test.txt - The test labels.

y_train.txt - The training labels.

subject_test.txt - The subject test data.

subject_train.txt - The subject training data.

The files are merged into one tidy data set containing:
[, 1]: subject id
[, 2]: activity name
[, 3:87]: data points relating to the mean or standard deviation

The data set is then summarized by the mean (average) of each subject and
activity.