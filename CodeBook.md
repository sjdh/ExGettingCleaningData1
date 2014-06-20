Codebook
========================================================



The Human Activity Recognition Using Smartphones Dataset contains data collected from the accelerometers from the Samsung Galaxy S smartphone. See http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 


# Getting and cleaning the data

## Download and extract the dataset


The dataset is downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. 

After extraction, the direcotry contains the following files:

```
##  [1] "CodeBook.html"                                               
##  [2] "CodeBook.md"                                                 
##  [3] "CodeBookoutfile"                                             
##  [4] "CodeBook.Rmd"                                                
##  [5] "human_activity_means.csv"                                    
##  [6] "readme.html"                                                 
##  [7] "readme.md"                                                   
##  [8] "readme.Rmd"                                                  
##  [9] "rmd2rscript.R"                                               
## [10] "run_analysis.R"                                              
## [11] "UCI HAR Dataset/activity_labels.txt"                         
## [12] "UCI HAR Dataset/features_info.txt"                           
## [13] "UCI HAR Dataset/features.txt"                                
## [14] "UCI HAR Dataset/README.txt"                                  
## [15] "UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt"   
## [16] "UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt"   
## [17] "UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt"   
## [18] "UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt"  
## [19] "UCI HAR Dataset/test/Inertial Signals/body_gyro_y_test.txt"  
## [20] "UCI HAR Dataset/test/Inertial Signals/body_gyro_z_test.txt"  
## [21] "UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt"  
## [22] "UCI HAR Dataset/test/Inertial Signals/total_acc_y_test.txt"  
## [23] "UCI HAR Dataset/test/Inertial Signals/total_acc_z_test.txt"  
## [24] "UCI HAR Dataset/test/subject_test.txt"                       
## [25] "UCI HAR Dataset/test/X_test.txt"                             
## [26] "UCI HAR Dataset/test/y_test.txt"                             
## [27] "UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt" 
## [28] "UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt" 
## [29] "UCI HAR Dataset/train/Inertial Signals/body_acc_z_train.txt" 
## [30] "UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt"
## [31] "UCI HAR Dataset/train/Inertial Signals/body_gyro_y_train.txt"
## [32] "UCI HAR Dataset/train/Inertial Signals/body_gyro_z_train.txt"
## [33] "UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt"
## [34] "UCI HAR Dataset/train/Inertial Signals/total_acc_y_train.txt"
## [35] "UCI HAR Dataset/train/Inertial Signals/total_acc_z_train.txt"
## [36] "UCI HAR Dataset/train/subject_train.txt"                     
## [37] "UCI HAR Dataset/train/X_train.txt"                           
## [38] "UCI HAR Dataset/train/y_train.txt"
```


## Reading the dataset 
Each entry in this dataset records many features. The labels of the features are not specified in the main tables. We read the lables of these features from a separate file:

```r
features <- read.table("UCI HAR Dataset/features.txt", header=FALSE, sep=' ', col.names=c('variable' , 'description'))
```

The records are devided in a test set and a training set, which we both read:

```r
test_data <- read.table("UCI HAR Dataset/test/X_test.txt", header=FALSE, col.names=features$description)  
train_data <- read.table("UCI HAR Dataset/train/X_train.txt", header=FALSE, col.names=features$description)  
```

Some information, like subject id, is not contained in these records. We have to read this information from separate files. 

Each record is associated to an activity and to subject. The activity id and the subject id are not included in the main record. 
We read these ids for both the training set and the test set.

```r
train_data$activity <- read.table("UCI HAR Dataset/train/y_train.txt", header=FALSE, col.names='activity')$activity
test_data$activity  <-   read.table("UCI HAR Dataset/test/y_test.txt", header=FALSE, col.names='activity')$activity  
train_data$subject <- read.table("UCI HAR Dataset/train/subject_train.txt", header=FALSE, col.names='subject')$subject  
test_data$subject  <-  read.table("UCI HAR Dataset/test/subject_test.txt", header=FALSE, col.names='subject')$subject  
```
We also read the labels of the activities, to know which activity id corresonds to which activity.

```r
activities = read.table("UCI HAR Dataset/activity_labels.txt", col.names=c("id", "activity"))
```


## Merging
We merge the test and train data into a single dataframe.

```r
data <- rbind(train_data, test_data)
```


## Subsetting
The list of features looks like this

```r
head(features, n=10)
```

```
##    variable       description
## 1         1 tBodyAcc-mean()-X
## 2         2 tBodyAcc-mean()-Y
## 3         3 tBodyAcc-mean()-Z
## 4         4  tBodyAcc-std()-X
## 5         5  tBodyAcc-std()-Y
## 6         6  tBodyAcc-std()-Z
## 7         7  tBodyAcc-mad()-X
## 8         8  tBodyAcc-mad()-Y
## 9         9  tBodyAcc-mad()-Z
## 10       10  tBodyAcc-max()-X
```
It contains 561 features. We are only interested in features with "mean" or  and "std" in the description. 



```r
selected_features = subset(features, grepl("mean|std",description))
```
We select only those columns from the data plus subject and activity

```r
selected_data = data[,c(selected_features[,1],562, 563)]
```

## Transforming
We save the activites as factor


Compute means of the observation variables for each person and each activity


## Saving
Write the new dataset to a file

```r
write.csv(tidy, "human_activity_means.csv")
```

# Description of the tidy dataset
The tidy dataset in human_activity_means.csv contains the mean values of 79 variables for 6 activities and 30 subjects. 
This are the columns of the tiday dataset:

```r
 str(tidy)
```

```
## 'data.frame':	180 obs. of  81 variables:
##  $ subject                        : int  1 2 3 4 5 6 7 8 9 10 ...
##  $ activity                       : Factor w/ 6 levels "WALKING","WALKING_UPSTAIRS",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ tBodyAcc.mean...X              : num  0.277 0.276 0.276 0.279 0.278 ...
##  $ tBodyAcc.mean...Y              : num  -0.0174 -0.0186 -0.0172 -0.0148 -0.0173 ...
##  $ tBodyAcc.mean...Z              : num  -0.111 -0.106 -0.113 -0.111 -0.108 ...
##  $ tBodyAcc.std...X               : num  -0.284 -0.424 -0.36 -0.441 -0.294 ...
##  $ tBodyAcc.std...Y               : num  0.1145 -0.0781 -0.0699 -0.0788 0.0767 ...
##  $ tBodyAcc.std...Z               : num  -0.26 -0.425 -0.387 -0.586 -0.457 ...
##  $ tGravityAcc.mean...X           : num  0.935 0.913 0.937 0.964 0.973 ...
##  $ tGravityAcc.mean...Y           : num  -0.2822 -0.3466 -0.262 -0.0859 -0.1004 ...
##  $ tGravityAcc.mean...Z           : num  -0.0681 0.08473 -0.13811 0.12776 0.00248 ...
##  $ tGravityAcc.std...X            : num  -0.977 -0.973 -0.978 -0.984 -0.979 ...
##  $ tGravityAcc.std...Y            : num  -0.971 -0.972 -0.962 -0.968 -0.962 ...
##  $ tGravityAcc.std...Z            : num  -0.948 -0.972 -0.952 -0.963 -0.965 ...
##  $ tBodyAccJerk.mean...X          : num  0.074 0.0618 0.0815 0.0784 0.0846 ...
##  $ tBodyAccJerk.mean...Y          : num  0.02827 0.01825 0.01006 0.00296 -0.01632 ...
##  $ tBodyAccJerk.mean...Z          : num  -4.17e-03 7.90e-03 -5.62e-03 -7.68e-04 8.32e-05 ...
##  $ tBodyAccJerk.std...X           : num  -0.114 -0.278 -0.269 -0.297 -0.303 ...
##  $ tBodyAccJerk.std...Y           : num  0.067 -0.0166 -0.045 -0.2212 -0.091 ...
##  $ tBodyAccJerk.std...Z           : num  -0.503 -0.586 -0.529 -0.751 -0.613 ...
##  $ tBodyGyro.mean...X             : num  -0.0418 -0.053 -0.0256 -0.0318 -0.0489 ...
##  $ tBodyGyro.mean...Y             : num  -0.0695 -0.0482 -0.0779 -0.0727 -0.069 ...
##  $ tBodyGyro.mean...Z             : num  0.0849 0.0828 0.0813 0.0806 0.0815 ...
##  $ tBodyGyro.std...X              : num  -0.474 -0.562 -0.572 -0.501 -0.491 ...
##  $ tBodyGyro.std...Y              : num  -0.0546 -0.5385 -0.5638 -0.6654 -0.5046 ...
##  $ tBodyGyro.std...Z              : num  -0.344 -0.481 -0.477 -0.663 -0.319 ...
##  $ tBodyGyroJerk.mean...X         : num  -0.09 -0.0819 -0.0952 -0.1153 -0.0888 ...
##  $ tBodyGyroJerk.mean...Y         : num  -0.0398 -0.0538 -0.0388 -0.0393 -0.045 ...
##  $ tBodyGyroJerk.mean...Z         : num  -0.0461 -0.0515 -0.0504 -0.0551 -0.0483 ...
##  $ tBodyGyroJerk.std...X          : num  -0.207 -0.39 -0.386 -0.492 -0.358 ...
##  $ tBodyGyroJerk.std...Y          : num  -0.304 -0.634 -0.639 -0.807 -0.571 ...
##  $ tBodyGyroJerk.std...Z          : num  -0.404 -0.435 -0.537 -0.64 -0.158 ...
##  $ tBodyAccMag.mean..             : num  -0.137 -0.29 -0.255 -0.312 -0.158 ...
##  $ tBodyAccMag.std..              : num  -0.22 -0.423 -0.328 -0.528 -0.377 ...
##  $ tGravityAccMag.mean..          : num  -0.137 -0.29 -0.255 -0.312 -0.158 ...
##  $ tGravityAccMag.std..           : num  -0.22 -0.423 -0.328 -0.528 -0.377 ...
##  $ tBodyAccJerkMag.mean..         : num  -0.141 -0.281 -0.28 -0.367 -0.288 ...
##  $ tBodyAccJerkMag.std..          : num  -0.0745 -0.1642 -0.1399 -0.3169 -0.2822 ...
##  $ tBodyGyroMag.mean..            : num  -0.161 -0.447 -0.466 -0.498 -0.356 ...
##  $ tBodyGyroMag.std..             : num  -0.187 -0.553 -0.562 -0.553 -0.492 ...
##  $ tBodyGyroJerkMag.mean..        : num  -0.299 -0.548 -0.566 -0.681 -0.445 ...
##  $ tBodyGyroJerkMag.std..         : num  -0.325 -0.558 -0.567 -0.73 -0.489 ...
##  $ fBodyAcc.mean...X              : num  -0.203 -0.346 -0.317 -0.427 -0.288 ...
##  $ fBodyAcc.mean...Y              : num  0.08971 -0.0219 -0.0813 -0.1494 0.00946 ...
##  $ fBodyAcc.mean...Z              : num  -0.332 -0.454 -0.412 -0.631 -0.49 ...
##  $ fBodyAcc.std...X               : num  -0.319 -0.458 -0.379 -0.447 -0.298 ...
##  $ fBodyAcc.std...Y               : num  0.056 -0.1692 -0.124 -0.1018 0.0426 ...
##  $ fBodyAcc.std...Z               : num  -0.28 -0.455 -0.423 -0.594 -0.483 ...
##  $ fBodyAcc.meanFreq...X          : num  -0.208 -0.146 -0.247 -0.139 -0.322 ...
##  $ fBodyAcc.meanFreq...Y          : num  0.11309 0.19859 0.17174 0.01235 -0.00204 ...
##  $ fBodyAcc.meanFreq...Z          : num  0.0497 0.0689 0.0749 -0.0788 0.0247 ...
##  $ fBodyAccJerk.mean...X          : num  -0.171 -0.305 -0.305 -0.359 -0.345 ...
##  $ fBodyAccJerk.mean...Y          : num  -0.0352 -0.0788 -0.1405 -0.2796 -0.1811 ...
##  $ fBodyAccJerk.mean...Z          : num  -0.469 -0.555 -0.514 -0.729 -0.59 ...
##  $ fBodyAccJerk.std...X           : num  -0.134 -0.314 -0.297 -0.297 -0.321 ...
##  $ fBodyAccJerk.std...Y           : num  0.10674 -0.01533 -0.00561 -0.2099 -0.05452 ...
##  $ fBodyAccJerk.std...Z           : num  -0.535 -0.616 -0.544 -0.772 -0.633 ...
##  $ fBodyAccJerk.meanFreq...X      : num  -0.2093 -0.0727 -0.216 -0.1353 -0.3594 ...
##  $ fBodyAccJerk.meanFreq...Y      : num  -0.386 -0.264 -0.259 -0.386 -0.534 ...
##  $ fBodyAccJerk.meanFreq...Z      : num  -0.186 -0.255 -0.347 -0.326 -0.344 ...
##  $ fBodyGyro.mean...X             : num  -0.339 -0.43 -0.438 -0.373 -0.373 ...
##  $ fBodyGyro.mean...Y             : num  -0.103 -0.555 -0.562 -0.688 -0.514 ...
##  $ fBodyGyro.mean...Z             : num  -0.256 -0.397 -0.418 -0.601 -0.213 ...
##  $ fBodyGyro.std...X              : num  -0.517 -0.604 -0.615 -0.543 -0.529 ...
##  $ fBodyGyro.std...Y              : num  -0.0335 -0.533 -0.5689 -0.6547 -0.5027 ...
##  $ fBodyGyro.std...Z              : num  -0.437 -0.56 -0.546 -0.716 -0.42 ...
##  $ fBodyGyro.meanFreq...X         : num  0.01478 0.00728 0.03376 -0.12715 -0.04586 ...
##  $ fBodyGyro.meanFreq...Y         : num  -0.0658 -0.0427 -0.038 -0.2747 -0.0192 ...
##  $ fBodyGyro.meanFreq...Z         : num  0.000773 0.139752 -0.044508 0.149852 0.167458 ...
##  $ fBodyAccMag.mean..             : num  -0.129 -0.324 -0.29 -0.451 -0.305 ...
##  $ fBodyAccMag.std..              : num  -0.398 -0.577 -0.456 -0.651 -0.52 ...
##  $ fBodyAccMag.meanFreq..         : num  0.191 0.393 0.113 0.382 0.15 ...
##  $ fBodyBodyAccJerkMag.mean..     : num  -0.0571 -0.1691 -0.1868 -0.3186 -0.2695 ...
##  $ fBodyBodyAccJerkMag.std..      : num  -0.1035 -0.1641 -0.0899 -0.3205 -0.3057 ...
##  $ fBodyBodyAccJerkMag.meanFreq.. : num  0.09382 0.2075 -0.11716 0.11149 -0.00497 ...
##  $ fBodyBodyGyroMag.mean..        : num  -0.199 -0.531 -0.57 -0.609 -0.484 ...
##  $ fBodyBodyGyroMag.std..         : num  -0.321 -0.652 -0.633 -0.594 -0.59 ...
##  $ fBodyBodyGyroMag.meanFreq..    : num  0.2688 0.3053 0.1809 0.0697 0.2506 ...
##  $ fBodyBodyGyroJerkMag.mean..    : num  -0.319 -0.583 -0.608 -0.724 -0.548 ...
##  $ fBodyBodyGyroJerkMag.std..     : num  -0.382 -0.558 -0.549 -0.758 -0.456 ...
##  $ fBodyBodyGyroJerkMag.meanFreq..: num  0.1907 0.1263 0.0458 0.2654 0.0527 ...
```

## Feature Selected

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean
