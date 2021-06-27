#
# run_Analysis.R
#

orgdir <- getwd()

file_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(file_url,destfile="./Dataset.zip")

unzip(zipfile="./Dataset.zip")

data_dir <- "UCI HAR Dataset"

# Read train data
x_train <- read.table(paste(data_dir, "/train/X_train.txt",sep=""))
y_train <- read.table(paste(data_dir, "/train/y_train.txt",sep=""))
s_train <- read.table(paste(data_dir, "/train/subject_train.txt",sep=""))

# Read testing data
x_test <- read.table(paste(data_dir, "/test/X_test.txt",sep=""))
y_test <- read.table(paste(data_dir, "/test/y_test.txt",sep=""))
s_test <- read.table(paste(data_dir, "/test/subject_test.txt",sep=""))

# Read features data
features <- read.table(paste(data_dir, "/features.txt",sep=""))
colnames(features) <- c("No", "Feature")

# Read activities data
activity <- read.table(paste(data_dir, "/activity_labels.txt",sep=""))
colnames(activity) <- c("Label", "Activity")

# 1.Merges the training and the test sets to create one data set.

merge_x <- rbind(x_train, x_test)
colnames(merge_x) <- features$Feature

merge_y <- rbind(y_train, y_test)
colnames(merge_y) <- c("Label")

merge_s <- rbind(s_train, s_test)
colnames(merge_s) <- c("Subject")

merge_data <- cbind(merge_s, merge_y, merge_x)

# 2.Extracts only the measurements on the mean and standard deviation for each measurement. 

mean_std_data <- merge_data %>% select(Subject, Label, contains("mean"), contains("std"))
 
# 3.Uses descriptive activity names to name the activities in the data set

mean_std_data$Label <- activity[mean_std_data$Label,2]

# 4.Appropriately labels the data set with descriptive variable names

names(mean_std_data)<-gsub("^t", "Time", names(mean_std_data))
names(mean_std_data)<-gsub("tBody", "TimeBody", names(mean_std_data))
names(mean_std_data)<-gsub("BodyBody", "Body", names(mean_std_data))
names(mean_std_data)<-gsub("Acc", "Accelerometer", names(mean_std_data))
names(mean_std_data)<-gsub("Gyro", "Gyroscope", names(mean_std_data))
names(mean_std_data)<-gsub("Mag", "Magnitude", names(mean_std_data))
names(mean_std_data)<-gsub("^f", "Frequency", names(mean_std_data))
names(mean_std_data)<-gsub("-freq()", "Frequency", names(mean_std_data), ignore.case = TRUE)


# 5.From the data set in step 4, creates a second, independent tidy data set with 
#   the average of each variable for each activity and each subject

names(mean_std_data)[2] <- "Activity"

Tidy_data <- mean_std_data %>%
  group_by(Subject, Activity) %>%
  summarise_all(funs(mean))

write.table(Tidy_data, "FinalData.txt", row.name=FALSE)

