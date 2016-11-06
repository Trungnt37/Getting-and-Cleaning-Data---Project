setwd("D:/Learning/DataScience/Getting and Cleaning Data")

### Step 0:  Download and unzip the dataset

filename <- "getdata_dataset.zip"
if(!file.exists(filename)){
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileUrl, destfile = filename, method = "auto")    
}
if(!file.exists("UCI HAR Dataset")){
    unzip(filename)
}

### Step 1: Merges the training and the test sets to create one data set.

# activity data
activityTest  <- read.table("./UCI HAR Dataset/test/y_test.txt")
activityTrain <- read.table("./UCI HAR Dataset/train/y_train.txt")
activitydata  <- rbind(activityTest, activityTrain)
names(activitydata) <- c("activity")

# Subject data
subjectTest  <- read.table("./UCI HAR Dataset/test/subject_test.txt")
subjectTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")
subjectdata  <- rbind(subjectTest, subjectTrain)
names(subjectdata) <- c("subject")

# Feature data
featureTest  <- read.table("./UCI HAR Dataset/test/x_test.txt")
featureTrain <- read.table("./UCI HAR Dataset/train/x_train.txt")
featuredataall  <- rbind(featureTest, featureTrain)

### Step 2: Extracts only the measurements on the mean and standard deviation 
# for each measurement

featureName  <- read.table("./UCI HAR Dataset/features.txt")
featureWanted.index <- grep(".*mean.*|.*std.*", featureName[, 2])
featureWanted.names <- featureName[featureWanted.index, 2]
featureWanted.names <- gsub('-mean', 'Mean', featureWanted.names)
featureWanted.names <- gsub('-std', 'Std', featureWanted.names)
featureWanted.names <- gsub('[-()]', '', featureWanted.names)

# Feature data select
featuredata  <- featuredataall[,featureWanted.index]
names(featuredata) <- featureWanted.names

# Merge all Data
alldata <- cbind(subjectdata, activitydata, featuredata)

### Step 3: creates a second, independent tidy data set with the average of each 
#   variable for each activity and each subject.
activityLables <- read.table("UCI HAR Dataset/activity_labels.txt")
alldata$activity <- factor(alldata$activity, levels = activityLables[,1], 
                           labels = activityLables[,2])
alldata$subject <- as.factor(alldata$subject)

library(reshape2)
alldata.melted <- melallt(alldata, id = c("subject", "activity"))
alldata.mean <- dcast(alldata.melted, subject + activity ~ variable, mean)

write.table(alldata.mean, "tidy.txt", row.names = FALSE)