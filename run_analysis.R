##rm(list=ls())
setwd("H:/Coursera - DataScience/03 Getting and Cleaning Data/Assignment")


#Loading features and activities
features <- read.table("UCI HAR Dataset/features.txt", col.names=c("featureId", "featureLabel"))
feature_label<-features$featureLabel
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names=c("activityId", "activityLabel"))
head(activities)
head(features)

##Loading test data
X_test<-read.table("UCI HAR Dataset/test/X_test.txt")
Y_test<-read.table("UCI HAR Dataset/test/y_test.txt",col.names="Label")
subject_test = read.table("UCI HAR Dataset/test/subject_test.txt",col.names="SubjectID")
colnames(X_test)<-feature_label

##Loading train data
X_train<-read.table("UCI HAR Dataset/train/X_train.txt")
Y_train<-read.table("UCI HAR Dataset/train/y_train.txt",col.names="Label")
subject_train = read.table("UCI HAR Dataset/train/subject_train.txt",col.names="SubjectID")
colnames(X_train)<-feature_label

#Merging data
testData<-cbind(subject_test, Y_test, X_test)
trainData<-cbind(subject_train, Y_train, X_train)
data <- rbind(testData,trainData)

#Calculating mean and standard deviation
meanId <- grep("mean",names(data),ignore.case=TRUE)
stdDevId <- grep("std",names(data),ignore.case=TRUE)
meanName <- names(data)[meanId]
stdDevName <- names(data)[stdDevId]
meanStdDev <-data[,c("SubjectID","Label",meanName,stdDevName)]
head(meanStdDev)

## Create new tidy dataset
write.table(meanStdDev,"./tidy_data.txt",row.name=FALSE)
