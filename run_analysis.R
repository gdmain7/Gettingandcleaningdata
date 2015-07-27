## GETTING AND CLEANING DATA COURSE PROJECT.

## Please read the readme.md file for details of downloading the dataset and the 
## associated default directory into which to unzip the data


## clearing all existing objects

rm(list = ls())
library(plyr) # load plyr first, then dplyr 
library(dplyr) # for fancy data table manipulations and organization
library(reshape2) # to allow for the creation of the cross tab

## Download the data
## create a working director called data. Dowload the zip file into this directory 
## and unzip the contents into the data directory
## set the working directory to refer to the data subdirectory


if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/getdata-projectfiles-UCI HAR Dataset.zip")
unzip(zipfile="./data/getdata-projectfiles-UCI HAR Dataset.zip",exdir="./data")
setwd("./data")        

## read in the features and the activity attributes files
features<-read.table("./UCI HAR Dataset/features.txt",header=FALSE)
activity_labels<-read.table("./UCI HAR Dataset/activity_labels.txt",header=FALSE)

## read in the test data set
x_test<-read.table("./UCI HAR Dataset/test/X_test.txt",header=FALSE)
y_test<-read.table("./UCI HAR Dataset/test/y_test.txt",header=FALSE)
subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt",header=FALSE)

## read in the training data set
x_train<-read.table("./UCI HAR Dataset/train/X_train.txt",header=FALSE)
y_train<-read.table("./UCI HAR Dataset/train/y_train.txt",header=FALSE)
subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt",header=FALSE)

## adding names to columns in the features and activity attributes files
colnames(features)<-c("features_id","features_name")
colnames(activity_labels)<-c("activity_id","activity_name")

## adding names to columns in the activity and subject id files for both train and testing
colnames(y_test)<-"activity_id"
colnames(y_train)<-"activity_id"
colnames(subject_test)<-"subject_id"
colnames(subject_train)<-"subject_id"

## using the features file to label the 56 columns of data in the x_test and x_train data
colnames(x_test)<-features$features_name
colnames(x_train)<-features$features_name

## 1.merge the data sets into a single file "combined"
## start with combining horizontally the three data sets for each of test and train. 
## combined test data is 2947 rows and 563 columns and combined train data is 
## 7351 rows and 563 columns 
## The next step is to then merge vertically the testdata and traindata to arrive at a table 
## that is 10299 rows and 563 columns

testdata<-cbind(subject_test,y_test,x_test)
traindata<-cbind(subject_train,y_train,x_train)
combined<-rbind(testdata,traindata)

## 2.Extracts only the measurements on the mean and standard deviation for each measurement. 

## Search for mean and std (using \\b) to ensure only mean and var are picked up 
# (and not other phrases that may contain variants of mean and var. Create a new 
## dataset combinedtrim that has only columns identified as mean or std by the grep formula

combinedtrim<-combined[,c("subject_id","activity_id",grep("\\bmean\\b", names(combined), value=TRUE),grep("\\bstd", names(combined), value=TRUE))]

## 3.Uses descriptive activity names to name the activities in the data set

## merge the trimmed data, now containing only the mean and standard deviation 
## data with the activity labels file loaded in above. Then remove the redundant activity_id column leaving
## only the description of the activity (activity_name)

finaldata <- merge(activity_labels, combinedtrim,key="activity_id")
finaldata<-finaldata[,-1]

## 4.Appropriately labels the data set with descriptive variable names. 

## relabel the t and f time and frequency indicators

names(finaldata) <- gsub('^f',"Frequency-",names(finaldata))
names(finaldata) <- gsub('^t',"Time-",names(finaldata))

## relabel the columns to make the titles more readable in english

names(finaldata) <- gsub('Acc',"Accelerometer",names(finaldata))
names(finaldata) <- gsub('Gyro',"Gyroscope",names(finaldata))
names(finaldata) <- gsub('Mag',"Magnitude",names(finaldata))
names(finaldata) <- gsub('BodyBody',"Body",names(finaldata))

names(finaldata) <- gsub('\\()',"",names(finaldata))
names(finaldata) <- gsub('-mean',"-Mean",names(finaldata))
names(finaldata) <- gsub('-std',"-StdDev",names(finaldata))

## 5.Creates a second, independent tidy data set with the average of each variable 
## for each activity and each subject.
## Using the reshape packge, first collapse (or melt) the data into a long form table. 
## then using dcast (from the reshape package) create a cross tab of activity_name, 
## participant_id and all of the measures in the data table

library(reshape2)
finaldatamelt<-melt(finaldata,id = c("subject_id","activity_name"))
alldatamean<-dcast(finaldatamelt, subject_id + activity_name ~ variable, mean)
                    
# Export the tidyData set
## write the reshaped data to a file called sensor_data_subset.txt

write.table(alldatamean, './sensor_data_subset.txt',row.names=FALSE)