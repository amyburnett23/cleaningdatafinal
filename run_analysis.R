library(dplyr)
library(tidyr)
setwd("C:\\Users\\Amy\\Desktop\\Coursera files\\Getting and cleaning data")

# Merges the training and the test sets to create one data set.
features <- read.table("features.txt", header = F)
features <- t(select(features, V2))

# Appropriately labels the data set with descriptive variable names.
X_test <- read.table("test\\X_test.txt", header = F)
y_test <- read.table("test\\y_test.txt", header = F)
sub_test <- read.table("test\\subject_test.txt", header = F)

X_train <- read.table("train\\X_train.txt", header = F)
y_train <- read.table("train\\y_train.txt", header = F)
sub_train <- read.table("train\\subject_train.txt", header = F)

x <- rbind(X_train, X_test)
colnames(x) <- make.names(features, unique = T)

# Uses descriptive activity names to name the activities in the data set
activity_labels <- read.table("activity_labels.txt", header = F)
y <- rbind(y_train, y_test)
activity_labels <- as.data.frame(activity_labels)
y <- full_join(activity_labels, y)
y <- rename(y, activity = V2)
y <- select(y, activity)


sub <- rbind(sub_train, sub_test)
sub <- rename(sub, subject = V1)

df <- cbind(sub, y)
df <- cbind(df, x)

# Extracts only the measurements on the mean and standard deviation for each measurement.
df <- select(df, matches("subject|activity|std|mean\\.", ignore.case = F))

# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

summary_df <- df %>%
    gather(measurement, value, tBodyAcc.mean...X:fBodyBodyGyroMag.mean..)  %>%
    group_by(activity, subject, measurement) %>%
    summarize(average = mean(value)) %>%
    arrange(subject)

write.csv(summary_df, "tidy_data.csv")