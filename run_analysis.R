library(dplyr)

# 0. Download and unzip the dataset (if not already present)
file_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zip_file <- "UCI_HAR_Dataset.zip"
data_folder <- "UCI HAR Dataset"

if (!file.exists(zip_file)) {
  download.file(file_url, destfile = zip_file, mode = "wb")
}

if (!file.exists(data_folder)) {
  unzip(zip_file)
}

# Load metadata (features and activity labels)
features <- read.table(file.path(data_folder, "features.txt"), col.names = c("index", "feature"))
activity_labels <- read.table(file.path(data_folder, "activity_labels.txt"), col.names = c("code", "activity"))

# Load training data
subject_train <- read.table(file.path(data_folder, "train", "subject_train.txt"), col.names = "subject")
x_train <- read.table(file.path(data_folder, "train", "X_train.txt"), col.names = features$feature)
y_train <- read.table(file.path(data_folder, "train", "y_train.txt"), col.names = "code")

# Load test data
subject_test <- read.table(file.path(data_folder, "test", "subject_test.txt"), col.names = "subject")
x_test <- read.table(file.path(data_folder, "test", "X_test.txt"), col.names = features$feature)
y_test <- read.table(file.path(data_folder, "test", "y_test.txt"), col.names = "code")

# -----------------------------------------------------------------------------
# STEP 1: Merge the training and test sets to create one data set
# -----------------------------------------------------------------------------
x_merged <- rbind(x_train, x_test)
y_merged <- rbind(y_train, y_test)
subject_merged <- rbind(subject_train, subject_test)

complete_data <- cbind(subject_merged, y_merged, x_merged)

# -----------------------------------------------------------------------------
# STEP 2: Extract only the measurements on the mean and standard deviation
# -----------------------------------------------------------------------------
tidy_mean_std <- complete_data %>%
  select(subject, code, contains("mean.."), contains("std.."))

# -----------------------------------------------------------------------------
# STEP 3: Use descriptive activity names to name the activities in the data set
# -----------------------------------------------------------------------------
tidy_mean_std$code <- activity_labels$activity[match(tidy_mean_std$code, activity_labels$code)]
tidy_mean_std <- rename(tidy_mean_std, activity = code)

# -----------------------------------------------------------------------------
# STEP 4: Appropriately label the data set with descriptive variable names
# -----------------------------------------------------------------------------
names(tidy_mean_std) <- names(tidy_mean_std) %>%
  gsub("^t", "TimeDomain_", .) %>%
  gsub("^f", "FrequencyDomain_", .) %>%
  gsub("Acc", "Accelerometer", .) %>%
  gsub("Gyro", "Gyroscope", .) %>%
  gsub("Mag", "Magnitude", .) %>%
  gsub("BodyBody", "Body", .) %>%
  gsub("\\.mean\\.\\.", "_Mean", .) %>%
  gsub("\\.std\\.\\.", "_StdDev", .) %>%
  gsub("\\.", "", .)

# -----------------------------------------------------------------------------
# STEP 5: Create a second, independent tidy data set with the average 
#         of each variable for each activity and each subject
# -----------------------------------------------------------------------------
final_tidy_data <- tidy_mean_std %>%
  group_by(subject, activity) %>%
  summarise(across(everything(), mean), .groups = "drop")

# Write out the final dataset
write.table(final_tidy_data, "tidy_data.txt", row.name = FALSE)

# Write out the final dataset created in Step 5
write.table(final_tidy_data, file = "D:/SSD/Bioinformatics/Courses/Coursera/Data science/3/gettind and cleaning project/tidy_data.txt", row.name = FALSE)
