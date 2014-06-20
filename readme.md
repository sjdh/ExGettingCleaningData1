Cleaning the Human Activity Recognition Using Smartphones Dataset
========================================================

# Overview

This is a project for the coursera course [Getting and Cleaning Data][1].


It deals with data about wearable computing from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
The data is collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained. 


This repository contains a script that download and cleans the Human Activity Recognition Using Smartphones Dataset Version 1.0. The dataset and the script are described in CodeBook.md


[1]: https://class.coursera.org/getdata-004/



# The Human Activity Recognition Using Smartphones Dataset

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 


# Files

This repository contains the following files
- README.md
- run_analysis.R - Downloads and cleans the dataset
- CodeBook.md -Describes the variables, the data, and the transformations in run_analysis.R



# Cleaning and tyding the data
run_anaylisis.R does the follwing

1. Downloads the dataset
1. Merges the training and the test sets to create one data set.
1. Extracts only the measurements on the mean and standard deviation for each measurement. 
1. Uses descriptive activity names to name the activities in the data set
1. Appropriately labels the data set with descriptive variable names. 
1. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
1. Writes the tiday data set to "human_activity_means.csv"


A more detailed description can be found in codebook.md
 