#' Codebook	
#' ========================================================	
#' 	
opts_chunk$set(echo=FALSE, results="markup", fig.width=10)	
#' 	
#' 	
#' 	
#' The Human Activity Recognition Using Smartphones Dataset contains data collected from the accelerometers from the Samsung Galaxy S smartphone. See http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 	
#' 	
#' 	
#' # Getting and cleaning the data	
#' 	
#' ## Download and extract the dataset	
#' 	
#' 	
#' The dataset is downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. 	
#' 	
#Check if the working directory exists and create it if necessary	
#dir = '/tmp/human_activity'	
#if (!file.exists(dir)) {	
#  dir.create(dir)	
#  print("Creating work directory")	
#}	
#setwd(dir)	
	
## Check if the raw data exists and download and extract it if necessary	
## Delete the compressed data	
if(!file.exists("UCI HAR Dataset")) {	
  if (!file.exists("data.zip")) {	
    print("Downloading raw data, please wait as it may take a while depending on your connection... :)")	
    fileurl = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"	
    download.file(fileurl, destfile = "data.zip", method = "curl")	
  }	
  print("Unzipping the raw data, please wait...")	
  unzip("data.zip")	
}	
unlink("data.zip")	
#' 	
#' After extraction, the direcotry contains the following files:	
#' 	
list.files(recursive=TRUE)	
#' 	
#' 	
#' 	
#' ## Reading the dataset 	
#' Each entry in this dataset records many features. The labels of the features are not specified in the main tables. We read the lables of these features from a separate file:	
#' 	
features <- read.table("UCI HAR Dataset/features.txt", header=FALSE, sep=' ', col.names=c('variable' , 'description'))	
#' 	
#' 	
#' The records are devided in a test set and a training set, which we both read:	
#' 	
test_data <- read.table("UCI HAR Dataset/test/X_test.txt", header=FALSE, col.names=features$description)  	
train_data <- read.table("UCI HAR Dataset/train/X_train.txt", header=FALSE, col.names=features$description)  	
#' 	
#' 	
#' Some information, like subject id, is not contained in these records. We have to read this information from separate files. 	
#' 	
#' Each record is associated to an activity and to subject. The activity id and the subject id are not included in the main record. 	
#' We read these ids for both the training set and the test set.	
#' 	
train_data$activity <- read.table("UCI HAR Dataset/train/y_train.txt", header=FALSE, col.names='activity')$activity	
test_data$activity  <-   read.table("UCI HAR Dataset/test/y_test.txt", header=FALSE, col.names='activity')$activity  	
train_data$subject <- read.table("UCI HAR Dataset/train/subject_train.txt", header=FALSE, col.names='subject')$subject  	
test_data$subject  <-  read.table("UCI HAR Dataset/test/subject_test.txt", header=FALSE, col.names='subject')$subject  	
#' 	
#' We also read the labels of the activities, to know which activity id corresonds to which activity.	
#' 	
activities = read.table("UCI HAR Dataset/activity_labels.txt", col.names=c("id", "activity"))	
#' 	
#' 	
#' 	
#' ## Merging	
#' We merge the test and train data into a single dataframe.	
#' 	
data <- rbind(train_data, test_data)	
#' 	
#' 	
#' 	
#' ## Subsetting	
#' The list of features looks like this	
#' 	
head(features, n=10)	
#' 	
#' It contains `r length(features[,1])` features. We are only interested in features with "mean" or  and "std" in the description. 	
#' 	
#' 	
#' 	
selected_features = subset(features, grepl("mean|std",description))	
#' 	
#' We select only those columns from the data plus subject and activity	
#' 	
selected_data = data[,c(selected_features[,1],562, 563)]	
#' 	
#' 	
#' ## Transforming	
#' We save the activites as factor	
#' 	
selected_data$activity = factor(selected_data$activity)	
levels(selected_data$activity) <- activities$activity	
#' 	
#' 	
#' Compute means of the observation variables for each person and each activity	
#' 	
tidy = aggregate(selected_data[, 1:79], by=list(selected_data$subject, selected_data$activity), FUN=mean, na.rm=TRUE)	
colnames(tidy)[1] <-"subject"	
colnames(tidy)[2] <-"activity"	
#' 	
#' 	
#' ## Saving	
#' Write the new dataset to a file	
#' 	
write.csv(tidy, "human_activity_means.csv")	
#' 	
#' 	
#' # Description of the tidy dataset	
#' The tidy dataset in human_activity_means.csv contains the mean values of 79 variables for 6 activities and 30 subjects. 	
#' This are the columns of the tiday dataset:	
#' 	
 str(tidy)	
#' 	
