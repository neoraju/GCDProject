# For the purpose of this assignment I assume that the user has already downloaded the data and copied it in the current working directory. 
# Please do not change the name of the folders or subfolders
#Main folder name is -> UCI HAR Dataset.

##########     DATA DOWNLOAD & UNZIPPING CODE       ##########
# if the data not downloaded the following code can be run to download and unzip into current directory.
# Download and unzip dataset if necessary
#if (!file.exists("./UCI HAR Dataset.zip")) {
#  download.file(
#    url="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
#    method="curl",
#    destfile="./UCI HAR Dataset.zip")
#  unzip("./UCI HAR Dataset.zip", exdir="./")
#}
require(dplyr)
require(tidyr)
# Read column and activity names
Features_Names<-read.table("./UCI HAR Dataset/features.txt", sep='', stringsAsFactors=FALSE)[[2]]
####        TASK 1
#  Merges the training and the test sets to create one data set
Measure_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
Measure_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
Measure_data<-rbind(Measure_test, Measure_train)
colnames(Measure_data) <- Features_Names

####        TASK 2
# Extracts only the measurements on the mean and standard deviation for each measurement. 
Keep_vars <- grep(Features_Names, pattern = "(mean|std)",ignore.case=TRUE)
Measure_data <- Measure_data[,Keep_vars]

####        TASK 3    and   TASK 4
# Appropriately labels the data set with descriptive variable names
# Uses descriptive activity names to name the activities in the data set
# Read the train data subject Ids
Activity_Labels <- read.table("./UCI HAR Dataset/activity_labels.txt",col.names= c("Activity_id","Activity_name"))
Activity_train <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names=c("Activity_id"))
Subjects_train  <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names=c("Subject_id"))
# Convert numeric activity labels to descriptive text
new_train<-as.factor(Activity_Labels$Activity_name)
old_train<-as.numeric(Activity_Labels$Activity_id)
Activity_train$Activity_id<-new_train[match(Activity_train$Activity_id, old_train)]
# Read the test data subject Ids
Activity_test <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names=c("Activity_id"))
Subjects_test  <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names=c("Subject_id"))
# Convert numeric activity labels to descriptive text
new_test<-as.factor(Activity_Labels$Activity_name)
old_test<-as.numeric(Activity_Labels$Activity_id)
Activity_test$Activity_id<-new_test[match(Activity_test$Activity_id, old_test)]
## combining Subject id data, activity data and adding them to measurement data
Subjects_test$group<-"test"
Subjects_train$group<-"train"
Subjects_data<- rbind ( cbind(Subjects_test, Activity_test), cbind(Subjects_train, Activity_train))
Full_data<-cbind(Subjects_data,Measure_data)

####        TASK 5
#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Tidy_data <- ddply(Full_data, .(Subject_id, Activity_id), numcolwise(mean))
# output the data set
write.table(Tidy_data, "Tidy_data.txt", row.names = F)
