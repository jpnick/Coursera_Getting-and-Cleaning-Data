# Peer-graded Assignment: Getting and Cleaning Data Course Project

#   Clean the data set collected from the accelerometers from the Samsung Galaxy S smartphone
#   Result of this Rscript is tidy data called "tidy.txt"
#   See "README.md" for details

# STEP 0
############

library(dplyr)


# STEP 1.1 - Getting data
##########################

# download file
zUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zFile <- "UCI HAR Dataset.zip"

if (!file.exists(zFile)) {
  download.file(zUrl, zFile, mode = "wb")
}

# unzip file 
dPath <- "UCI HAR Dataset"
if (!file.exists(dPath)) {
  unzip(zFile)
}

# STEP 1.2 - Read data
##########################

# read train data
trainSubject <- read.table(file.path(dPath, "train", "subject_train.txt"))
trainValues <- read.table(file.path(dPath, "train", "X_train.txt"))
trainActivity <- read.table(file.path(dPath, "train", "y_train.txt"))

# read test data
testSubject <- read.table(file.path(dPath, "test", "subject_test.txt"))
testValues <- read.table(file.path(dPath, "test", "X_test.txt"))
testActivity <- read.table(file.path(dPath, "test", "y_test.txt"))

# read features [Don't convert text labels to factors]
features <- read.table(file.path(dPath, "features.txt"), as.is = TRUE)

# read activity labels
activities <- read.table(file.path(dPath, "activity_labels.txt"))
colnames(activities) <- c("activityId", "activityLabel")


# Step 2 - Merge train and test data
##################################

# cbind and rbind
allData <- rbind(
  cbind(trainSubject, trainValues, trainActivity),
  cbind(testSubject, testValues, testActivity)
)

# assign column names
colnames(allData) <- c("subject", features[, 2], "activity")

# replace activity values with named factor
allData$activity <- factor(allData$activity, 
                           levels = activities[, 1], labels = activities[, 2])


# Step 3 - Extract only the data on mean and standard deviation
######################################

KeepCols <- grepl("subject|activity|mean|std", colnames(allData))
allData <- allData[, KeepCols]


# Step 4 - Create a group by subject and activity and summarise using mean
##############################################################################

allData.Means <- allData %>% 
  group_by(subject, activity) %>%
  summarise_each(funs(mean))

# write table to file "tidy.txt"
write.table(allData.Means, "tidy.txt", row.names = FALSE, 
            quote = FALSE)
