---
title: "Readme.mdR"
author: "Greg Main"
date: "17 August 2015"
output: html_document
---
## Purpose of this repository
This repository was created to share and store the outputs from the Getting and Cleaning Data project. 

## Contents of the this repository
You will find in this repository:

2. Readme.md: this file
1. CodeBook.md: This contains information about the download and extraction of the raw data and the steps taken to transform the raw data into a tidy data set and then a second extracted tidy dataset
3. run_analysis.R: R script that downloads and transforms the raw data
4. sensor_data_subset.txt: The second extracted tidy dataset (independent tidy data set with the average of each variable for each activity and each subject) 

Further descriptions of each of these are set out below

Please read CodeBook.md next for further details of the raw data and the individual steps taken  to transform the data

## Project Description

The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. The project was graded by our peers on a series of yes/no questions related to the project. 

The project required the submission of 

1. a tidy data set as described below
2. a link to a Github repository with the script for performing the analysis
3. a code book that describes the variables, the data, and any transformations or work performed to clean up the data called CodeBook.md. 
4. a ReadMe in the repo to explain how all of the scripts work and how they are connected.  

## Project subject
The project involves downloading and analysing data from a wearable device. One of the most exciting areas in all of data science right now is wearable computing. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

## Requirements of the script and the tidy data set
An R script called run_analysis.R is required. It needs to do the following. 

1. Merge the training and the test sets to create one data set.
2. Extract only the measurements on the mean and standard deviation for each measurement. 
3. Use descriptive activity names to name the activities in the data set
4. Appropriately label the data set with descriptive variable names. 
5. Create from step 4 a second, independent tidy data set with the average of each variable for each activity and each subject.

## Important requirements and source data considerations
The script requires plyr, dplyr and reshape2 packages to be installed and present in order to run. The script assumes that these packages are installed and automatically runs the libray commands as required. Please ensure you have installed these packages before running the script 

The script also includes steps for downloading the data which can be found at

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The script downloads the zip archive and stores it in a sub folder ./data/UCI HAR Dataset. The data folder is created by the script which also then sets the working directory to this folder (./data/)

## Executing the script and results
Running the script: source('run_analysis.R')

Results of the script: sensor_data_subset.txt