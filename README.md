# cleaningdatafinal

The file 'run_analysis.R' takes data from a UCI study on wearable technology (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) and transforms it into a tidy summary. To run this script, download the data from the above link, and set the working directory in the script to where you have saved the data. It will be neccessary to install dplyr and tidyr, if you haven't done so already.

The code merges the training and test sets to create one data set, labels the data, filters it to only the mean and standard deviation, and creates a second data set with only mean and standard deviation for each uniqu pair of subject and activity.
